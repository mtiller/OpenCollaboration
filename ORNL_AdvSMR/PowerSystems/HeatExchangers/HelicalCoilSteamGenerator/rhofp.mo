within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function rhofp
  "This function evaluates the density of saturated liquid at a given pressure. The coefficients are fit to data from XSteam in SCWaterfit2."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "fluid pressure (MPa)";
  output SI.Density rhof "saturated liquid density (kg/m3)";

protected
  SI.SpecificEnthalpy h "specific enthalpy (J/kg)";

algorithm
  h := hfp(p);
  rhof := rhoSCph(p, h);

end rhofp;
