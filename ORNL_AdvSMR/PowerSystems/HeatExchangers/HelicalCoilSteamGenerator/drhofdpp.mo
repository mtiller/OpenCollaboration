within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function drhofdpp "This function evaluates the density of saturated liquid at a given pressure. 
  The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "subcooled liquid pressure (MPa)";
  output Real drhodp "differential density wrt pressure";

protected
  SI.SpecificEnthalpy hf "specific enthalpy of saturated vapor (J/kg)";

algorithm
  hf := hfp(p);
  drhodp := drhodpSCph(p, hf) + drhodhSCph(p, hf) .* dhfdpp(p);

end drhofdpp;
