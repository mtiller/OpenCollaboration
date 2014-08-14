within ORNL_AdvSMR.SmLMR.Media.MaterialProperties.Interfaces;
partial model PartialMaterial
  "Partial material properties (base model of all material models)"

  import Modelica.SIunits.*;

  // Constants to be set in Material
  constant String materialName "Name of the material";
  constant String materialDescription "Textual description of the material";

  constant PoissonNumber poissonRatio "Poisson ration of material";
  constant Density density "Density of material";

  // Material properties depending on the material state
  ModulusOfElasticity youngModulus "Young modulus of material";
  Stress yieldStress "Tensione di snervamento";
  Stress ultimateStress "Tensione di rottura";
  LinearExpansionCoefficient linearExpansionCoefficient
    "Linear expansion coefficient of the material";
  SpecificHeatCapacity specificHeatCapacity
    "Specific heat capacity of material";
  ThermalConductivity thermalConductivity
    "Thermal conductivity of the material";

  // Material thermodynamic state
  Temperature T "Material temperature";
end PartialMaterial;
