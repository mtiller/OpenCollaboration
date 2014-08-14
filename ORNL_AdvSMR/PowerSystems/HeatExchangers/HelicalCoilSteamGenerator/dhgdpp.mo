within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function dhgdpp "This function evaluates the differential of enthalpy of saturated vapor wrt pressure at a given pressure. 
  The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "fluid pressure (MPa)";
  output Real dhdp;

algorithm
  dhdp := 1*1.0495e+002 - 2*1.8123e+001 .* p + 3*1.1018e+000 .* p .* p - 4*
    2.4219e-002 .* p .* p .* p;

end dhgdpp;
