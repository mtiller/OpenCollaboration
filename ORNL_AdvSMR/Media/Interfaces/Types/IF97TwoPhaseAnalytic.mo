within ORNL_AdvSMR.Media.Interfaces.Types;
record IF97TwoPhaseAnalytic
  "Intermediate property data record for IF97, analytic Jacobian version"
  extends Modelica.Icons.Record;
  Integer phase "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  Integer region(min=1, max=5) "IF 97 region";
  Modelica.SIunits.Pressure p "pressure";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  Modelica.SIunits.SpecificHeatCapacity R "gas constant";
  Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
  Real cpt "derivative of cp w.r.t. temperature";
  Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
  Real cvt "derivative of cv w.r.t. temperature";
  Modelica.SIunits.Density rho "density";
  Modelica.SIunits.SpecificEntropy s "specific entropy";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure wrt temperature";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure wrt density";
  Real ptt "2nd derivative of pressure wrt temperature";
  Real pdd "2nd derivative of pressure wrt density";
  Real ptd "mixed derivative of pressure w.r.t. density and temperature";
  Real vt "derivative of specific volume w.r.t. temperature";
  Real vp "derivative of specific volume w.r.t. pressure";
  Real vtt "2nd derivative of specific volume w.r.t. temperature";
  Real vpp "2nd derivative of specific volume w.r.t. pressure";
  Real vtp
    "mixed derivative of specific volume w.r.t. pressure and temperature";
  Real x "dryness fraction";
  Real dpT "dp/dT derivative of saturation curve";
end IF97TwoPhaseAnalytic;
