within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.Examples;
model TestGlycol "Test Glycol47 Medium model"
  extends Modelica.Icons.Example;
  package Medium = Glycol47 "Medium model (Glycol47)";
  Medium.BaseProperties medium;

  Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
  Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
  Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
  Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
protected
  constant Modelica.SIunits.Time timeUnit=1;
  constant Modelica.SIunits.Temperature Ta=1;
equation
  medium.p = 1e5;
  medium.T = Medium.T_min + time/timeUnit*Ta;
  annotation (experiment(StopTime=1.01));
end TestGlycol;
