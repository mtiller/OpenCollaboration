within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hupperofp5
  "explicit upper specific enthalpy limit of region 5 as function of pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real pi "dimensionless pressure";
algorithm
  pi := p/data.PSTAR5;
  assert(p > triple.ptriple,
    "IF97 medium function hupperofp5 called with too low pressure\n" + "p = "
     + String(p) + " Pa <= " + String(triple.ptriple) +
    " Pa (triple point pressure)");
  h := 461526.*(15.9838891400332 + pi*(-0.000489898813722568 + (-5.01510211858761e-8
     + 7.5006972718273e-8*pi)*pi));
end hupperofp5;
