within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hupperofp2
  "explicit upper specific enthalpy limit of region 2 as function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real pi "dimensionless pressure";
  Real[2] o "vector of auxiliary variables";
algorithm
  pi := p/data.PSTAR2;
  assert(p > triple.ptriple,
    "IF97 medium function hupperofp2 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := pi*pi;
  o[2] := o[1]*o[1]*o[1];
  h := 4.16066337647071e6 + pi*(-4518.48617188327 + pi*(-8.53409968320258
     + pi*(0.109090430596056 + pi*(-0.000172486052272327 + pi*(
    4.2261295097284e-15 + pi*(-1.27295130636232e-10 + pi*(-3.79407294691742e-25
     + pi*(7.56960433802525e-23 + pi*(7.16825117265975e-32 + pi
    *(3.37267475986401e-21 + (-7.5656940729795e-74 + o[1]*(-8.00969737237617e-134
     + (1.6746290980312e-65 + pi*(-3.71600586812966e-69 + pi*(
    8.06630589170884e-129 + (-1.76117969553159e-103 +
    1.88543121025106e-84*pi)*pi)))*o[1]))*o[2]))))))))));
end hupperofp2;
