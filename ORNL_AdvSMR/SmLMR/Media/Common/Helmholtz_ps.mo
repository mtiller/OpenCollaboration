within ORNL_AdvSMR.SmLMR.Media.Common;
function Helmholtz_ps
  "function to calculate analytic derivatives for computing d and t given p and s"

  extends Modelica.Icons.Function;
  input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
  output NewtonDerivatives_ps nderivs
    "derivatives for Newton iteration to compute d and t from p and s";
protected
  SI.SpecificHeatCapacity cv "isochoric heat capacity";
algorithm
  cv := -f.R*(f.tau*f.tau*f.ftautau);
  nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
  nderivs.s := f.R*(f.tau*f.ftau - f.f);
  nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
  nderivs.st := cv/f.T;
  nderivs.sd := -nderivs.pt/(f.d*f.d);
end Helmholtz_ps;
