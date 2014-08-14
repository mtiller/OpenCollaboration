within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hlowerofp5
  "explicit lower specific enthalpy limit of region 5 as function of pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real pi "dimensionless pressure";
algorithm
  pi := p/data.PSTAR5;
  assert(p > triple.ptriple,
    "IF97 medium function hlowerofp5 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  h := 461526.*(9.01505286876203 + pi*(-0.00979043490246092 + (
    -0.0000203245575263501 + 3.36540214679088e-7*pi)*pi));
end hlowerofp5;
