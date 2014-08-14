within ORNL_AdvSMR.Media.Interfaces.Types;
record DynamicMinimumPropertiesSinglePhase
  "Standard properties for dynamic single phase fluids"
  extends Modelica.Icons.Record;
  Units.Density d "Density";
  Units.Temperature T "Temperature";
  Units.AbsolutePressure p "Pressure";
  Units.SpecificEnthalpy h "Specific enthalpy";
  Units.SpecificEntropy s "Specific entropy";
  Units.SpecificHeatCapacity cp "Specific heat capacity cp";
  Units.SpecificHeatCapacity cv "Specific heat capacity cv";
  Units.DerDensityByTemperature dddT;
  Units.DerDensityByPressure dddp;
  annotation (defaultComponentName="properties");
end DynamicMinimumPropertiesSinglePhase;
