within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function drhodpSCph "This function evaluates the partial of density wrt pressure of subcooled liquid as a function of pressure and enthalpy. 
  The partial is evaluated by analytical differentiation of rhoSCph to data computed from Xsteam."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "subcooled liquid pressure (MPa)";
  input SI.SpecificEnthalpy h "subcooled liquid specific enthalpy (J/kg)";
  output Real drhodp "partial density wrt enthalpy";

protected
  SI.Density rho "liquid density (kg/m3)";
  Real dvdp "partial specific volume wrt enthalpy";

algorithm
  rho := rhoSCph(p, h);
  dvdp := -1*7.9787e-007 - 1*6.4795e-010 .* h + 2*1.9181e-008 .* p - 3*
    9.9213e-010 .* p .* p + 2*8.0977e-011 .* p .* h - 1*2.2310e-012 .* h .* h;

  drhodp := -dvdp .* rho .* rho;

end drhodpSCph;
