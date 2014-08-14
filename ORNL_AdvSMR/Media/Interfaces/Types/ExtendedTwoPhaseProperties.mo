within ORNL_AdvSMR.Media.Interfaces.Types;
record ExtendedTwoPhaseProperties
  "Properties for 2-phase fluidsstandard properties for two phase fluids"
  extends TwoPhaseProperties;
  TransportPropertiesTwoPhase transport_liq "Bubble point transport properties";
  TransportPropertiesTwoPhase transport_vap "Dew point transport properties";
  CriticalConstants crit "critical point data";
  annotation (defaultComponentName="properties");
end ExtendedTwoPhaseProperties;
