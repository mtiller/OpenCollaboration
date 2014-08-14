within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function hfp "This function evaluates the enthalpy of saturated liquid at a given pressure.
    The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "fluid pressure (MPa)";
  output SI.SpecificEnthalpy hf "specific enthalpy of vapor (J/kg)";

algorithm
  hf := 2.9469e+002 + 3.4012e+002 .* p - 4.2605e+001 .* p .* p + 2.4418e+000
     .* p .* p .* p - 4.8449e-002 .* p .* p .* p .* p;

end hfp;
