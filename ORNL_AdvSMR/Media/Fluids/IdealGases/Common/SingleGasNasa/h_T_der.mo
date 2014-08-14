within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function h_T_der "derivative function for h_T"
  import Modelica.Media.Interfaces.PartialMedium.Choices;
  extends Modelica.Icons.Function;
  input DataRecord data "Ideal gas data";
  input SI.Temperature T "Temperature";
  input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input Choices.ReferenceEnthalpy refChoice=referenceChoice
    "Choice of reference enthalpy";
  input SI.SpecificEnthalpy h_off=h_offset
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  input Real dT "Temperature derivative";
  output Real h_der "Specific enthalpy at temperature T";
algorithm
  h_der := dT*cp_T(data, T);
end h_T_der;
