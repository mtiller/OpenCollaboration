within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhov_p "density of saturated vapour"
  extends Modelica.Icons.Function;
  input SI.Pressure p "saturation pressure";
  output SI.Density rho "density of steam at the condensation point";
algorithm
  rho := rhovl_p(p, dewcurve_p(p));
end rhov_p;
