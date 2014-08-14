within ORNL_AdvSMR.Media.Interfaces.Types;
record HelmholtzDerivs
  "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Density d "density";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
  Real delta(unit="1") "dimensionless density";
  Real tau(unit="1") "dimensionless temperature";
  Real f(unit="1") "dimensionless Helmholtz-function";
  Real fdelta(unit="1") "derivative of f w.r.t. delta";
  Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
  Real ftau(unit="1") "derivative of f w.r.t. tau";
  Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
  Real fdeltatau(unit="1") "mixed derivative of f w.r.t. delta and tau";
end HelmholtzDerivs;
