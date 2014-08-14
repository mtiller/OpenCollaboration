within ORNL_AdvSMR.SmLMR.Media.Common;
function helmholtzToBoundaryProps
  "calulate phase boundary property record from dimensionless Helmholtz function"

  extends Modelica.Icons.Function;
  input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
  output PhaseBoundaryProperties sat "phase boundary property record";
protected
  SI.Pressure p "pressure";
algorithm
  p := f.R*f.d*f.T*f.delta*f.fdelta;
  sat.d := f.d;
  sat.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
  sat.s := f.R*(f.tau*f.ftau - f.f);
  sat.u := f.R*f.T*f.tau*f.ftau;
  sat.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
    ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
  sat.cv := f.R*(-f.tau*f.tau*f.ftautau);
  sat.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
  sat.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
end helmholtzToBoundaryProps;
