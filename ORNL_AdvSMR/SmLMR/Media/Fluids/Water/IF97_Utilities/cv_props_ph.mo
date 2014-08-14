within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function cv_props_ph
  "specific heat capacity at constant volume as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificHeatCapacity cv "specific heat capacity";
algorithm
  cv := aux.cv;
  annotation (Inline=false, LateInline=true);
end cv_props_ph;
