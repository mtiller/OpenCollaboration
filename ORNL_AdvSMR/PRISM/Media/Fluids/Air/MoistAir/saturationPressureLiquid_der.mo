within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function saturationPressureLiquid_der
  "Time derivative of saturationPressureLiquid"

  extends Modelica.Icons.Function;
  input SI.Temperature Tsat "Saturation temperature";
  input Real dTsat(unit="K/s") "Saturation temperature derivative";
  output Real psat_der(unit="Pa/s") "Saturation pressure";
algorithm
  /*psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));*/
  psat_der := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719))*4102.99*dTsat
    /(Tsat - 35.719)/(Tsat - 35.719);

  annotation (
    Inline=false,
    smoothOrder=5,
    Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\">saturationPressureLiquid</a>
</html>"));
end saturationPressureLiquid_der;
