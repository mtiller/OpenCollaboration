within ORNL_AdvSMR.Media.Interfaces.Types;
record NewtonDerivatives_pd
  "derivatives for fast inverse calculations of Helmholtz functions:p & T"
  extends Modelica.Icons.Record;
  Modelon.Media.Interfaces.State.Units.AbsolutePressure p "pressure";
  Real pt(unit="Pa/K") "derivative of pressure w.r.t. temperature";
  annotation (Documentation(info="<html><body>
<h3></h3>
<p></p>
</body></html>"));
end NewtonDerivatives_pd;
