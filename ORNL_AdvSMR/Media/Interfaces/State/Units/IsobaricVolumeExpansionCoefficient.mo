within ORNL_AdvSMR.Media.Interfaces.State.Units;
type IsobaricVolumeExpansionCoefficient = Real (
    min=1e-12,
    max=1000.0,
    final quantity="IsobaricVolumeExpansionCoefficient",
    unit="1/K");
