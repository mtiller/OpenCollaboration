within ORNL_AdvSMR.SmLMR.Media.Common;
function gibbsToBoundaryProps
  "calulate phase boundary property record from dimensionless Gibbs function"

  extends Modelica.Icons.Function;
  input GibbsDerivs g "dimensionless derivatives of Gibbs function";
  output PhaseBoundaryProperties sat "phase boundary properties";
protected
  Real vt "derivative of specific volume w.r.t. temperature";
  Real vp "derivative of specific volume w.r.t. pressure";
algorithm
  sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
  sat.h := g.R*g.T*g.tau*g.gtau;
  sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
  sat.s := g.R*(g.tau*g.gtau - g.g);
  sat.cp := -g.R*g.tau*g.tau*g.gtautau;
  sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
    *g.gtaupi)/(g.gpipi));
  vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
  vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
  // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
  sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
  sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
end gibbsToBoundaryProps;
