within ORNL_AdvSMR.Media.Interfaces.PartialMedium;
type ThermalConductivity = SI.ThermalConductivity (
    min=0,
    max=500,
    nominal=1,
    start=1) "Type for thermal conductivity with medium specific attributes";
