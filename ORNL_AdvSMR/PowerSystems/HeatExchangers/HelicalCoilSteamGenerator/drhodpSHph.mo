within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function drhodpSHph "This function evaluates the partial of density with respect to pressure of superheated vapor as a function of pressure and enthalpy. 
  The coefficients come from a fit to data computed from Xsteam. The coefficients literal constants in this version."

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Cons = Modelica.Constants;

public
  input SI.AbsolutePressure p "subcooled liquid pressure (MPa)";
  input SI.SpecificEnthalpy h "subcooled liquid specific enthalpy (J/kg)";
  output Real drhodp "partial density wrt enthalpy";

protected
  SI.SpecificVolume v "specific volume (m3/kg)";
  Real dvdp "partial specific volume wrt pressure";

algorithm
  v := -1.9023e-004 - 8.4782e-008 .* p + 1.3231e-007 .* h - 1.9439e-011 .* p
     .* h + 3.7860e-009 .* p .* p - 1.3881e-011 .* h .* h;

  dvdp := -8.4782e-008 - 1.9439e-011 .* h + 2*3.7860e-009 .* p;

  drhodp := 1 ./ (v .* h) .* (1 .- p ./ v .* dvdp);

end drhodpSHph;
