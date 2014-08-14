within ORNL_AdvSMR.Functions.PumpCharacteristics;
function quadraticFlow "Quadratic flow characteristic"
  extends baseFlow;
  input Modelica.SIunits.VolumeFlowRate q_nom[3]
    "Volume flow rate for three operating points (single pump)";
  input Modelica.SIunits.Height head_nom[3]
    "Pump head for three operating points";
protected
  parameter Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
    "Squared nominal flow rates";
  /* Linear system to determine the coefficients:
  head_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  head_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  head_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
  parameter Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2],
      head_nom) "Coefficients of quadratic head curve";
algorithm
  // Flow equation: head = c[1] + q_flow*c[2] + q_flow^2*c[3];
  head := c[1] + q_flow*c[2] + q_flow^2*c[3];
end quadraticFlow;
