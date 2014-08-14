within ORNL_AdvSMR.Media.Interfaces.Types;
record IF97PhaseBoundaryProperties3rd
  "Thermodynamic base properties on the phase boundary, Analytic Jacobian version"
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
  Real dpTT(unit="Pa/(K.K)") "Second derivative of saturaiton curve";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure wrt temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure wrt density";
  Real vt(unit="m3/(kg.K)") "derivative of specific volume w.r.t. temperature";
  Real vp(unit="m3/(kg.Pa)") "derivative of specific volume w.r.t. pressure";
  Real cvt "Derivative of cv w.r.t. temperature";
  Real cpt "Derivative of cp w.r.t. temperature";
  Real ptt "2nd derivative of pressure wrt temperature";
  Real pdd "2nd derivative of pressure wrt density";
  Real ptd "Mixed derivative of pressure w.r.t. density and temperature";
  Real vtt "2nd derivative of specific volume w.r.t. temperature";
  Real vpp "2nd derivative of specific volume w.r.t. pressure";
  Real vtp
    "Mixed derivative of specific volume w.r.t. pressure and temperature";
end IF97PhaseBoundaryProperties3rd;
