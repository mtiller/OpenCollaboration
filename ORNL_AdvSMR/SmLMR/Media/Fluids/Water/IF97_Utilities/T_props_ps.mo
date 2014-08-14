within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function T_props_ps "temperature as function of pressure and specific entropy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Common.IF97BaseTwoPhase properties "auxiliary record";
  output SI.Temperature T "temperature";
algorithm
  T := properties.T;
  annotation (Inline=false, LateInline=true);
end T_props_ps;
