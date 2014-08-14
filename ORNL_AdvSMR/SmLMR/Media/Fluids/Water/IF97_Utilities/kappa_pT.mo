within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function kappa_pT
  "isothermal compressibility factor as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.IsothermalCompressibility kappa "isothermal compressibility factor";
algorithm
  kappa := kappa_props_pT(
                p,
                T,
                waterBaseProp_pT(
                  p,
                  T,
                  region));
  annotation (InlineNoEvent=false);
end kappa_pT;
