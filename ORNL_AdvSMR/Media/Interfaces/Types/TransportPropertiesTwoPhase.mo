within ORNL_AdvSMR.Media.Interfaces.Types;
record TransportPropertiesTwoPhase "Transport properties for 2-phase fluids"
  extends TransportProperties;
  Units.SurfaceTension sigma "surface tension";
  annotation (defaultComponentName="transport");
end TransportPropertiesTwoPhase;
