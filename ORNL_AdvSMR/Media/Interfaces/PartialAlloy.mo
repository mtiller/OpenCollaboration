within ORNL_AdvSMR.Media.Interfaces;
partial package PartialAlloy "Simple abstract alloy properties"

  extends Modelica.Icons.MaterialPropertiesPackage;

  import Modelica.SIunits.*;

  // Constants to be set in Material
  constant String materialName "Name of the material";
  constant String materialDescription "Description of the material";

  // Material properties depending on the material state
  replaceable partial function density "Density as a function of temperature"
    input Temperature T "Temperature (K)";
    output Density rho "Density (kg/m3)";
  end density;

  replaceable partial function thermalConductivity
    "Thermal conductivity as a function of temperature"
    input Temperature T "Temperature (K)";
    output ThermalConductivity k "Thermal conductivity (W/mK)";
  end thermalConductivity;

  replaceable partial function specificHeatCapacity
    "Specific heat capacity as a function of temperature"
    input Temperature T "Temperature (K)";
    output SpecificHeatCapacity cp "Specific heat capacity (J/kgK)";
  end specificHeatCapacity;

  replaceable partial function linearExpansionCoefficient
    "Linear expansion coefficient as a function of temperature"
    input Temperature T "Temperature (K)";
    output LinearExpansionCoefficient alpha
      "Linear expansion coefficient of the material (1/K)";
  end linearExpansionCoefficient;

  replaceable partial function emissivity "Emissivity"
    output Emissivity eps "Emissivity";
  algorithm
    eps := 0.85;
  end emissivity;

end PartialAlloy;
