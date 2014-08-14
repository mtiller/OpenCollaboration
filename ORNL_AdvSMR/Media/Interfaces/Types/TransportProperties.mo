within ORNL_AdvSMR.Media.Interfaces.Types;
record TransportProperties "Transport properties for single phase fluids"
  extends Modelica.Icons.Record;
  Units.PrandtlNumber Pr "Prandtl number";
  Units.ThermalConductivity lambda "Thermal conductivity";
  Units.DynamicViscosity eta "Dynamic viscosity";
  annotation (defaultComponentName="transport");
end TransportProperties;
