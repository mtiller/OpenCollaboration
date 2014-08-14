within ORNL_AdvSMR.Media.Interfaces.PartialMedium;
type Density = SI.Density (
    min=0,
    max=1.e5,
    nominal=1,
    start=1) "Type for density with medium specific attributes";
