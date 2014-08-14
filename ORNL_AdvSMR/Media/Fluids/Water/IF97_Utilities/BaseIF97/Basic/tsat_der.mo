within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tsat_der "derivative function for tsat"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input Real der_p(unit="Pa/s") "pressure derivatrive";
  output Real der_tsat(unit="K/s") "temperature derivative";
protected
  Real dtp;
algorithm
  dtp := dtsatofp(p);
  der_tsat := dtp*der_p;
end tsat_der;
