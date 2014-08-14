within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function h_props_ps "specific enthalpy as function or pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := aux.h;
  annotation (Inline=false, LateInline=true);
end h_props_ps;
