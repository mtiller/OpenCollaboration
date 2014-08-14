within ORNL_AdvSMR.Media.Interfaces.Types;
record PhaseBoundaryProperties
  "thermodynamic base properties on the phase boundary"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Density d "density";
  Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  Modelica.SIunits.SpecificEnergy u "inner energy";
  Modelica.SIunits.SpecificEntropy s "specific entropy";
  Modelica.SIunits.SpecificHeatCapacity cp "heat capacity at constant pressure";
  Modelica.SIunits.SpecificHeatCapacity cv "heat capacity at constant volume";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure wrt temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure wrt density";
end PhaseBoundaryProperties;
