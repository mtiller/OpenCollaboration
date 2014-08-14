within ORNL_AdvSMR.Media.Interfaces.Types;
record GibbsDerivs3rd
  "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature, including 3rd derivatives"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Pressure p "pressure";
  Modelica.SIunits.Temperature T "temperature";
  Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
  Real pi(unit="1") "dimensionless pressure";
  Real tau(unit="1") "dimensionless temperature";
  Real g(unit="1") "dimensionless Gibbs-function";
  Real gpi(unit="1") "derivative of g w.r.t. pi";
  Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
  Real gpipipi(unit="1") "3rd derivative of g w.r.t. pi";
  Real gtau(unit="1") "derivative of g w.r.t. tau";
  Real gtautau(unit="1") "2nd derivative of g w.r.t tau";
  Real gtautautau(unit="1") "3rd derivative of g w.r.t tau";
  Real gpitau(unit="1") "mixed derivative of g w.r.t. pi and tau";
  Real gpitautau(unit="1") "mixed derivative of g w.r.t. pi and tau (2nd)";
  Real gpipitau(unit="1") "mixed derivative of g w.r.t. pi (2nd) and tau";
end GibbsDerivs3rd;
