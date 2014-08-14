within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function rho_props_ps "density as function of pressure and specific entropy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Common.IF97BaseTwoPhase properties "auxiliary record";
  output SI.Density rho "density";
algorithm
  rho := properties.rho;
  annotation (Inline=false, LateInline=true);
end rho_props_ps;
