within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function drhov_dp "derivative of density of saturated steam w.r.t. pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p "saturation pressure";
  output SI.DerDensityByPressure dd_dp
    "derivative of density of water at the boiling point";
algorithm
  dd_dp := drhovl_dp(p, dewcurve_p(p));
end drhov_dp;
