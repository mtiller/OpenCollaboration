within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function cp_ph
  "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.SpecificHeatCapacity cp "specific heat capacity";
algorithm
  cp := cp_props_ph(
    p,
    h,
    waterBaseProp_ph(
      p,
      h,
      phase,
      region));
end cp_ph;
