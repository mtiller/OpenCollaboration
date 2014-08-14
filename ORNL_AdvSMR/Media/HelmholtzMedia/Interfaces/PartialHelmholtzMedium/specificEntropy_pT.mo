within ORNL_AdvSMR.Media.HelmholtzMedia.Interfaces.PartialHelmholtzMedium;
function specificEntropy_pT
  "iteratively finds the specific entropy for a given p and T"
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEntropy s "Specific Entropy";

algorithm
  s := specificEntropy(setState_pTX(
    p=p,
    T=T,
    phase=1));

  annotation (inverse(T=temperature_ps(
          p=p,
          s=s,
          phase=phase), p=pressure_Ts(
          T=T,
          s=s,
          phase=phase)));
end specificEntropy_pT;
