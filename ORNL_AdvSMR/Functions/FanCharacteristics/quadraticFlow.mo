within ORNL_AdvSMR.Functions.FanCharacteristics;
function quadraticFlow "Quadratic flow characteristic, fixed blades"
  extends baseFlow;
  input Modelica.SIunits.VolumeFlowRate q_nom[3]
    "Volume flow rate for three operating points (single fan)";
  input Modelica.SIunits.Height H_nom[3]
    "Specific work for three operating points";
protected
  parameter Real q_nom2[3]={q_nom[1]^2,q_nom[2]^2,q_nom[3]^2}
    "Squared nominal flow rates";
  /* Linear system to determine the coefficients:
  H_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  H_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  H_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
  parameter Real c[3]=Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2],
      H_nom) "Coefficients of quadratic specific work characteristic";
algorithm
  // Flow equation: H = c[1] + q_flow*c[2] + q_flow^2*c[3];
  H := c[1] + q_flow*c[2] + q_flow^2*c[3];
end quadraticFlow;
