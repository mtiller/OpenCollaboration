within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function h_T "Compute specific enthalpy from temperature and gas data; reference is decided by the
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
  //     annotation (InlineNoEvent=false, Inline=false,
  //                 derivative(zeroDerivative=data,
  //                            zeroDerivative=exclEnthForm,
  //                            zeroDerivative=refChoice,
  //                            zeroDerivative=h_off) = h_T_der);
algorithm
  h := smooth(0, (if T < data.Tlimit then data.R*((-data.alow[1] + T*(data.blow[
    1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.alow[4] +
    T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))/T)
     else data.R*((-data.ahigh[1] + T*(data.bhigh[1] + data.ahigh[2]*Math.log(T)
     + T*(1.*data.ahigh[3] + T*(0.5*data.ahigh[4] + T*(1/3*data.ahigh[5] + T*(
    0.25*data.ahigh[6] + 0.2*data.ahigh[7]*T))))))/T)) + (if exclEnthForm then
    -data.Hf else 0.0) + (if (refChoice == Choices.ReferenceEnthalpy.ZeroAt0K)
     then data.H0 else 0.0) + (if refChoice == Choices.ReferenceEnthalpy.UserDefined
     then h_off else 0.0));
  annotation (Inline=false,smoothOrder=2);
end h_T;
