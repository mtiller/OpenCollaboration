within ORNL_AdvSMR.Media.Interfaces.Types;
record DissipationProperties
  "Properties for homogeneously modeled fluid dissipation"
  extends Modelica.Icons.Record;
  Units.Density d "Density";
  Units.PrandtlNumber Pr "Prandtl number";
  Units.ThermalConductivity lambda "Thermal conductivity";
  Units.DynamicViscosity eta "Dynamic viscosity";
  Units.SpecificHeatCapacity cp "Specific heat capacity cp";
  annotation (defaultComponentName="properties");
end DissipationProperties;
