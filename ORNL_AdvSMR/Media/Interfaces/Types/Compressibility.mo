within ORNL_AdvSMR.Media.Interfaces.Types;
type Compressibility = enumeration(
    ConstantDensity "The density is a constant",
    TemperatureDependent "The density is a function of temperature",
    PressureDependent "The density is a function of pressure",
    FullyCompressible
      "The density is a function of the full thermodynamic state")
  "Enumeration defining the compressibility properties" annotation (Evaluate=
      true);
