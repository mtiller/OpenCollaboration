within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function setState_ph "returns state record as function of p and h"
  input AbsolutePressure p "pressure";
  input SpecificEnthalpy h "specific enthalpy";
  output ThermodynamicState state "thermodynamic state";
algorithm
  state := ThermodynamicState(p=p, T=T_ph(p, h));
end setState_ph;
