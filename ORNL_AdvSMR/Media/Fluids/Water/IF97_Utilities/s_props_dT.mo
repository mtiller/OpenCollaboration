within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function s_props_dT "specific entropy as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "Temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificEntropy s "specific entropy";
algorithm
  s := aux.s;
  annotation (Inline=false, LateInline=true);
end s_props_dT;
