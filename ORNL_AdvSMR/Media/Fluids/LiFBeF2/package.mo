within ORNL_AdvSMR.Media.Fluids;
package LiFBeF2 "LiF-BeF2 (flibe) package"


extends Modelica.Icons.MaterialPropertiesPackage;

constant ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium.FluidConstants[1]
  flibeConstants(
  each chemicalFormula="LiFBeF2",
  each structureFormula="LiFBeF2",
  each casRegistryNumber="9999-99-9",
  each iupacName="flibe",
  each molarMass=0.03310239788 "(kg)",
  each criticalTemperature=2138.9 "(K)",
  each criticalPressure=1.8023e6 "(Pa)",
  each criticalMolarVolume=1/2500*0.03310239788 "(m3/mole)",
  each normalBoilingPoint=1432.1 "(K)",
  each meltingPoint=731.15 "(K)",
  each triplePointTemperature=731.15 "(K)",
  each triplePointPressure=6.367e-4 "(Pa)",
  each acentricFactor=0.344
    "Not correct: copied from water!!! Cetiner: Feb. 15, 2013",
  each dipoleMoment=1.8
    "Not correct: copied from water!!! Cetiner: Feb. 15, 2013",
  each hasCriticalData=true);

constant ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium.FluidConstants[1]
  simpleFlibeConstants(
  each chemicalFormula="LiFBeF2",
  each structureFormula="LiFBeF2",
  each molarMass=0.072947 "(kg)");

end LiFBeF2;
