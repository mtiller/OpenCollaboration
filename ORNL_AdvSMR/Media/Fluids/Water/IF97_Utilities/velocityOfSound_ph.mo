within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function velocityOfSound_ph
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.Velocity v_sound "speed of sound";
algorithm
  v_sound := velocityOfSound_props_ph(
    p,
    h,
    waterBaseProp_ph(
      p,
      h,
      phase,
      region));
end velocityOfSound_ph;
