within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function rho_pT "density as function or pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SI.Density rho "density";
algorithm
  rho := rho_props_pT(
    p,
    T,
    waterBaseProp_pT(
      p,
      T,
      region));
end rho_pT;
