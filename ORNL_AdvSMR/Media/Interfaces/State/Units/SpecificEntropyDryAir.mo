within ORNL_AdvSMR.Media.Interfaces.State.Units;
type SpecificEntropyDryAir = Real (
    final quantity="SpecificEntropyDryAir",
    final unit="J/(kg.K)",
    min=-1.e6,
    max=1.e6,
    nominal=1.e3) "Type for specific entropy with medium specific attributes";
