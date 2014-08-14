within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_p;
function v_pT_der "Specific volume derivative"
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  input Real p_der(unit="Pa/s") "Pressure derivative";
  input Real T_der(unit="K/s") "Temperature derivative";
  output Real v_der(unit="m3/(kg.s)") "Specific enthalpy derivative";
algorithm
  v_der := if CompressibilityType == Compressibility.FullyCompressible then -
    data.kappa_const*v0*p_der - Poly.derivativeValue(data.polyDensity, T)/(max(
    Poly.evaluate(data.polyDensity, T), limits.DMIN)*max(Poly.evaluate(data.polyDensity,
    T), limits.DMIN))*T_der elseif CompressibilityType == Compressibility.TemperatureDependent
     then -Poly.derivativeValue(data.polyDensity, T)/(max(Poly.evaluate(data.polyDensity,
    T), limits.DMIN)*max(Poly.evaluate(data.polyDensity, T), limits.DMIN))*
    T_der elseif CompressibilityType == Compressibility.PressureDependent then
    -data.kappa_const*v0*p_der else 0;
end v_pT_der;
