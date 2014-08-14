within ORNL_AdvSMR.Media.Interfaces.State;
record DynamicMinimumTwoPhaseProperties
  "Standard properties for dynamic two phase fluids (p and h assumed to be states)"
  extends Modelica.Icons.Record;
  Units.AbsolutePressure p "Pressure";
  Units.SpecificEnthalpy h "Specific enthalpy";
  Units.Density d "Density";
  Units.Temperature T "Temperature";
  Units.SpecificEntropy s "Specific entropy";
  Units.SpecificHeatCapacity cp "Specific heat capacity cp";
  Units.SpecificHeatCapacity cv "Specific heat capacity cv";
  Units.DerDensityByPressure ddph
    "partial derivative of density with respect to pressure at constant specific enthalpy";
  Units.DerDensityByEnthalpy ddhp
    "partial derivative of density with respect to specific enthalpy at constant pressure";
  annotation (defaultComponentName="properties");
end DynamicMinimumTwoPhaseProperties;
