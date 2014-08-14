within ORNL_AdvSMR.Media.Interfaces;
package Types "Definition of data types: enumerations and records"
// extends Modelon.Icons.TypesPackage;
import Modelon.Media.Interfaces.State.Units;


replaceable record FluidConstants
  "critical, triple, molecular and other standard data of fluid"
  extends Modelica.Icons.Record;
  String iupacName "complete IUPAC name (or common name, if non-existent)";
  String casRegistryNumber
    "chemical abstracts sequencing number (if it exists)";
  String chemicalFormula
    "Chemical formula, (brutto, nomenclature according to Hill";
  String structureFormula "Chemical structure formula";
  Units.MolarMass molarMass "molar mass";
  Units.Temperature criticalTemperature "critical temperature";
  Units.AbsolutePressure criticalPressure "critical pressure";
  Units.MolarVolume criticalMolarVolume "critical molar Volume";
  Units.Density criticalDensity "critical molar Volume";
  Units.SpecificEnthalpy criticalEnthalpy "critical specific enthalpy";
  Units.SpecificEntropy criticalEntropy "critical specific entropy";
  Real acentricFactor "Pitzer acentric factor";
  Units.Temperature triplePointTemperature "triple point temperature";
  Units.AbsolutePressure triplePointPressure "triple point pressure";
  Units.Temperature meltingPoint "melting point at 101325 Pa";
  Units.Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
  Units.DipoleMoment dipoleMoment
    "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
  Boolean hasIdealGasHeatCapacity=false
    "true if ideal gas heat capacity is available";
  Boolean hasCriticalData=false "true if critical data are known";
  Boolean hasDipoleMoment=false "true if a dipole moment known";
  Boolean hasFundamentalEquation=false "true if a fundamental equation";
  Boolean hasLiquidHeatCapacity=false
    "true if liquid heat capacity is available";
  Boolean hasSolidHeatCapacity=false "true if solid heat capacity is available";
  Boolean hasAccurateViscosityData=false
    "true if accurate data for a viscosity function is available";
  Boolean hasAccurateConductivityData=false
    "true if accurate data for thermal conductivity is available";
  Boolean hasVapourPressureCurve=false
    "true if vapour pressure data, e.g. Antoine coefficents are known";
  Boolean hasAcentricFactor=false "true if Pitzer accentric factor is known";
  Units.SpecificEnthalpy HCRIT0=0.0
    "Critical specific enthalpy of the fundamental equation";
  Units.SpecificEntropy SCRIT0=0.0
    "Critical specific entropy of the fundamental equation";
  Units.SpecificEnthalpy deltah=0.0
    "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
  Units.SpecificEntropy deltas=0.0
    "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
  annotation (Documentation(info="<html></html>"));
  end FluidConstants;


replaceable record SaturationProperties_pT
  "Saturation properties (psat,Tsat) of two phase medium"
  Modelon.Media.Interfaces.State.Units.AbsolutePressure psat
    "saturation pressure";
  Modelon.Media.Interfaces.State.Units.Temperature Tsat
    "saturation temperature";
  end SaturationProperties_pT;


annotation (Documentation(info="<html>
<h2>Enumerations and data types for all types of fluids</h2>
<p>Note: Reference enthalpy might have to be extended with enthalpy of formation. </p>
</html>"), Documentation(info="<html>
<h2>Enumerations and data types for all types of fluids</h2>
<p>Note: Reference enthalpy might have to be extended with enthalpy of formation. </p>
</html>"));

end Types;
