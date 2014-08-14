within ORNL_AdvSMR.Media.Interfaces.PartialMaterial;
type DipoleMoment = Real (
    min=0.0,
    max=2.0,
    unit="debye",
    quantity="ElectricDipoleMoment")
  "Type for dipole moment with medium specific attributes";
