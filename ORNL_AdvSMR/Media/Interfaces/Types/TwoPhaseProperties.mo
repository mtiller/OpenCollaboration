within ORNL_AdvSMR.Media.Interfaces.Types;
record TwoPhaseProperties
  "Properties for 2-phase fluidsstandard properties for two phase fluids"
  extends StandardProperties;
  SaturationProperties sat "Saturation property record";
  annotation (defaultComponentName="properties");
end TwoPhaseProperties;
