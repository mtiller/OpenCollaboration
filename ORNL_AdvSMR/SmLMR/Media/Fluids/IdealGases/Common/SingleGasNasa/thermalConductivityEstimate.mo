within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function thermalConductivityEstimate
  "Thermal conductivity of polyatomic gases(Eucken and Modified Eucken correlation)"
  extends Modelica.Icons.Function;
  input SpecificHeatCapacity Cp "Constant pressure heat capacity";
  input DynamicViscosity eta "Dynamic viscosity";
  input Integer method(
    min=1,
    max=2) = 1 "1: Eucken Method, 2: Modified Eucken Method";
  output ThermalConductivity lambda "Thermal conductivity [W/(m.k)]";
algorithm
  lambda := if method == 1 then eta*(Cp - data.R + (9/4)*data.R)
     else eta*(Cp - data.R)*(1.32 + 1.77/((Cp/Modelica.Constants.R)
     - 1.0));
  annotation (smoothOrder=2, Documentation(info="<html>
<p>
This function provides two similar methods for estimating the
thermal conductivity of polyatomic gases.
The Eucken method (input method == 1) gives good results for low temperatures,
but it tends to give an underestimated value of the thermal conductivity
(lambda) at higher temperatures.<br>
The Modified Eucken method (input method == 2) gives good results for
high-temperatures, but it tends to give an overestimated value of the
thermal conductivity (lambda) at low temperatures.
</p>
</html>"));
end thermalConductivityEstimate;
