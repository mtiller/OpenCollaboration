within ORNL_AdvSMR.Media.Common;
function gibbsToBridgmansTables
  "calculates base coefficients for bridgemans tables from gibbs enthalpy"

  extends Modelica.Icons.Function;
  input GibbsDerivs g "dimensionless derivatives of Gibbs function";
  output SI.SpecificVolume v "specific volume";
  output SI.Pressure p=g.p "pressure";
  output SI.Temperature T=g.T "temperature";
  output SI.SpecificEntropy s "specific entropy";
  output SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
  output IsobaricVolumeExpansionCoefficient alpha
    "isobaric volume expansion coefficient";
  // beta in Bejan
  output IsothermalCompressibility gamma "isothermal compressibility";
  // kappa in Bejan
protected
  Real vt(unit="m3/(kg.K)") "derivative of specific volume w.r.t. temperature";
  Real vp(unit="m4.kg-2.s2") "derivative of specific volume w.r.t. pressure";
algorithm
  vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
  vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
  v := (g.R*g.T*g.pi*g.gpi)/g.p;
  s := g.R*(g.tau*g.gtau - g.g);
  cp := -g.R*g.tau*g.tau*g.gtautau;
  alpha := vt/v;
  gamma := -vp/v;
end gibbsToBridgmansTables;
