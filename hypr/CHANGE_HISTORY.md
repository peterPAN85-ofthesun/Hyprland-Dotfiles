# Change History Document

## Overview
- **Date**: 2026-02-22
- **Purpose**: Fix visual artifacts (screen glitches) in Godot 4.6 game engine on Hyprland/Wayland with NVIDIA GPU
- **Scope**: Hyprland configuration modifications to resolve rendering issues

## Executive Summary

This document chronicles configuration changes made to resolve visual artifacts experienced when running Godot 4.6 on an Arch Linux system with Hyprland 0.53.3 (Wayland compositor) and NVIDIA RTX 4060 Laptop GPU (nvidia-open driver 590.48). The artifacts persisted even when attempting to force XWayland mode via GDK_BACKEND=x11, indicating the issue was related to compositor or GPU configuration rather than the display server protocol itself.

The solution involved two primary modifications: (1) adding essential NVIDIA-specific environment variables for proper Wayland rendering, and (2) disabling compositor visual effects (blur and dim) for Godot windows to prevent interference with the engine's rendering pipeline.

## Detailed Change Inventory

### /home/gregoire/.config/hypr/custom/env.conf

**Current State**:
The environment configuration file existed but lacked NVIDIA-specific Wayland environment variables required for optimal rendering with the proprietary NVIDIA driver stack on Wayland compositors.

**Planned Modifications**:
Added three critical NVIDIA environment variables:
```conf
GBM_BACKEND=nvidia-drm
__GLX_VENDOR_LIBRARY_NAME=nvidia
LIBVA_DRIVER_NAME=nvidia
```

**Rationale**:
- `GBM_BACKEND=nvidia-drm`: Directs Generic Buffer Management (GBM) to use NVIDIA's DRM backend instead of the default mesa implementation. This is essential for proper buffer allocation and presentation on NVIDIA hardware under Wayland.
- `__GLX_VENDOR_LIBRARY_NAME=nvidia`: Ensures GLX (OpenGL Extension to X11) uses NVIDIA's vendor library rather than falling back to Mesa. While primarily an X11 technology, this affects XWayland applications and some compatibility layers.
- `LIBVA_DRIVER_NAME=nvidia`: Configures Video Acceleration API (VA-API) to use the NVIDIA driver for hardware video acceleration, ensuring consistent GPU utilization.

**Impact Analysis**:
- Dependencies affected: All applications running under Hyprland, particularly OpenGL/Vulkan applications and games
- Breaking changes: None expected. These variables enhance NVIDIA functionality but should not negatively impact non-NVIDIA codepaths
- Performance implications: Positive - proper buffer management should reduce rendering overhead and potential stuttering
- Security considerations: None - these are standard NVIDIA configuration variables

**Technical Background**:
The absence of these variables can cause the system to fall back to software rendering paths or incompatible buffer management strategies, leading to visual corruption, tearing, or artifacts. NVIDIA's Wayland support requires explicit configuration due to architectural differences from Mesa-based drivers.

### /home/gregoire/.config/hypr/custom/rules.conf

**Current State**:
The window rules configuration existed but contained no specific rules for the Godot application class, allowing default compositor effects to apply.

**Planned Modifications**:
Added two window-specific rules for Godot:
```conf
windowrule = match:class ^(Godot)$, no_blur on
windowrule = match:class ^(Godot)$, no_dim on
```

**Rationale**:
Compositor effects like blur and dimming operate by manipulating the framebuffer or applying post-processing shaders. When these effects interact with a complex rendering engine like Godot (which manages its own framebuffer, performs multipass rendering, and uses advanced graphics techniques), they can cause:
- Temporal artifacts from conflicting frame timing
- Visual glitches from shader interactions
- Color banding or distortion from multiple processing passes
- Performance degradation from unnecessary GPU operations

Disabling these effects for Godot windows ensures the compositor passes through Godot's output without modification.

**Impact Analysis**:
- Dependencies affected: Only Godot application windows (class matches ^(Godot)$)
- Breaking changes: None - this is purely additive and scoped to Godot
- Performance implications: Positive - reduced compositor overhead for Godot windows
- Security considerations: None

**Implementation Notes**:
During troubleshooting, an attempt was made to add `xwayland on` as a window rule based on the initial hypothesis that forcing XWayland mode would resolve the issue. However, this was removed because:
1. `xwayland` is not a valid Hyprland window rule property
2. XWayland enforcement via GDK_BACKEND=x11 had already been tested and did not resolve the artifacts
3. The actual issue was compositor interference, not the Wayland/X11 protocol choice

## Implementation Sequence

1. **Add NVIDIA environment variables** (`env.conf` modification)
   - **Reasoning**: Environment variables must be set before the compositor starts and before any applications launch. This ensures the entire session uses correct NVIDIA rendering paths.
   - **Action**: Append the three NVIDIA variables to the existing env.conf file.

2. **Add Godot window rules** (`rules.conf` modification)
   - **Reasoning**: Window rules can be applied dynamically when Godot launches. This step is independent of environment variables.
   - **Action**: Append the blur and dim disable rules to the existing rules.conf file.

3. **Restart Hyprland**
   - **Reasoning**: Environment variables in env.conf only take effect when Hyprland starts. Window rules can be reloaded, but a full restart ensures both changes are active.
   - **Action**: Log out and log back in, or restart the Hyprland compositor.

4. **Test Godot 4.6**
   - **Reasoning**: Verify that visual artifacts are resolved with default Vulkan renderer.
   - **Action**: Launch Godot and observe for any remaining glitches.

## Risk Assessment

**High Risk Areas**:
- Environment variable changes affect all applications: If the NVIDIA variables are incorrectly set or conflict with other configuration, it could impact system-wide rendering. However, these are standard NVIDIA-recommended variables with low risk of negative interaction.

**Mitigation Strategies**:
- Changes are confined to user configuration files (~/.config/hypr/) and do not affect system-level configuration
- All modified files can be easily reverted by removing the added lines
- Both modifications are well-documented in NVIDIA and Hyprland communities

**Rollback Plan**:
If issues arise after these changes:
1. Remove the three lines added to `/home/gregoire/.config/hypr/custom/env.conf`
2. Remove the two lines added to `/home/gregoire/.config/hypr/custom/rules.conf`
3. Restart Hyprland
4. System will return to previous state

## Testing Requirements

**Primary Test**: Godot 4.6 Visual Artifact Verification
- Launch Godot 4.6 normally (default Vulkan renderer)
- Create or open a 3D project
- Observe editor viewport during camera movement, object manipulation, and scene playback
- Expected outcome: No visual artifacts, tearing, or glitches

**Secondary Test**: System-Wide Rendering Verification
- Launch other OpenGL/Vulkan applications (games, 3D tools, browsers)
- Verify no regression in rendering quality or performance
- Expected outcome: Equal or improved rendering quality

**Performance Test**:
- Monitor GPU utilization with `nvidia-smi` while running Godot
- Verify proper GPU acceleration is active
- Expected outcome: Normal GPU usage patterns, no CPU fallback rendering

## Fallback Solutions

If visual artifacts persist after implementing the above changes, the following escalation path is recommended:

**Option 1: Switch Godot to OpenGL Renderer**
- Command: `godot --rendering-driver opengl3`
- Rationale: OpenGL rendering path may have better compatibility with current NVIDIA Wayland configuration than Vulkan
- If successful: Change default renderer in Godot Project Settings (Rendering > Driver) to make permanent

**Option 2: Force XWayland for Godot**
- While this was attempted via GDK_BACKEND=x11, a more targeted approach would be to create a launcher script that sets environment variables specifically for Godot
- Note: This was already tested and did not resolve the issue, but may behave differently with NVIDIA variables now configured

**Option 3: NVIDIA Driver Investigation**
- Verify nvidia-open 590.48 is fully compatible with Hyprland 0.53.3
- Consider testing nvidia-dkms proprietary driver as alternative
- Check NVIDIA forums for known Wayland compatibility issues with RTX 4060 Laptop GPU

## Dependencies and Prerequisites

**Required for changes to take effect**:
- Hyprland compositor restart (logout/login or compositor reload)
- NVIDIA driver must remain at version 590.48 or compatible version
- Hyprland must be at version 0.53.3 or compatible version

**No additional dependencies**: These changes use built-in Hyprland configuration mechanisms and standard NVIDIA environment variables.

## Expected Outcomes

**Immediate Results**:
- Complete elimination or significant reduction of visual artifacts in Godot 4.6
- Stable rendering during editor use and game testing
- Proper GPU acceleration utilized by Godot

**Long-term Benefits**:
- Improved stability for all NVIDIA-accelerated applications under Hyprland
- Better performance due to correct buffer management
- Reduced compositor overhead for creative applications like Godot

**Success Criteria**:
- User can work in Godot 4.6 editor without visual glitches
- 3D viewport renders cleanly during manipulation and playback
- No regression in other applications

## Notes and Considerations

**NVIDIA on Wayland Context**:
NVIDIA's Wayland support has historically been more complex than AMD/Intel due to architectural differences in driver design. The nvidia-open driver (used here) represents NVIDIA's newer open-source kernel module effort, which has improving but still maturing Wayland support. The environment variables added are considered essential for NVIDIA Wayland functionality in 2026.

**Hyprland-Specific Considerations**:
Hyprland is a dynamic tiling Wayland compositor with extensive visual effects. While these effects enhance the desktop experience, they can interfere with applications that perform their own complex rendering. The window rules approach (disabling effects per-application) is the recommended Hyprland pattern for compatibility.

**Godot Engine Rendering**:
Godot 4.x uses Vulkan as the default renderer for its forward+ and mobile rendering backends. Vulkan's explicit nature means it's more sensitive to proper GPU/compositor configuration than OpenGL. The changes made address the compositor side; if issues persist, the rendering backend is a logical next investigation point.

**Window Class Matching**:
The regex `^(Godot)$` matches windows with class exactly "Godot". If Godot uses different class names for different windows (editor vs. game), this may need expansion. Verify with `hyprctl clients` if needed.

## Additional Resources

- Hyprland NVIDIA guide: https://wiki.hyprland.org/Nvidia/
- NVIDIA Wayland environment variables: https://download.nvidia.com/XFree86/Linux-x86_64/590.48/README/
- Godot rendering drivers documentation: https://docs.godotengine.org/en/stable/tutorials/rendering/

## Revision History

- 2026-02-22: Initial document creation - NVIDIA environment variables and Godot window rules added to fix visual artifacts
