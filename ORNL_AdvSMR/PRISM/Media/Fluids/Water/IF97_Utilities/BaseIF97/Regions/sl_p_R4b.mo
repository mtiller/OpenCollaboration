within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function sl_p_R4b
  "explicit approximation of liquid specific entropy on the boundary between regions 4 and 3"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real x "auxiliary variable";
algorithm
  // boundary between region IVa and III
  x := Modelica.Math.acos(p/data.PCRIT);
  s := (1 + x*(-0.36160692245648063 + x*(0.9962778630486647 + x
    *(-2.8595548144171103 + x*(4.906301159555333 + x*(-4.974092309614206
     + x*(2.6249651699204457 + (-0.5319954375299023 -
    0.00008064497431880644*x)*x)))))))*data.SCRIT;
end sl_p_R4b;
