within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function cv_ph
  "specific heat capacity at constant volume as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificHeatCapacity cv "specific heat capacity";
algorithm
  cv := cv_props_ph(
    p,
    h,
    waterBaseProp_ph(
      p,
      h,
      phase,
      region));
end cv_ph;
