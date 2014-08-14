within ORNL_AdvSMR.Media.Interfaces.PartialMedium;
type SpecificHeatCapacity = SI.SpecificHeatCapacity (
    min=0,
    max=1.e7,
    nominal=1.e3,
    start=1.e3)
  "Type for specific heat capacity with medium specific attributes";
