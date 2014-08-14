within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models.MoistAir;
function sublimationPressureIce_der
  "Derivative function for 'sublimationPressureIce'"

  extends Modelica.Icons.Function;
  input SI.Temperature Tsat "Sublimation temperature";
  input Real dTsat(unit="K/s") "Time derivative of sublimation temperature";
  output Real psat_der(unit="Pa/s") "Sublimation pressure";
algorithm
  /*psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));*/
  psat_der := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat))*22.5159*273.16*
    dTsat/Tsat/Tsat;
  annotation (
    Inline=false,
    smoothOrder=5,
    Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">saturationPressureIce</a>
</html>"));
end sublimationPressureIce_der;
