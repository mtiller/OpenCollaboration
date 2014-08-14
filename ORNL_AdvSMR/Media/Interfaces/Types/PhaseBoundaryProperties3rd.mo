within ORNL_AdvSMR.Media.Interfaces.Types;
record PhaseBoundaryProperties3rd
  "thermodynamic base properties on the phase boundary"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Temperature T "Temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature dpT
    "dp/dT derivative of saturation curve";
  Modelica.SIunits.Density d "Density";
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  Modelica.SIunits.SpecificEnergy u "Inner energy";
  Modelica.SIunits.SpecificEntropy s "Specific entropy";
  Modelica.SIunits.SpecificHeatCapacity cp "Heat capacity at constant pressure";
  Modelica.SIunits.SpecificHeatCapacity cv "Heat capacity at constant volume";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "Derivative of pressure wrt temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "Derivative of pressure wrt density";
  Real cvt "Derivative of cv w.r.t. temperature";
  Real cpt "Derivative of cp w.r.t. temperature";
  Real ptt "2nd derivative of pressure wrt temperature";
  Real pdd "2nd derivative of pressure wrt density";
  Real ptd "Mixed derivative of pressure w.r.t. density and temperature";
  Real vt "Derivative of specific volume w.r.t. temperature";
  Real vp "Derivative of specific volume w.r.t. pressure";
  Real vtt "2nd derivative of specific volume w.r.t. temperature";
  Real vpp "2nd derivative of specific volume w.r.t. pressure";
  Real vtp
    "Mixed derivative of specific volume w.r.t. pressure and temperature";
end PhaseBoundaryProperties3rd;
