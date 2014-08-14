within ORNL_AdvSMR.Functions.PumpCharacteristics;
function linearFlow "Linear flow characteristic"
  extends baseFlow;
  input Modelica.SIunits.VolumeFlowRate q_nom[2]
    "Volume flow rate for two operating points (single pump)";
  input Modelica.SIunits.Height head_nom[2]
    "Pump head for two operating points";
  /* Linear system to determine the coefficients:
  head_nom[1] = c[1] + q_nom[1]*c[2];
  head_nom[2] = c[1] + q_nom[2]*c[2];
  */
protected
  parameter Real c[2]=Modelica.Math.Matrices.solve([ones(2), q_nom], head_nom)
    "Coefficients of linear head curve";
algorithm
  // Flow equation: head = q*c[1] + c[2];
  head := c[1] + q_flow*c[2];
  annotation (smoothOrder=2);
end linearFlow;
