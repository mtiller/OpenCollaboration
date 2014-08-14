within ORNL_AdvSMR.PRISM.Media.Common;
function helmholtzToBridgmansTables
  "calculates base coefficients for Bridgmans tables from helmholtz energy"
  extends Modelica.Icons.Function;
  input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
  output SI.SpecificVolume v=1/f.d "specific volume";
  output SI.Pressure p "pressure";
  output SI.Temperature T=f.T "temperature";
  output SI.SpecificEntropy s "specific entropy";
  output SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
  output IsobaricVolumeExpansionCoefficient alpha
    "isobaric volume expansion coefficient";
  // beta in Bejan
  output IsothermalCompressibility gamma "isothermal compressibility";
  // kappa in Bejan
protected
  DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
  DerPressureBySpecificVolume pv
    "derivative of pressure w.r.t. specific volume ";
  SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
algorithm
  p := f.R*f.d*f.T*f.delta*f.fdelta;
  pv := -(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
  s := f.R*(f.tau*f.ftau - f.f);
  alpha := -f.d*pt/pv;
  gamma := -f.d/pv;
  cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
    ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
end helmholtzToBridgmansTables;
