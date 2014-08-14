within ORNL_AdvSMR.SmLMR.Media.Common;
record NewtonDerivatives_ps
  "derivatives for fast inverse calculation of Helmholtz functions: p & s"

  extends Modelica.Icons.Record;
  SI.Pressure p "pressure";
  SI.SpecificEntropy s "specific entropy";
  DerPressureByDensity pd "derivative of pressure w.r.t. density";
  DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
  Real sd "derivative of specific entropy w.r.t. density";
  Real st "derivative of specific entropy w.r.t. temperature";
end NewtonDerivatives_ps;
