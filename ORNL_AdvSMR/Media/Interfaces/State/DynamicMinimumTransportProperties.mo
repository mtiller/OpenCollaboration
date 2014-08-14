within ORNL_AdvSMR.Media.Interfaces.State;
record DynamicMinimumTransportProperties
  "Transport properties for dynamic fluids"
  extends Modelica.Icons.Record;
  Units.DynamicViscosity eta "Dynamic viscosity";
  Units.ThermalConductivity lambda "Thermal conductivity";
  annotation (defaultComponentName="properties");
end DynamicMinimumTransportProperties;
