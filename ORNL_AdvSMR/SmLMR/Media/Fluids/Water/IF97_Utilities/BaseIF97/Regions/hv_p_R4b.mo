within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hv_p_R4b
  "explicit approximation of vapour specific enthalpy on the boundary between regions 4 and 3"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real x "auxiliary variable";
algorithm
  // boundary between region IVa and III
  x := Modelica.Math.acos(p/data.PCRIT);
  h := (1 + x*(0.4880153718655694 + x*(0.2079670746250689 + x*(
    -6.084122698421623 + x*(25.08887602293532 + x*(-48.38215180269516
     + x*(45.66489164833212 + (-16.98555442961553 +
    0.0006616936460057691*x)*x)))))))*data.HCRIT;
end hv_p_R4b;
