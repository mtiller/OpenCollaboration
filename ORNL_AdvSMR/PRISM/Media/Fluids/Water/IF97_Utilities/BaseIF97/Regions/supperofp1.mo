within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function supperofp1
  "explicit upper specific entropy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real pi1 "dimensionless pressure";
  Real[3] o "vector of auxiliary variables";
algorithm
  pi1 := 7.1 - p/data.PSTAR1;
  assert(p > triple.ptriple,
    "IF97 medium function supperofp1 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := pi1*pi1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  s := 461.526*(7.28316418503422 + pi1*(0.070602197808399 + pi1
    *(0.0039229343647356 + pi1*(0.000313009170788845 + pi1*(
    0.0000303619398631619 + pi1*(7.46739440045781e-6 + o[1]*pi1
    *(3.40562176858676e-8 + o[2]*o[3]*pi1*(4.21886233340801e-17
     + o[1]*(-9.44504571473549e-19 + o[1]*o[2]*(-2.06859611434475e-21
     + pi1*(9.60758422254987e-22 + (-1.49967810652241e-22 +
    7.86863124555783e-24*pi1)*pi1)))))))))));
end supperofp1;
