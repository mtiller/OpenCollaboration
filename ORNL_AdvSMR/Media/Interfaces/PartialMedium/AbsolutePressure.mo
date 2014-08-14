within ORNL_AdvSMR.Media.Interfaces.PartialMedium;
type AbsolutePressure = SI.AbsolutePressure (
    min=0,
    max=1.e8,
    nominal=1.e5,
    start=1.e5) "Type for absolute pressure with medium specific attributes";
