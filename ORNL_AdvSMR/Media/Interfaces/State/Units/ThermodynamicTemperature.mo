within ORNL_AdvSMR.Media.Interfaces.State.Units;
type ThermodynamicTemperature = Modelica.SIunits.Temperature (
    min=1,
    max=1.e4,
    nominal=300,
    start=300,
    displayUnit="K")
  "Type for thermodynamic temperature with medium specific attributes";
