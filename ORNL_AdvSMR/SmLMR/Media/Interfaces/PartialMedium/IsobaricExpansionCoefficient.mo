within ORNL_AdvSMR.SmLMR.Media.Interfaces.PartialMedium;
type IsobaricExpansionCoefficient = Real (
    min=0,
    max=1.0e8,
    unit="1/K")
  "Type for isobaric expansion coefficient with medium specific attributes";
