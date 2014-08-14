within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function dhot1ofp "density at upper temperature limit of region 1"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Density d "density";
protected
  Real pi "dimensionless pressure";
  Real pi1 "dimensionless pressure";
  Real[4] o "auxiliary variables";
algorithm
  pi := p/data.PSTAR1;
  pi1 := 7.1 - pi;
  o[1] := pi1*pi1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := o[3]*o[3];
  d := 57.4756752485113/(0.0737412153522555 +
    0.000102697173772229*o[1] + 1.99080616601101e-6*o[2] +
    1.35549330686006e-17*o[2]*o[4] - 3.11228834832975e-19*o[1]*
    o[2]*o[4] - 7.02987180039442e-22*o[2]*o[3]*o[4] -
    5.17859076694812e-23*o[1]*o[2]*o[3]*o[4] +
    0.00145092247736023*pi1 + 0.0000114683182476084*o[1]*pi1 +
    1.13217858826367e-8*o[1]*o[2]*pi1 + 3.29199117056433e-22*o[
    2]*o[3]*o[4]*pi1 + 2.73712834080283e-24*o[1]*o[2]*o[3]*o[4]
    *pi1);
end dhot1ofp;
