within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function beta_dT
  "isobaric expansion coefficient as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
algorithm
  beta := beta_props_dT(
    d,
    T,
    waterBaseProp_dT(
      d,
      T,
      phase,
      region));
end beta_dT;
