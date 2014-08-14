within ORNL_AdvSMR.Media.Interfaces.State;
function moleToMassFractions
  "Compute mass fractions vector from mole fractions and molar masses"
  extends Modelica.Icons.Function;
  input Units.MoleFraction moleFractions[:] "Mole fractions of mixture";
  input Units.MolarMass[:] MMX "molar masses of components";
  output Units.MassFraction X[size(moleFractions, 1)]
    "Mass fractions of gas mixture";
protected
  Units.MolarMass Mmix=moleFractions*MMX "molar mass of mixture";
algorithm
  for i in 1:size(moleFractions, 1) loop
    X[i] := moleFractions[i]*MMX[i]/Mmix;
  end for;
  annotation (smoothOrder=5);
end moleToMassFractions;
