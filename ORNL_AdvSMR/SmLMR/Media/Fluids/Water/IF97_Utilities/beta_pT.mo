within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function beta_pT
  "isobaric expansion coefficient as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
algorithm
  beta := beta_props_pT(
                p,
                T,
                waterBaseProp_pT(
                  p,
                  T,
                  region));
  annotation (InlineNoEvent=false);
end beta_pT;
