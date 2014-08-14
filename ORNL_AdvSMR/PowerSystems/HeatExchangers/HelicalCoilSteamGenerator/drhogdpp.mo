within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function drhogdpp
  "This function evaluates the density of saturated vapor at a given pressure. The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "subcooled liquid pressure (MPa)";
  output Real drhodp "partial density wrt enthalpy";

protected
  SI.SpecificEnthalpy hg "specific enthalpy of saturated vapor (J/kg)";

algorithm
  hg := hgp(p);

  drhodp := drhodpSHph(p, hg) + drhodhSHph(p, hg) .* dhgdpp(p);

end drhogdpp;
