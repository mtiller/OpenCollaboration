within ORNL_AdvSMR.Media.Interfaces.PartialMedium;
type MolarVolume = SI.MolarVolume (
    min=1e-6,
    max=1.0e6,
    nominal=1.0) "Type for molar volume with medium specific attributes";
