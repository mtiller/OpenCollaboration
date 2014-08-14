within ORNL_AdvSMR.Media.HelmholtzMedia.Interfaces.PartialHelmholtzMedium;
function density_ph_der "time derivative of density_ph"

  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Real der_p "time derivative of pressure";
  input Real der_h "time derivative of specific enthalpy";
  output Real der_d "time derivative of density";

protected
  ThermodynamicState state=setState_phX(
      p=p,
      h=h,
      phase=phase);

algorithm
  der_d := der_p*density_derp_h(state=state) + der_h*density_derh_p(state=state);
end density_ph_der;
