within ORNL_AdvSMR.Media.Interfaces.State.Units;
type VolumetricExpansionCoefficient = Real (
    min=1e-8,
    max=1.0e8,
    unit="1/K")
  "Type for volumetric expansion coefficient with medium specific attributes";
