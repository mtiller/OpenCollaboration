within ORNL_AdvSMR.Media.Interfaces;
partial package PartialMixtureMedium "Base class for pure substances of several chemical substances"
extends PartialMedium;


redeclare replaceable record extends ThermodynamicState
  "thermodynamic state variables"
  AbsolutePressure p "Absolute pressure of medium";
  Temperature T "Temperature of medium";
  MassFraction X[nX] "Mass fractions (= (component mass)/total mass  m_i/m)";
  end ThermodynamicState;


redeclare replaceable record extends FluidConstants "extended fluid constants"
  Temperature criticalTemperature "critical temperature";
  AbsolutePressure criticalPressure "critical pressure";
  MolarVolume criticalMolarVolume "critical molar Volume";
  Real acentricFactor "Pitzer acentric factor";
  Temperature triplePointTemperature "triple point temperature";
  AbsolutePressure triplePointPressure "triple point pressure";
  Temperature meltingPoint "melting point at 101325 Pa";
  Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
  DipoleMoment dipoleMoment
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
    "true if vapour pressure data, e.g., Antoine coefficents are known";
  Boolean hasAcentricFactor=false "true if Pitzer accentric factor is known";
  SpecificEnthalpy HCRIT0=0.0
    "Critical specific enthalpy of the fundamental equation";
  SpecificEntropy SCRIT0=0.0
    "Critical specific entropy of the fundamental equation";
  SpecificEnthalpy deltah=0.0
    "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
  SpecificEntropy deltas=0.0
    "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
  end FluidConstants;

constant FluidConstants[nS] fluidConstants "constant data for the fluid";


replaceable function gasConstant
  "Return the gas constant of the mixture (also for liquids)"
  extends Modelica.Icons.Function;
  input ThermodynamicState state "thermodynamic state";
  output SI.SpecificHeatCapacity R "mixture gas constant";
  end gasConstant;

end PartialMixtureMedium;
