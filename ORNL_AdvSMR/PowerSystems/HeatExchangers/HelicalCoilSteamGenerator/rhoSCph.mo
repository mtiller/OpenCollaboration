within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function rhoSCph "This function evaluates the density of subcooled liquid as a function of pressure and enthalpy. 
  The coefficients come from a fit to data computed from Xsteam."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

protected
  Real v;

public
  input SI.AbsolutePressure p "liquid pressure (MPa)";
  input SI.SpecificEnthalpy h "liquid enthalpy (J/kg)";
  output SI.Density rho "liquid density (kg/m3)";

algorithm
  v := 9.6977e-004 - 7.9787e-007*p + 2.7568e-007*h - 6.4795e-010*p*h +
    1.9181e-008*p*p - 2.7811e-010*h*h + 2.5255e-013*h*h*h - 9.9213e-010*p*p*p
     + 8.0977e-011*p*p*h - 2.2310e-012*p*h*h;

  rho := 1./v;

end rhoSCph;
