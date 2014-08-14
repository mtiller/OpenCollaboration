within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function h_Tlow "Compute specific enthalpy, low T region; reference is decided by the
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
  output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
  //     annotation (Inline=false,InlineNoEvent=false, derivative(zeroDerivative=data,
  //                                zeroDerivative=exclEnthForm,
  //                                zeroDerivative=refChoice,
  //                                zeroDerivative=h_off) = h_Tlow_der);
algorithm
  h := data.R*((-data.alow[1] + T*(data.blow[1] + data.alow[2]*
    Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.alow[4] + T*(1
    /3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
    /T) + (if exclEnthForm then -data.Hf else 0.0) + (if (
    refChoice == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0
     else 0.0) + (if refChoice == Choices.ReferenceEnthalpy.UserDefined
     then h_off else 0.0);
  annotation (
    Inline=false,
    InlineNoEvent=false,
    smoothOrder=2);
end h_Tlow;
