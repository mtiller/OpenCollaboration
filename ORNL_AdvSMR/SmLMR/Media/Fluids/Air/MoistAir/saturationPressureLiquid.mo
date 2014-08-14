within ORNL_AdvSMR.SmLMR.Media.Fluids.Air.MoistAir;
function saturationPressureLiquid
  "Return saturation pressure of water as a function of temperature T in the range of 273.16 to 373.16 K"

  extends Modelica.Icons.Function;
  input SI.Temperature Tsat "saturation temperature";
  output SI.AbsolutePressure psat "saturation pressure";
algorithm
  psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));
  annotation (
    Inline=false,
    smoothOrder=5,
    derivative=saturationPressureLiquid_der,
    Documentation(info="<html>
Saturation pressure of water above the triple point temperature is computed from temperature. It's range of validity is between
273.16 and 373.16 K. Outside these limits a less accurate result is returned.
</html>"));
end saturationPressureLiquid;
