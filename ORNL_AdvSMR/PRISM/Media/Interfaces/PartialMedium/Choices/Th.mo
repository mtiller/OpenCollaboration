within ORNL_AdvSMR.PRISM.Media.Interfaces.PartialMedium.Choices;
type Th = enumeration(
    default "Default (no boundary condition for T or h)",
    T_known "T_known (temperature T is known)",
    h_known "h_known (specific enthalpy h is known)")
  "Enumeration defining whether T or h are known as boundary condition"
  annotation (Evaluate=true);
