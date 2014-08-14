within ORNL_AdvSMR.Components.Pipes.BaseClasses.CharacteristicNumbers;
function NusseltNumber "Return Nusselt number"
  input Modelica.SIunits.CoefficientOfHeatTransfer alpha
    "Coefficient of heat transfer";
  input Modelica.SIunits.Length D "Characteristic dimension";
  input Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
  output Modelica.SIunits.NusseltNumber Nu "Nusselt number";
algorithm
  Nu := alpha*D/lambda;
  annotation (Documentation(info="Nusselt number Nu = alpha*D/lambda"));
end NusseltNumber;
