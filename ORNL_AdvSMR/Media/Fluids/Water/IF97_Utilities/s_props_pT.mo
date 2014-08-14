within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function s_props_pT "specific entropy as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificEntropy s "specific entropy";
algorithm
  s := aux.s;
  annotation (Inline=false, LateInline=true);
end s_props_pT;
