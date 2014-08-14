within ORNL_AdvSMR.Media.Interfaces.Types;
record IF97BaseTwoPhase "Intermediate property data record for IF 97"
  extends Modelica.Icons.Record;
  Integer phase "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  Integer region(min=1, max=5) "IF 97 region";
  Modelica.SIunits.Pressure p "pressure";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  Modelica.SIunits.SpecificHeatCapacity R "gas constant";
  Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
  Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
  Modelica.SIunits.Density rho "density";
  Modelica.SIunits.SpecificEntropy s "specific entropy";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure wrt temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure wrt density";
  Real vt "derivative of specific volume w.r.t. temperature";
  Real vp "derivative of specific volume w.r.t. pressure";
  Real x "dryness fraction";
  Real dpT "dp/dT derivative of saturation curve";
end IF97BaseTwoPhase;
