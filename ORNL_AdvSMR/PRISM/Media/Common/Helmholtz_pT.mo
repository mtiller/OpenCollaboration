within ORNL_AdvSMR.PRISM.Media.Common;
function Helmholtz_pT
  "function to calculate analytic derivatives for computing d and t given p and t"

  extends Modelica.Icons.Function;
  input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
  output NewtonDerivatives_pT nderivs
    "derivatives for Newton iteration to compute d and t from p and t";
algorithm
  nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
  nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
end Helmholtz_pT;
