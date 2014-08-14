within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased;
function h_pT_der "Specific enthalpy derivative"
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  input Real p_der(unit="Pa/s") "Pressure derivative";
  input Real T_der(unit="K/s") "Temperature derivative";
  output Real h_der(unit="J/(kg.s)") "Specific enthalpy derivative";
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
algorithm
  if CompressibilityType == Compressibility.FullyCompressible then
    h_der := cp_pTX(
      p,
      T,
      X)*T_der + (1/rhoT + T*drhoT/(rhoT*rhoT) + (data.reference_p - p)*data.kappa_const
      *v0)*p_der;
  elseif CompressibilityType == Compressibility.TemperatureDependent then
    h_der := cp_pTX(
      p,
      T,
      X)*T_der + (1/rhoT + T*drhoT/(rhoT*rhoT))*p_der;
  elseif CompressibilityType == Compressibility.PressureDependent then
    h_der := cp_pTX(
      p,
      T,
      X)*T_der + v0*(1 + (data.reference_p - p)*data.kappa_const)*p_der;
  else
    h_der := cp_pTX(
      p,
      T,
      X)*T_der + v0*p_der;
  end if;
end h_pT_der;
