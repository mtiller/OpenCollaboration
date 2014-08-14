within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function drhol_dp "derivative of density of saturated water w.r.t. pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p "saturation pressure";
  output SI.DerDensityByPressure dd_dp
    "derivative of density of water at the boiling point";
algorithm
  dd_dp := drhovl_dp(p, boilingcurve_p(p));
end drhol_dp;
