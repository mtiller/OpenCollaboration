within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.MixtureGasNasa;
function h_TX_der "Return specific enthalpy derivative"
  import Modelica.Media.Interfaces.PartialMedium.Choices;
  extends Modelica.Icons.Function;
  input SI.Temperature T "Temperature";
  input MassFraction X[nX] "Independent Mass fractions of gas mixture";
  input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input Choices.ReferenceEnthalpy refChoice=referenceChoice
    "Choice of reference enthalpy";
  input SI.SpecificEnthalpy h_off=h_offset
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  input Real dT "Temperature derivative";
  input Real dX[nX] "independent mass fraction derivative";
  output Real h_der "Specific enthalpy at temperature T";
algorithm
  h_der := if fixedX then dT*sum((SingleGasNasa.cp_T(data[i], T)*reference_X[i])
    for i in 1:nX) else dT*sum((SingleGasNasa.cp_T(data[i], T)*X[i]) for i in 1
    :nX) + sum((SingleGasNasa.h_T(data[i], T)*dX[i]) for i in 1:nX);
  annotation (InlineNoEvent=false, Inline=false);
end h_TX_der;
