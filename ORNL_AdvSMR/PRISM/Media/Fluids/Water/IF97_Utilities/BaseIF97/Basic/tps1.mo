within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tps1 "inverse function for region 1: T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temperature T "temperature (K)";
protected
  constant SI.Pressure pstar=1.0e6;
  constant SI.SpecificEntropy sstar=1.0e3;
  Real pi "dimensionless pressure";
  Real sigma1 "dimensionless specific entropy";
  Real[6] o "vector of auxiliary variables";
algorithm
  pi := p/pstar;
  assert(p > triple.ptriple,
    "IF97 medium function tps1 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");

  sigma1 := s/sstar + 2.0;
  o[1] := sigma1*sigma1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := o[3]*o[3];
  o[5] := o[4]*o[4];
  o[6] := o[1]*o[2]*o[4];

  T := 174.782680583070 + sigma1*(34.806930892873 + sigma1*(
    6.5292584978455 + (0.33039981775489 + o[3]*(-1.92813829231960e-7
     - 2.49091972445730e-23*o[2]*o[4]))*sigma1)) + pi*(-0.261076364893320
     + pi*(0.00056608900654837 + pi*(o[1]*o[3]*(
    2.64004413606890e-13 + 7.8124600459723e-29*o[6]) -
    3.07321999036680e-31*o[5]*pi) + sigma1*(-0.00032635483139717
     + sigma1*(0.000044778286690632 + o[1]*o[2]*(-5.1322156908507e-10
     - 4.2522657042207e-26*o[6])*sigma1))) + sigma1*(
    0.225929659815860 + sigma1*(-0.064256463395226 + sigma1*(
    0.0078876289270526 + o[3]*sigma1*(3.5672110607366e-10 +
    1.73324969948950e-24*o[1]*o[4]*sigma1)))));
end tps1;
