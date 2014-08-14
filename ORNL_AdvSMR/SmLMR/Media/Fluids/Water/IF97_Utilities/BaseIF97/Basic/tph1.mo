within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tph1 "inverse function for region 1: T(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output SI.Temperature T "temperature (K)";
protected
  Real pi "dimensionless pressure";
  Real eta1 "dimensionless specific enthalpy";
  Real[3] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function tph1 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  pi := p/data.PSTAR2;
  eta1 := h/data.HSTAR1 + 1.0;
  o[1] := eta1*eta1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  T := -238.724899245210 - 13.3917448726020*pi + eta1*(
    404.21188637945 + 43.211039183559*pi + eta1*(
    113.497468817180 - 54.010067170506*pi + eta1*(
    30.5358922039160*pi + eta1*(-6.5964749423638*pi + o[1]*(-5.8457616048039
     + o[2]*(pi*(0.0093965400878363 + (-0.0000258586412820730
     + 6.6456186191635e-8*pi)*pi) + o[2]*o[3]*(-0.000152854824131400
     + o[1]*o[3]*(-1.08667076953770e-6 + pi*(
    1.15736475053400e-7 + pi*(-4.0644363084799e-9 + pi*(
    8.0670734103027e-11 + pi*(-9.3477771213947e-13 + (
    5.8265442020601e-15 - 1.50201859535030e-17*pi)*pi))))))))))));
end tph1;
