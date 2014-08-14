within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function hgp
  "This function evaluates the enthalpy of saturated vapor at a given pressure. The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "fluid pressure (MPa)";
  output SI.SpecificEnthalpy hg "specific enthalpy of vapor (J/kg)";

algorithm
  hg := 2.6208e+003 + 1.0495e+002 .* p - 1.8123e+001 .* p .* p + 1.1018e+000
     .* p .* p .* p - 2.4219e-002 .* p .* p .* p .* p;

end hgp;
