within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function supperofp2
  "explicit upper specific entropy limit of region 2 as function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real pi "dimensionless pressure";
  Real[2] o "vector of auxiliary variables";
algorithm
  pi := p/data.PSTAR2;
  assert(p > triple.ptriple,
    "IF97 medium function supperofp2 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := pi*pi;
  o[2] := o[1]*o[1]*o[1];
  s := 8505.73409708683 - 461.526*Modelica.Math.log(pi) + pi*(-3.36563543302584
     + pi*(-0.00790283552165338 + pi*(0.0000915558349202221 +
    pi*(-1.59634706513e-7 + pi*(3.93449217595397e-18 + pi*(-1.18367426347994e-13
     + pi*(2.72575244843195e-15 + pi*(7.04803892603536e-26 + pi
    *(6.67637687381772e-35 + pi*(3.1377970315132e-24 + (-7.04844558482265e-77
     + o[1]*(-7.46289531275314e-137 + (1.55998511254305e-68 +
    pi*(-3.46166288915497e-72 + pi*(7.51557618628583e-132 + (-1.64086406733212e-106
     + 1.75648443097063e-87*pi)*pi)))*o[1]))*o[2]*o[2]))))))))));
end supperofp2;
