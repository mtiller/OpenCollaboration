within ORNL_AdvSMR.Functions.FanCharacteristics;
function linearFlow "Linear flow characteristic, fixed blades"
  extends baseFlow;
  input Modelica.SIunits.VolumeFlowRate q_nom[2]
    "Volume flow rate for two operating points (single fan)";
  input Modelica.SIunits.Height H_nom[2]
    "Specific energy for two operating points";
  /* Linear system to determine the coefficients:
  H_nom[1] = c[1] + q_nom[1]*c[2];
  H_nom[2] = c[1] + q_nom[2]*c[2];
  */
protected
  parameter Real c[2]=Modelica.Math.Matrices.solve([ones(2), q_nom], H_nom)
    "Coefficients of linear head curve";
algorithm
  // Flow equation: head = q*c[1] + c[2];
  H := c[1] + q_flow*c[2];
end linearFlow;
