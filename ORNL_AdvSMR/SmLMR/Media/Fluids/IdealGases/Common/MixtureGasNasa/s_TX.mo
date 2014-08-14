within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.MixtureGasNasa;
function s_TX
  "Return temperature dependent part of the entropy, expects full entropy vector"
  input Temperature T "temperature";
  input MassFraction[nX] X "mass fraction";
  output SpecificEntropy s "specific entropy";
algorithm
  s := sum(SingleGasNasa.s0_T(data[i], T)*X[i] for i in 1:size(X,
    1));
end s_TX;
