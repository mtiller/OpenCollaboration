within ORNL_AdvSMR.PRISM.Media.Interfaces.PartialMedium;
type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
    min=1,
    max=500000,
    nominal=1.2,
    start=1.2) "Type for isentropic exponent with medium specific attributes";
