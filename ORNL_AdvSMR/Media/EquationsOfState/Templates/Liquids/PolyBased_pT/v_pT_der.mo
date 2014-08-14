within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_pT;
function v_pT_der "Specific volume derivative"
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  input Real p_der(unit="Pa/s") "Pressure derivative";
  input Real T_der(unit="K/s") "Temperature derivative";
  output Real v_der(unit="m3/(kg.s)") "Specific enthalpy derivative";
algorithm
  v_der := -data.kappa_const*v0*p_der - Poly.derivativeValue(data.polyDensity,
    T)/(max(Poly.evaluate(data.polyDensity, T), limits.DMIN)*max(Poly.evaluate(
    data.polyDensity, T), limits.DMIN))*T_der;
end v_pT_der;
