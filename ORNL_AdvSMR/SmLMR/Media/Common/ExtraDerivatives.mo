within ORNL_AdvSMR.SmLMR.Media.Common;
record ExtraDerivatives "additional thermodynamic derivatives"
  extends Modelica.Icons.Record;
  IsentropicExponent kappa "isentropic expansion coefficient";
  // k in Bejan
  IsenthalpicExponent theta "isenthalpic exponent";
  // same as kappa, except derivative at const h
  IsobaricVolumeExpansionCoefficient alpha
    "isobaric volume expansion coefficient";
  // beta in Bejan
  IsochoricPressureCoefficient beta "isochoric pressure coefficient";
  // kT in Bejan
  IsothermalCompressibility gamma "isothermal compressibility";
  // kappa in Bejan
  JouleThomsonCoefficient mu "Joule-Thomson coefficient";
  // mu_J in Bejan
end ExtraDerivatives;
