within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function psat_der "derivative function for psat"
  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature (K)";
  input Real der_T(unit="K/s") "temperature derivative";
  output Real der_psat(unit="Pa/s") "pressure";
protected
  Real dpt;
algorithm
  dpt := dptofT(T);
  der_psat := dpt*der_T;
end psat_der;
