within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function sv_p_R4b
  "explicit approximation of vapour specific entropy on the boundary between regions 4 and 3"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s;
protected
  Real x "auxiliary variable";
algorithm

  // documentation of accuray in notebook ~hubertus/props/IAPWS/R3Approx.nb
  // boundary between region IVa and III
  x := Modelica.Math.acos(p/data.PCRIT);
  s := (1 + x*(0.35682641826674344 + x*(0.1642457027815487 + x*
    (-4.425350377422446 + x*(18.324477859983133 + x*(-35.338631625948665
     + x*(33.36181025816282 + (-12.408711490585757 +
    0.0004810049834109226*x)*x)))))))*data.SCRIT;
end sv_p_R4b;
