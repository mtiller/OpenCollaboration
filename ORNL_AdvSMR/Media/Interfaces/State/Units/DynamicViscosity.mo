within ORNL_AdvSMR.Media.Interfaces.State.Units;
type DynamicViscosity = Modelica.SIunits.DynamicViscosity (
    min=0,
    max=1.e8,
    nominal=1.e-3,
    start=1.e-3) "Type for dynamic viscosity with medium specific attributes";
