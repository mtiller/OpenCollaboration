within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function slowerofp5
  "explicit lower specific entropy limit of region 5 as function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real pi "dimensionless pressure";
algorithm
  pi := p/data.PSTAR5;
  assert(p > triple.ptriple,
    "IF97 medium function slowerofp5 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  s := 461.526*(18.4296209980112 + pi*(-0.00730911805860036 + (
    -0.0000168348072093888 + 2.09066899426354e-7*pi)*pi) -
    Modelica.Math.log(pi));
end slowerofp5;
