within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.Common.SingleGasNasa;
function h_Tlow_der "Compute specific enthalpy, low T region; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
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
  input Real dT(unit="K/s") "Temperature derivative";
  output Real h_der(unit="J/(kg.s)")
    "Derivative of specific enthalpy at temperature T";
algorithm
  h_der := dT*cp_Tlow(data, T);
end h_Tlow_der;
