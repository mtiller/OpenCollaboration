within ORNL_AdvSMR.Functions.FanCharacteristics.Utilities;
function quadraticFlowBlades "Quadratic flow characteristic, movable blades"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.VolumeFlowRate q_flow;
  input Real bladePos;
  input Real bladePos_nom[:];
  input Real c[:, :] "Coefficients of quadratic specific work characteristic";
  input Real slope_s(
    unit="(J/kg)/(m3/s)",
    max=0) = 0
    "Slope of flow characteristic at stalling conditions (must be negative)";
  output Modelica.SIunits.SpecificEnergy H "Specific Energy";
protected
  Integer N_pos=size(bladePos_nom, 1);
  Integer i;
  Real alpha;
  Real q_s "Volume flow rate at stalling conditions";
algorithm
  // Flow equation: H = c[1] + q_flow*c[2] + q_flow^2*c[3];
  i := N_pos - 1;
  while bladePos <= bladePos_nom[i] and i > 1 loop
    i := i - 1;
  end while;
  alpha := (bladePos - bladePos_nom[i])/(bladePos_nom[i + 1] - bladePos_nom[i]);
  q_s := (slope_s - ((1 - alpha)*c[2, i] + alpha*c[2, i + 1]))/(2*((1 - alpha)*
    c[3, i] + alpha*c[3, i + 1]));
  H := if q_flow > q_s then ((1 - alpha)*c[1, i] + alpha*c[1, i + 1]) + ((1 -
    alpha)*c[2, i] + alpha*c[2, i + 1])*q_flow + ((1 - alpha)*c[3, i] + alpha*c[
    3, i + 1])*q_flow^2 else ((1 - alpha)*c[1, i] + alpha*c[1, i + 1]) + ((1 -
    alpha)*c[2, i] + alpha*c[2, i + 1])*q_s + ((1 - alpha)*c[3, i] + alpha*c[3,
    i + 1])*q_s^2 + (q_flow - q_s)*slope_s;
end quadraticFlowBlades;
