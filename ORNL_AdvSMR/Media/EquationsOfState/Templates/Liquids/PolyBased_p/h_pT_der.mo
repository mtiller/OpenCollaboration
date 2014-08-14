within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_p;
function h_pT_der "Specific enthalpy derivative"
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  input Real p_der(unit="Pa/s") "Pressure derivative";
  input Real T_der(unit="K/s") "Temperature derivative";
  output Real h_der(unit="J/(kg.s)") "Specific enthalpy derivative";
algorithm
  h_der := cp_pTX(
    p,
    T,
    X)*T_der;
end h_pT_der;
