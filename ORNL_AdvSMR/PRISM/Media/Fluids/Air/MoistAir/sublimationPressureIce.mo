within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function sublimationPressureIce
  "Return sublimation pressure of water as a function of temperature T between 223.16 and 273.16 K"

  extends Modelica.Icons.Function;
  input SI.Temperature Tsat "sublimation temperature";
  output SI.AbsolutePressure psat "sublimation pressure";
algorithm
  psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));
  annotation (
    Inline=false,
    smoothOrder=5,
    derivative=sublimationPressureIce_der,
    Documentation(info="<html>
Sublimation pressure of water below the triple point temperature is computed from temperature. It's range of validity is between
 223.16 and 273.16 K. Outside of these limits a less accurate result is returned.
</html>"));
end sublimationPressureIce;
