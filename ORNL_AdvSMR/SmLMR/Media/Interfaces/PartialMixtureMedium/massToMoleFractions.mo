within ORNL_AdvSMR.SmLMR.Media.Interfaces.PartialMixtureMedium;
function massToMoleFractions "Return mole fractions from mass fractions X"
  extends Modelica.Icons.Function;
  input SI.MassFraction X[:] "Mass fractions of mixture";
  input SI.MolarMass[:] MMX "molar masses of components";
  output SI.MoleFraction moleFractions[size(X, 1)]
    "Mole fractions of gas mixture";
protected
  Real invMMX[size(X, 1)] "inverses of molar weights";
  SI.MolarMass Mmix "molar mass of mixture";
algorithm
  for i in 1:size(X, 1) loop
    invMMX[i] := 1/MMX[i];
  end for;
  Mmix := 1/(X*invMMX);
  for i in 1:size(X, 1) loop
    moleFractions[i] := Mmix*X[i]/MMX[i];
  end for;
  annotation (smoothOrder=5);
end massToMoleFractions;
