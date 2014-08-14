within ORNL_AdvSMR.Media.Interfaces.Types;
record ExtendedSaturationProperties
  "Extended saturation property record (data for Brdgman's table)"
  extends SaturationProperties;
  Units.VolumetricExpansionCoefficient betal
    "isothermal expansion coefficient at bubble point";
  Units.VolumetricExpansionCoefficient betav
    "isothermal expansion coefficient at dew point";
  Units.IsothermalCompressibility kappal
    "isothermal compressibility at bubble point";
  Units.IsothermalCompressibility kappav
    "isothermal compressibility at dew point";
  Units.SpecificHeatCapacity cpl "specific heat capacity cp at bubble point";
  Units.SpecificHeatCapacity cpv "specific heat capacity cp at dew point";
  annotation (defaultComponentName="sat");
end ExtendedSaturationProperties;
