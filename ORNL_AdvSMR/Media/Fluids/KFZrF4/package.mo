within ORNL_AdvSMR.Media.Fluids;
package KFZrF4 


extends Modelica.Icons.MaterialPropertiesPackage;

constant ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium.FluidConstants[1]
  zrkfConstants(
  each chemicalFormula="KFZrF4",
  each structureFormula="KFZrF4",
  each casRegistryNumber="9999-99-9",
  each iupacName="flibe",
  each molarMass=0.103927478 "(kg)",
  each criticalTemperature=2138.9 "(K)",
  each criticalPressure=1.8023e6 "(Pa)",
  each criticalMolarVolume=1/3070*0.103927478 "(m3/mole)",
  each normalBoilingPoint=1704.8 "(K)",
  each meltingPoint=663.15 "(K)",
  each triplePointTemperature=663.15 "(K)",
  each triplePointPressure=2.145e-5 "(Pa)",
  each acentricFactor=0.344
    "Not correct: copied from water!!! Cetiner: Feb. 15, 2013",
  each dipoleMoment=1.8
    "Not correct: copied from water!!! Cetiner: Feb. 15, 2013",
  each hasCriticalData=true);

constant ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium.FluidConstants[1]
  simpleZrkfConstants(
  each chemicalFormula="KFZrF4",
  each structureFormula="KFZrF4",
  each molarMass=0.103927478 "(kg)");

end KFZrF4;
