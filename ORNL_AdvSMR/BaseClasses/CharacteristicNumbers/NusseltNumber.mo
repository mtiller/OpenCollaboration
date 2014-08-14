within ORNL_AdvSMR.BaseClasses.CharacteristicNumbers;
function NusseltNumber "Return Nusselt number"
  input Modelica.SIunits.CoefficientOfHeatTransfer h
    "Coefficient of heat transfer";
  input Modelica.SIunits.Length D "Characteristic dimension";
  input Modelica.SIunits.ThermalConductivity k "Thermal conductivity";
  output Modelica.SIunits.NusseltNumber Nu "Nusselt number";
algorithm
  Nu := h*D/k;
  annotation (Documentation(info="Nusselt number Nu = alpha*D/lambda"));
end NusseltNumber;
