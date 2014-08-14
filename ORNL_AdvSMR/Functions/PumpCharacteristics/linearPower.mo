within ORNL_AdvSMR.Functions.PumpCharacteristics;
function linearPower "Linear power consumption characteristic"
  extends basePower;
  input Modelica.SIunits.VolumeFlowRate q_nom[2]
    "Volume flow rate for two operating points (single pump)";
  input Modelica.SIunits.Power W_nom[2]
    "Power consumption for two operating points";
  /* Linear system to determine the coefficients:
  W_nom[1] = c[1] + q_nom[1]*c[2];
  W_nom[2] = c[1] + q_nom[2]*c[2];
  */
protected
  Real c[2]=Modelica.Math.Matrices.solve([ones(2), q_nom], W_nom)
    "Coefficients of quadratic power consumption curve";
algorithm
  consumption := c[1] + q_flow*c[2];
end linearPower;
