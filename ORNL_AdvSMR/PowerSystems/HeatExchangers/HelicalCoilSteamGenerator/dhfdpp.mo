within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function dhfdpp "This function evaluates the differential of enthalpy of saturated liquid wrt pressure at a given pressure. 
  The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "fluid pressure (MPa)";
  output Real dhdp;

algorithm
  dhdp := 1*3.4012e+002 - 2*4.2605e+001 .* p + 3*2.4418e+000 .* p .* p - 4*
    4.8449e-002 .* p .* p .* p;

end dhfdpp;
