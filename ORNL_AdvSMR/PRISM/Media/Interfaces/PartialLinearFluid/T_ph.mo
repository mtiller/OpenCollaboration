within ORNL_AdvSMR.PRISM.Media.Interfaces.PartialLinearFluid;
function T_ph "Return temperature from pressure and specific enthalpy"
  input SpecificEnthalpy h "Specific enthalpy";
  input AbsolutePressure p "pressure";
  output Temperature T "Temperature";
algorithm
  T := (h - reference_h - (p - reference_p)*((1 - beta_const*reference_T)/
    reference_d))/cp_const + reference_T;
end T_ph;
