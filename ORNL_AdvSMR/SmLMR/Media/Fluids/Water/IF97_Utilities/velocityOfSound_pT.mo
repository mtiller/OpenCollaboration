within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function velocityOfSound_pT
  "speed of sound as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.Velocity v_sound "speed of sound";
algorithm
  v_sound := velocityOfSound_props_pT(
                p,
                T,
                waterBaseProp_pT(
                  p,
                  T,
                  region));
end velocityOfSound_pT;
