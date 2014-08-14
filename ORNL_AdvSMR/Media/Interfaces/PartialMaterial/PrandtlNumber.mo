within ORNL_AdvSMR.Media.Interfaces.PartialMaterial;
type PrandtlNumber = SI.PrandtlNumber (
    min=1e-3,
    max=1e5,
    nominal=1.0) "Type for Prandtl number with medium specific attributes";
