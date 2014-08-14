within ORNL_AdvSMR.Media.Interfaces.State.Units;
type DipoleMoment = Real (
    min=0.0,
    max=3.0,
    unit="debye",
    quantity="ElectricDipoleMoment")
  "Type for dipole moment with medium specific attributes";
