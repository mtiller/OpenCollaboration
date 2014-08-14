within ORNL_AdvSMR.SmLMR.Media.Fluids.Air.MoistAir;
function saturationPressure_der "Derivative function for 'saturationPressure'"
  input Temperature Tsat "Saturation temperature";
  input Real dTsat(unit="K/s") "Time derivative of saturation temperature";
  output Real psat_der(unit="Pa/s") "Saturation pressure";

algorithm
  /*psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);*/
  psat_der := Utilities.spliceFunction_der(
    saturationPressureLiquid(Tsat),
    sublimationPressureIce(Tsat),
    Tsat - 273.16,
    1.0,
    saturationPressureLiquid_der(Tsat=Tsat, dTsat=dTsat),
    sublimationPressureIce_der(Tsat=Tsat, dTsat=dTsat),
    dTsat,
    0);
  annotation (
    Inline=false,
    smoothOrder=5,
    Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a>
</html>"));
end saturationPressure_der;
