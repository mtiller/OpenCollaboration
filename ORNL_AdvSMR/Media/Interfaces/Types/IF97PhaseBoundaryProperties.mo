within ORNL_AdvSMR.Media.Interfaces.Types;
record IF97PhaseBoundaryProperties
  "thermodynamic base properties on the phase boundary for IF97 steam tables"
  extends Modelica.Icons.Record;
  Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.Density d "density";
  Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  Modelica.SIunits.SpecificEntropy s "specific entropy";
  Modelica.SIunits.SpecificHeatCapacity cp "heat capacity at constant pressure";
  Modelica.SIunits.SpecificHeatCapacity cv "heat capacity at constant volume";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature dpT
    "dp/dT derivative of saturation curve";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure wrt temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure wrt density";
  Real vt(unit="m3/(kg.K)") "derivative of specific volume w.r.t. temperature";
  Real vp(unit="m3/(kg.Pa)") "derivative of specific volume w.r.t. pressure";
end IF97PhaseBoundaryProperties;
