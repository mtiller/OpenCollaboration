within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function rhogp
  "This function evaluates the density of saturated vapor at a given pressure. The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "fluid pressure (MPa)";
  output SI.Density rhog "saturated vapor density (kg/m3)";

protected
  SI.SpecificEnthalpy h "specific enthalpy (J/kg)";

algorithm
  h := hgp(p);
  rhog := rhoSHph(p, h);

end rhogp;
