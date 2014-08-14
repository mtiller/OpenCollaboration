within ORNL_AdvSMR.PRISM.Media.Interfaces.PartialMedium;
type Temperature = SI.Temperature (
    min=1,
    max=1.e4,
    nominal=300,
    start=300) "Type for temperature with medium specific attributes";
