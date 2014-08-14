within ORNL_AdvSMR.SmLMR.Media.Common;
record IF97PhaseBoundaryProperties
  "thermodynamic base properties on the phase boundary for IF97 steam tables"

  extends Modelica.Icons.Record;
  Boolean region3boundary "true if boundary between 2-phase and region 3";
  SI.SpecificHeatCapacity R "specific heat capacity";
  SI.Temperature T "temperature";
  SI.Density d "density";
  SI.SpecificEnthalpy h "specific enthalpy";
  SI.SpecificEntropy s "specific entropy";
  SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
  SI.SpecificHeatCapacity cv "heat capacity at constant volume";
  DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
  DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
  DerPressureByDensity pd "derivative of pressure w.r.t. density";
  Real vt(unit="m3/(kg.K)") "derivative of specific volume w.r.t. temperature";
  Real vp(unit="m3/(kg.Pa)") "derivative of specific volume w.r.t. pressure";
end IF97PhaseBoundaryProperties;
