within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.MixtureGasNasa;
function MixEntropy "Return mixing entropy of ideal gases / R"
  extends Modelica.Icons.Function;
  input SI.MoleFraction x[:] "mole fraction of mixture";
  output Real smix "mixing entropy contribution, divided by gas constant";
algorithm
  smix := sum(if x[i] > Modelica.Constants.eps then -x[i]*
    Modelica.Math.log(x[i]) else x[i] for i in 1:size(x, 1));
end MixEntropy;
