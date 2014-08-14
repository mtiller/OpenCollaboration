within ORNL_AdvSMR.Media.Interfaces.State.Units;
type SpecificEnthalpyDryAir = Real (
    final quantity="SpecificEnergyDryAir",
    final unit="J/kg",
    min=-1.0e8,
    max=1.e8,
    nominal=1.e6) "Type for specific enthalpy with medium specific attributes";
