within ORNL_AdvSMR.PRISM.Media.Interfaces.PartialMedium;
type VelocityOfSound = SI.Velocity (
    min=0,
    max=1.e5,
    nominal=1000,
    start=1000) "Type for velocity of sound with medium specific attributes";
