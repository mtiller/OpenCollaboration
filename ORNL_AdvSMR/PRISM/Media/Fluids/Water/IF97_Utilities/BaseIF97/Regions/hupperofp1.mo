within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hupperofp1
  "explicit upper specific enthalpy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real pi1 "dimensionless pressure";
  Real[3] o "vector of auxiliary variables";
algorithm
  pi1 := 7.1 - p/data.PSTAR1;
  assert(p > triple.ptriple,
    "IF97 medium function hupperofp1 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := pi1*pi1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  h := 639675.036*(2.42896927729349 + pi1*(-0.00141131225285294
     + pi1*(0.00143759406818289 + pi1*(0.000125338925082983 +
    pi1*(0.0000123617764767172 + pi1*(3.17834967400818e-6 + o[1]
    *pi1*(1.46754947271665e-8 + o[2]*o[3]*pi1*(
    1.86779322717506e-17 + o[1]*(-4.18568363667416e-19 + o[1]*o[
    2]*(-9.19148577641497e-22 + pi1*(4.27026404402408e-22 + (-6.66749357417962e-23
     + 3.49930466305574e-24*pi1)*pi1)))))))))));
end hupperofp1;
