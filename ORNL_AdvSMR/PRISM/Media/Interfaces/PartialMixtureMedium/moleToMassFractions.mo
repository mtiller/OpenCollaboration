within ORNL_AdvSMR.PRISM.Media.Interfaces.PartialMixtureMedium;
function moleToMassFractions "Return mass fractions X from mole fractions"
  extends Modelica.Icons.Function;
  input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
  input MolarMass[:] MMX "molar masses of components";
  output SI.MassFraction X[size(moleFractions, 1)]
    "Mass fractions of gas mixture";
protected
  MolarMass Mmix=moleFractions*MMX "molar mass of mixture";
algorithm
  for i in 1:size(moleFractions, 1) loop
    X[i] := moleFractions[i]*MMX[i]/Mmix;
  end for;
  annotation (smoothOrder=5);
end moleToMassFractions;
