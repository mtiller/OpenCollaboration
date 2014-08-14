within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function supperofp5
  "explicit upper specific entropy limit of region 5 as function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real pi "dimensionless pressure";
algorithm
  pi := p/data.PSTAR5;
  assert(p > triple.ptriple,
    "IF97 medium function supperofp5 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  s := 461.526*(22.7281531474243 + pi*(-0.000656650220627603 +
    (-1.96109739782049e-8 + 2.19979537113031e-8*pi)*pi) -
    Modelica.Math.log(pi));
end supperofp5;
