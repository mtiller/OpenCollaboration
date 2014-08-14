within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hlowerofp1
  "explicit lower specific enthalpy limit of region 1 as function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real pi1 "dimensionless pressure";
  Real[3] o "vector of auxiliary variables";
algorithm
  pi1 := 7.1 - p/data.PSTAR1;
  assert(p > triple.ptriple,
    "IF97 medium function hlowerofp1 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := pi1*pi1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];

  h := 639675.036*(0.173379420894777 + pi1*(-0.022914084306349
     + pi1*(-0.00017146768241932 + pi1*(-4.18695814670391e-6 +
    pi1*(-2.41630417490008e-7 + pi1*(1.73545618580828e-11 + o[1]
    *pi1*(8.43755552264362e-14 + o[2]*o[3]*pi1*(
    5.35429206228374e-35 + o[1]*(-8.12140581014818e-38 + o[1]*o[
    2]*(-1.43870236842915e-44 + pi1*(1.73894459122923e-45 + (-7.06381628462585e-47
     + 9.64504638626269e-49*pi1)*pi1)))))))))));
end hlowerofp1;
