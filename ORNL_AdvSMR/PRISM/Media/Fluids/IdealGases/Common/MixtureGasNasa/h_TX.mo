within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.Common.MixtureGasNasa;
function h_TX "Return specific enthalpy"
  import Modelica.Media.Interfaces.PartialMedium.Choices;
  extends Modelica.Icons.Function;
  input SI.Temperature T "Temperature";
  input MassFraction X[:]=reference_X
    "Independent Mass fractions of gas mixture";
  input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input Choices.ReferenceEnthalpy refChoice=referenceChoice
    "Choice of reference enthalpy";
  input SI.SpecificEnthalpy h_off=h_offset
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
algorithm
  h := (if fixedX then reference_X else X)*{SingleGasNasa.h_T(
                  data[i],
                  T,
                  exclEnthForm,
                  refChoice,
                  h_off) for i in 1:nX};
  annotation (Inline=false, smoothOrder=2);
end h_TX;
