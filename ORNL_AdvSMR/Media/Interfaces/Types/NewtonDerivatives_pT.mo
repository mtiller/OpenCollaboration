within ORNL_AdvSMR.Media.Interfaces.Types;
record NewtonDerivatives_pT
  "derivatives for fast inverse calculations of Helmholtz functions:p & T"
  extends Modelica.Icons.Record;
  Modelon.Media.Interfaces.State.Units.AbsolutePressure p "pressure";
  Modelon.Media.Interfaces.State.Units.DerPressureByDensity pd
    "derivative of pressure w.r.t. density";
end NewtonDerivatives_pT;
