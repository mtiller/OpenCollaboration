within ORNL_AdvSMR.PRISM.Media.Common;
record IF97BaseTwoPhase "Intermediate property data record for IF 97"
  extends Modelica.Icons.Record;
  Integer phase=0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  Integer region(min=1, max=5) "IF 97 region";
  SI.Pressure p "pressure";
  SI.Temperature T "temperature";
  SI.SpecificEnthalpy h "specific enthalpy";
  SI.SpecificHeatCapacity R "gas constant";
  SI.SpecificHeatCapacity cp "specific heat capacity";
  SI.SpecificHeatCapacity cv "specific heat capacity";
  SI.Density rho "density";
  SI.SpecificEntropy s "specific entropy";
  DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
  DerPressureByDensity pd "derivative of pressure w.r.t. density";
  Real vt "derivative of specific volume w.r.t. temperature";
  Real vp "derivative of specific volume w.r.t. pressure";
  Real x "dryness fraction";
  Real dpT "dp/dT derivative of saturation curve";
end IF97BaseTwoPhase;
