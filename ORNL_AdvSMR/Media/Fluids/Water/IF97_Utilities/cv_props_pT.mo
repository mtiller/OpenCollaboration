within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function cv_props_pT
  "specific heat capacity at constant volume as function of pressure and temperature"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificHeatCapacity cv "specific heat capacity";
algorithm
  cv := aux.cv;
  annotation (Inline=false, LateInline=true);
end cv_props_pT;
