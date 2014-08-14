within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhol_p "density of saturated water"
  extends Modelica.Icons.Function;
  input SI.Pressure p "saturation pressure";
  output SI.Density rho "density of steam at the condensation point";
algorithm
  rho := rhovl_p(p, boilingcurve_p(p));
end rhol_p;
