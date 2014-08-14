within ORNL_AdvSMR.Media.Common;
record NewtonDerivatives_ph
  "derivatives for fast inverse calculations of Helmholtz functions: p & h"

  extends Modelica.Icons.Record;
  SI.Pressure p "pressure";
  SI.SpecificEnthalpy h "specific enthalpy";
  DerPressureByDensity pd "derivative of pressure w.r.t. density";
  DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
  Real hd "derivative of specific enthalpy w.r.t. density";
  Real ht "derivative of specific enthalpy w.r.t. temperature";
end NewtonDerivatives_ph;
