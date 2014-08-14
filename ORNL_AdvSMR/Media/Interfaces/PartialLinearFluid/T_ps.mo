within ORNL_AdvSMR.Media.Interfaces.PartialLinearFluid;
function T_ps "Return temperature from pressure and specific entropy"
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  output Temperature T "Temperature";
algorithm
  T := reference_T*cp_const/(s - reference_s - (p - reference_p)*(-beta_const/
    reference_d) - cp_const);
end T_ps;
