within ORNL_AdvSMR.Media.Interfaces.PartialMedium;
type MoleFraction = Real (
    quantity="MoleFraction",
    final unit="mol/mol",
    min=0,
    max=1,
    nominal=0.1) "Type for mole fraction with medium specific attributes";
