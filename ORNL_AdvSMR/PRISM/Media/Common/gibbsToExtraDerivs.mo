within ORNL_AdvSMR.PRISM.Media.Common;
function gibbsToExtraDerivs
  "compute additional thermodynamic derivatives from dimensionless Gibbs function"

  extends Modelica.Icons.Function;
  input GibbsDerivs g "dimensionless derivatives of Gibbs function";
  output ExtraDerivatives dpro "additional property derivatives";
protected
  Real vt "derivative of specific volume w.r.t. temperature";
  Real vp "derivative of specific volume w.r.t. pressure";
  SI.Density d "density";
  SI.SpecificVolume v "specific volume";
  SI.SpecificHeatCapacity cv "isochoric heat capacity";
  SI.SpecificHeatCapacity cp "isobaric heat capacity";
algorithm
  d := g.p/(g.R*g.T*g.pi*g.gpi);
  v := 1/d;
  vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
  vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
  cp := -g.R*g.tau*g.tau*g.gtautau;
  cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)
    /g.gpipi);
  dpro.kappa := -1/(d*g.p)*cp/(vp*cp + vt*vt*g.T);
  dpro.theta := cp/(d*g.p*(-vp*cp + vt*v - g.T*vt*vt));
  dpro.alpha := d*vt;
  dpro.beta := -vt/(g.p*vp);
  dpro.gamma := -d*vp;
  dpro.mu := -(v - g.T*vt)/cp;
end gibbsToExtraDerivs;
