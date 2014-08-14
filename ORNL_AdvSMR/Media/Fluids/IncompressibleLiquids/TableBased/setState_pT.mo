within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function setState_pT "returns state record as function of p and T"
  input AbsolutePressure p "pressure";
  input Temperature T "temperature";
  output ThermodynamicState state "thermodynamic state";
algorithm
  state.T := T;
  state.p := p;
end setState_pT;
