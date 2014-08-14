within ORNL_AdvSMR.SmLMR.Media.Common;
record NewtonDerivatives_pT
  "derivatives for fast inverse calculations of Helmholtz functions:p & T"

  extends Modelica.Icons.Record;
  SI.Pressure p "pressure";
  DerPressureByDensity pd "derivative of pressure w.r.t. density";
end NewtonDerivatives_pT;
