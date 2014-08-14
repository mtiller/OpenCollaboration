within ORNL_AdvSMR.Media.Interfaces.Types;
record StandardProperties "standard properties for single phase fluids"
  extends Modelica.Icons.Record;
  Units.Density d "Density";
  Units.Temperature T "Temperature";
  Units.AbsolutePressure p "Pressure";
  Units.SpecificEnthalpy h "Specific enthalpy";
  Units.SpecificEntropy s "Specific entropy";
  Units.SpecificHeatCapacity cp "Specific heat capacity cp";
  annotation (defaultComponentName="properties");
end StandardProperties;
