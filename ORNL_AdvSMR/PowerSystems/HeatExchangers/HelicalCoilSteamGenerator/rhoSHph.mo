within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function rhoSHph "This function evaluates the density of subcooled liquid as a function of pressure and enthalpy. 
  The coefficients come from a fit to data computed from Xsteam.  
  The coefficients are read in this version."

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
  v := -1.9023e-004 - 8.4782e-008 .* p + 1.3231e-007 .* h - 1.9439e-011 .* p
     .* h + 3.7860e-009 .* p .* p - 1.3881e-011 .* h .* h;

  rho := p ./ (v .* h);

end rhoSHph;
