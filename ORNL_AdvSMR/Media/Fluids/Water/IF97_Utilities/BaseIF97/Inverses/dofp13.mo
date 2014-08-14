within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function dofp13 "density at the boundary between regions 1 and 3"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Density d "density";
protected
  Real p2 "auxiliary variable";
  Real[3] o "vector of auxiliary variables";
algorithm
  p2 := 7.1 - 6.04960677555959e-8*p;
  o[1] := p2*p2;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  d := 57.4756752485113/(0.0737412153522555 + p2*(0.00145092247736023 + p2*(
    0.000102697173772229 + p2*(0.0000114683182476084 + p2*(1.99080616601101e-6
     + o[1]*p2*(1.13217858826367e-8 + o[2]*o[3]*p2*(1.35549330686006e-17 + o[1]
    *(-3.11228834832975e-19 + o[1]*o[2]*(-7.02987180039442e-22 + p2*(
    3.29199117056433e-22 + (-5.17859076694812e-23 + 2.73712834080283e-24*p2)*p2))))))))));

end dofp13;
