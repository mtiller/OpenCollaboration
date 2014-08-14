within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function dhl_dp
  "derivative of liquid specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.DerEnthalpyByPressure dh_dp
    "specific enthalpy derivative w.r.t. pressure";
algorithm
  dh_dp := hvl_dp(p, boilingcurve_p(p));
end dhl_dp;
