within ORNL_AdvSMR.SmLMR.Media.Common;
function helmholtzToExtraDerivs
  "compute additional thermodynamic derivatives from dimensionless Helmholtz function"

  extends Modelica.Icons.Function;
  input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
  output ExtraDerivatives dpro "additional property derivatives";
protected
  SI.Pressure p "pressure";
  SI.SpecificVolume v "specific volume";
  DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
  DerPressureBySpecificVolume pv
    "derivative of pressure w.r.t. specific volume";
  SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
algorithm
  v := 1/f.d;
  p := f.R*f.d*f.T*f.delta*f.fdelta;
  pv := -(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
  cv := f.R*(-f.tau*f.tau*f.ftautau);
  dpro.kappa := 1/(f.d*p)*((-pv*cv + pt*pt*f.T)/(cv));
  dpro.theta := -1/(f.d*p)*((-pv*cv + f.T*pt*pt)/(cv + pt*v));
  dpro.alpha := -f.d*pt/pv;
  dpro.beta := pt/p;
  dpro.gamma := -f.d/pv;
  dpro.mu := (v*pv + f.T*pt)/(pt*pt*f.T - pv*cv);
end helmholtzToExtraDerivs;
