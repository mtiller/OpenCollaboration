within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function setState_ps "returns state record as function of p and s"
  input AbsolutePressure p "pressure";
  input SpecificEntropy s "specific entropy";
  output ThermodynamicState state "thermodynamic state";
algorithm
  state := ThermodynamicState(p=p, T=T_ps(p, s));
end setState_ps;
