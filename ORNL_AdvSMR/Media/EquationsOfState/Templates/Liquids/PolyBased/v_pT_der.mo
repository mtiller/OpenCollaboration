within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased;
function v_pT_der "Specific volume derivative"
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  input Real p_der(unit="Pa/s") "Pressure derivative";
  input Real T_der(unit="K/s") "Temperature derivative";
  output Real v_der(unit="m3/(kg.s)") "Specific enthalpy derivative";
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
algorithm
  if CompressibilityType == Compressibility.FullyCompressible then
    v_der := -data.kappa_const*v0*p_der - drhoT/(rhoT*rhoT)*T_der;
  elseif CompressibilityType == Compressibility.TemperatureDependent then
    v_der := -drhoT/(rhoT*rhoT)*T_der;
  elseif CompressibilityType == Compressibility.PressureDependent then
    v_der := -data.kappa_const*v0*p_der;
  else
    v_der := 0;
  end if;
end v_pT_der;
