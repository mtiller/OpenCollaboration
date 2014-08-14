within ORNL_AdvSMR.Media.Interfaces.Types;
record HelmholtzDerivs3rd
  "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature, including 3rd derivatives"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Density d "density";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
  Real delta(unit="1") "dimensionless density";
  Real tau(unit="1") "dimensionless temperature";
  Real f(unit="1") "dimensionless Helmholtz-function";
  Real fdelta(unit="1") "derivative of f w.r.t. delta";
  Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
  Real fdeltadeltadelta(unit="1") "3rd derivative of f w.r.t. delta";
  Real ftau(unit="1") "derivative of f w.r.t. tau";
  Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
  Real ftautautau(unit="1") "3rd derivative of f w.r.t. tau";
  Real fdeltatau(unit="1") "mixed derivative of f w.r.t. delta and tau";
  Real fdeltadeltatau(unit="1")
    "mixed derivative of f w.r.t. delta (2nd) and tau";
  Real fdeltatautau(unit="1")
    "mixed derivative of f w.r.t. delta and tau (2nd) ";
end HelmholtzDerivs3rd;
