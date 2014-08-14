within ORNL_AdvSMR.Media.Interfaces.PartialMedium.Choices;
type pd = enumeration(
    default "Default (no boundary condition for p or d)",
    p_known "p_known (pressure p is known)",
    d_known "d_known (density d is known)")
  "Enumeration defining whether p or d are known for the boundary condition"
  annotation (Evaluate=true);
