within ORNL_AdvSMR.Media.Interfaces.Types;
record NewtonDerivatives_ps
  "derivatives for fast inverse calculation of Helmholtz functions: p & s"
  extends Modelica.Icons.Record;
  Modelica.SIunits.Pressure p "pressure";
  Modelica.SIunits.SpecificEntropy s "specific entropy";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure w.r.t. density";
  Modelon.Media.Interfaces.State.Units.DerPressureByTemperature pt
    "derivative of pressure w.r.t. temperature";
  Real sd "derivative of specific entropy w.r.t. density";
  Real st "derivative of specific entropy w.r.t. temperature";
end NewtonDerivatives_ps;
