within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function drhodhSCph "This function evaluates the partial of density wrt enthalpy of subcooled liquid as a function of pressure and enthalpy. 
  The partial is evaluated by analytical differentiation of rhoSCph to data computed from Xsteam."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "subcooled liquid pressure (MPa)";
  input SI.SpecificEnthalpy h "subcooled liquid specific enthalpy (J/kg)";
  output Real drhodh "partial density wrt enthalpy";

protected
  SI.Density rho "liquid density (kg/m3)";
  Real dvdh "partial specific volume wrt enthalpy";

algorithm
  rho := rhoSCph(p, h);

  dvdh := 1*2.7568e-007 - 1*6.4795e-010 .* p - 2*2.7811e-010 .* h + 3*
    2.5255e-013 .* h .* h + 1*8.0977e-011 .* p .* p - 2*2.2310e-012 .* p .* h;

  drhodh := -dvdh .* rho .* rho;

end drhodhSCph;
