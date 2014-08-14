within ORNL_AdvSMR.Media.Common;
function Helmholtz_ph
  "function to calculate analytic derivatives for computing d and t given p and h"
  extends Modelica.Icons.Function;
  input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
  output NewtonDerivatives_ph nderivs
    "derivatives for Newton iteration to calculate d and t from p and h";
protected
  SI.SpecificHeatCapacity cv "isochoric heat capacity";
algorithm
  cv := -f.R*(f.tau*f.tau*f.ftautau);
  nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
  nderivs.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
  nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
  nderivs.ht := cv + nderivs.pt/f.d;
  nderivs.hd := (nderivs.pd - f.T*nderivs.pt/f.d)/f.d;
end Helmholtz_ph;
