within ORNL_AdvSMR.Functions.FanCharacteristics;
function quadraticFlowBlades "Quadratic flow characteristic, movable blades"
  extends baseFlow;
  input Real bladePos_nom[:];
  input Modelica.SIunits.VolumeFlowRate q_nom[3, :]
    "Volume flow rate for three operating points at N_pos blade positionings";
  input Modelica.SIunits.Height H_nom[3, :]
    "Specific work for three operating points at N_pos blade positionings";
  input Real slope_s(
    unit="(J/kg)/(m3/s)",
    max=0) = 0
    "Slope of flow characteristic at stalling conditions (must be negative)";
algorithm
  H := Utilities.quadraticFlowBlades(
    q_flow,
    bladePos,
    bladePos_nom,
    Utilities.quadraticFlowBladesCoeff(
      bladePos_nom,
      q_nom,
      H_nom),
    slope_s);
end quadraticFlowBlades;
