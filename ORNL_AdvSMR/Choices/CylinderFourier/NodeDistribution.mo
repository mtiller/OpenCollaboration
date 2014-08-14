within ORNL_AdvSMR.Choices.CylinderFourier;
type NodeDistribution = enumeration(
    uniform "Uniform distribution of node radii",
    thickInternal "Quadratically distributed node radii - thickest at rint",
    thickExternal "Quadratically distributed node radii - thickest at rext",
    thickBoth
      "Quadratically distributed node radii - thickest at both extremes")
  "Type, constants and menu choices for node distribution";
