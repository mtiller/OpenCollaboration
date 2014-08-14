within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hv_p
  "vapour specific enthalpy on the boundary between regions 4 and 3 or 2"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := hvl_p(p, dewcurve_p(p));
end hv_p;
