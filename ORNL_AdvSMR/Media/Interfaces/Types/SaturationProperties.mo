within ORNL_AdvSMR.Media.Interfaces.Types;
record SaturationProperties "Saturation property record"
  extends Modelica.Icons.Record;
  Units.AbsolutePressure pl "Liquid pressure";
  Units.AbsolutePressure pv "Vapour pressure";
  Units.Temperature Tl "Liquid temperature";
  Units.Temperature Tv "Vapour temperature";
  Units.Density dl "Liquid density";
  Units.Density dv "Vapour density";
  Units.SpecificEnthalpy hl "Liquid specific enthalpy";
  Units.SpecificEnthalpy hv "Vapour specific enthalpy";
  Units.SpecificEntropy sl "Liquid specific entropy";
  Units.SpecificEntropy sv "Vapour specific entropy";
  annotation (defaultComponentName="sat");
end SaturationProperties;
