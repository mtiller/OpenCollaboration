within ORNL_AdvSMR.Media.DataDefinitions.LinearLiquids;
record LinearFluid "Constants for a linear fluid"
  extends Modelica.Icons.Record;
  constant Units.SpecificHeatCapacity cp_const
    "Specific heat capacity at constant pressure";
  constant Units.VolumetricExpansionCoefficient beta_const
    "Thermal expansion coefficient at constant pressure";
  constant Units.IsothermalCompressibility kappa_const
    "Isothermal compressibility";
  constant Units.Temperature reference_T
    "Reference Temperature: often the linearization point";
  constant Units.AbsolutePressure reference_p
    "Reference Pressure: often the linearization point";
  constant Units.Density reference_d "Density in reference conditions";
  constant Units.SpecificEnthalpy reference_h
    "Specific enthalpy in reference conditions";
  constant Units.SpecificEntropy reference_s
    "Specific enthalpy in reference conditions";
  constant Units.MolarMass MM "Molar mass";
end LinearFluid;
