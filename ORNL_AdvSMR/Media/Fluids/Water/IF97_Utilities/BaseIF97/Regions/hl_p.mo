within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hl_p
  "liquid specific enthalpy on the boundary between regions 4 and 3 or 1"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := hvl_p(p, boilingcurve_p(p));
end hl_p;
