within ORNL_AdvSMR.Media.Interfaces.State;
function massToMoleFractions
  "Compute mole fraction vector from mass fraction vector"
  extends Modelica.Icons.Function;
  input Units.MassFraction X[:] "Mass fractions of mixture";
  input Units.MolarMass[:] MMX "molar masses of components";
  output Units.MoleFraction moleFractions[size(X, 1)]
    "Mole fractions of gas mixture";
protected
  Real invMMX[size(X, 1)] "inverses of molar weights";
  Modelica.SIunits.MolarMass Mmix "molar mass of mixture";
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
