within ORNL_AdvSMR.Media.Interfaces.Types;
record NewtonDerivatives_ph
  "derivatives for fast inverse calculations of Helmholtz functions: p & h"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Pressure p "pressure";
  Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure w.r.t. density";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure w.r.t. temperature";
  Real hd "derivative of specific enthalpy w.r.t. density";
  Real ht "derivative of specific enthalpy w.r.t. temperature";
end NewtonDerivatives_ph;
