within ORNL_AdvSMR.Functions.PumpCharacteristics;
function quadraticPower "Quadratic power consumption characteristic"
  extends basePower;
  input Modelica.SIunits.VolumeFlowRate q_nom[3]
    "Volume flow rate for three operating points (single pump)";
  input Modelica.SIunits.Power W_nom[3]
    "Power consumption for three operating points";
protected
  Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
    "Squared nominal flow rates";
  /* Linear system to determine the coefficients:
  W_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  W_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  W_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
  Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2], W_nom)
    "Coefficients of quadratic power consumption curve";
algorithm
  consumption := c[1] + q_flow*c[2] + q_flow^2*c[3];
end quadraticPower;
