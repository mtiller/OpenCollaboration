within ORNL_AdvSMR.Media.Interfaces.Types;
record ExtraDerivatives "additional thermodynamic derivatives"
  extends Modelica.Icons.Record;
  Modelon.Media.Interfaces.State.Units.IsentropicExponent kappa
    "isentropic expansion coefficient";
  // k in Bejan
  Modelon.Media.Interfaces.State.Units.IsenthalpicExponent theta
    "isenthalpic exponent";
  // same as kappa, except derivative at const h
  Modelon.Media.Interfaces.State.Units.IsobaricVolumeExpansionCoefficient alpha
    "isobaric volume expansion coefficient";
  // beta in Bejan
  Modelon.Media.Interfaces.State.Units.IsochoricPressureCoefficient beta
    "isochoric pressure coefficient";
  // kT in Bejan
  Modelon.Media.Interfaces.State.Units.IsothermalCompressibility gamma
    "isothermal compressibility";
  // kappa in Bejan
  Modelon.Media.Interfaces.State.Units.JouleThomsonCoefficient mu
    "Joule-Thomson coefficient";
  // mu_J in Bejan
end ExtraDerivatives;
