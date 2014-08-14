within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function isentropicEnthalpyApproximation
  "approximate method of calculating h_is from upstream properties and downstream pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p2 "downstream pressure";
  input ThermodynamicState state "properties at upstream location";
  input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input ReferenceEnthalpy refChoice=referenceChoice
    "Choice of reference enthalpy";
  input SpecificEnthalpy h_off=h_offset
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  output SI.SpecificEnthalpy h_is "isentropic enthalpy";
protected
  IsentropicExponent gamma=isentropicExponent(state) "Isentropic exponent";
algorithm
  h_is := h_T(    data,
                  state.T,
                  exclEnthForm,
                  refChoice,
                  h_off) + gamma/(gamma - 1.0)*state.p/density(
    state)*((p2/state.p)^((gamma - 1)/gamma) - 1.0);
end isentropicEnthalpyApproximation;
