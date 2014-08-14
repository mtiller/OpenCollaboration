within ORNL_AdvSMR.Media.Interfaces.State.Units;
type MassFraction = Real (
    quantity="MassFraction",
    final unit="kg/kg",
    min=0,
    max=1,
    nominal=0.1) "Type for mass fraction with medium specific attributes";
