within ORNL_AdvSMR.Media.Interfaces.State;
record DynamicMinimumSaturationProperties
  "Standard properties for dynamic two phase fluids"
  extends Modelica.Icons.Record;
  Units.Density d_liq "Density";
  Units.Temperature T_liq "Temperature";
  Units.AbsolutePressure p_liq "Pressure";
  Units.SpecificEnthalpy h_liq "Specific enthalpy";
  Units.SpecificEntropy s_liq "Specific entropy";
  Units.Density d_vap "Density";
  Units.Temperature T_vap "Temperature";
  Units.AbsolutePressure p_vap "Pressure";
  Units.SpecificEnthalpy h_vap "Specific enthalpy";
  Units.SpecificEntropy s_vap "Specific entropy";
  Units.DynamicViscosity eta_vap;
  Units.DynamicViscosity eta_liq;
  Units.SpecificHeatCapacity cp_vap;
  Units.SpecificHeatCapacity cp_liq;
  Units.ThermalConductivity lam_liq;
  Units.ThermalConductivity lam_vap;
  Units.MassFraction x;
  annotation (defaultComponentName="properties");
end DynamicMinimumSaturationProperties;
