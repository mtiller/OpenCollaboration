within ORNL_AdvSMR.Media.HelmholtzMedia.Interfaces.PartialHelmholtzMedium;
function pressure_dT_der "time derivative of pressure_dT"

  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Real der_d "Density derivative";
  input Real der_T "Temperature derivative";
  output Real der_p "Time derivative of pressure";

protected
  ThermodynamicState state=setState_dTX(
      d=d,
      T=T,
      phase=phase);

algorithm
  der_p := der_d*pressure_derd_T(state=state) + der_T*pressure_derT_d(state=
    state);
end pressure_dT_der;
