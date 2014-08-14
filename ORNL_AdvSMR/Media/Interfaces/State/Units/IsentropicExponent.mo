within ORNL_AdvSMR.Media.Interfaces.State.Units;
type IsentropicExponent = Modelica.SIunits.RatioOfSpecificHeatCapacities (
    min=1,
    max=500000,
    nominal=1.2,
    start=1.2) "Type for isentropic exponent with medium specific attributes";
