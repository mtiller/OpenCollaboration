within ORNL_AdvSMR.Components;
model LowerPlenum_4o "Splits a flow in two"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.FlowSplit;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  constant Modelica.SIunits.MassFlowRate wzero=1e-9
    "Small flowrate to avoid singularity in computing the outlet enthalpy";
  parameter Boolean rev_in1=allowFlowReversal "Allow flow reversal at in1"
    annotation (Evaluate=true);
  parameter Boolean rev_out1=allowFlowReversal "Allow flow reversal at out1"
    annotation (Evaluate=true);
  parameter Boolean rev_out2=allowFlowReversal "Allow flow reversal at out2"
    annotation (Evaluate=true);
  parameter Boolean checkFlowDirection=false "Check flow direction"
    annotation (Dialog(enable=not rev_in1 or not rev_out1 or not rev_out2));
  ORNL_AdvSMR.Interfaces.FlangeA in1(redeclare package Medium = Medium, m_flow(
        min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}}, rotation=
            0)));
  ORNL_AdvSMR.Interfaces.FlangeB out1(redeclare package Medium = Medium, m_flow(
        max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,20},{80,60}}, rotation=0),
        iconTransformation(extent={{40,20},{80,60}})));
  ORNL_AdvSMR.Interfaces.FlangeB out2(redeclare package Medium = Medium, m_flow(
        max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,-60},{80,-20}}, rotation=0)));
equation
  in1.m_flow + out1.m_flow + out2.m_flow = 0 "Mass balance";
  out1.p = in1.p;
  out2.p = in1.p;
  // Energy balance
  out1.h_outflow = homotopy(if (in1.m_flow < 0 and rev_in1) then inStream(out2.h_outflow)
     else if (out2.m_flow < 0 or not rev_out2) then inStream(in1.h_outflow)
     else (inStream(in1.h_outflow)*(in1.m_flow + wzero) + inStream(out2.h_outflow)
    *(out2.m_flow + wzero))/(in1.m_flow + 2*wzero + out2.m_flow), inStream(in1.h_outflow));
  out2.h_outflow = homotopy(if (in1.m_flow < 0 and rev_in1) then inStream(out1.h_outflow)
     else if (out1.m_flow < 0 or not rev_out1) then inStream(in1.h_outflow)
     else (inStream(in1.h_outflow)*(in1.m_flow + wzero) + inStream(out1.h_outflow)
    *(out1.m_flow + wzero))/(in1.m_flow + 2*wzero + out1.m_flow), inStream(in1.h_outflow));
  in1.h_outflow = homotopy(if (out1.m_flow < 0 or not rev_out1) then inStream(
    out2.h_outflow) else if (out2.m_flow < 0 or not rev_out2) then inStream(
    out1.h_outflow) else (inStream(out1.h_outflow)*(out1.m_flow + wzero) +
    inStream(out2.h_outflow)*(out2.m_flow + wzero))/(out1.m_flow + 2*wzero +
    out2.m_flow), inStream(out1.h_outflow));
  //Check flow direction
  assert(not checkFlowDirection or ((rev_in1 or in1.m_flow >= 0) and (rev_out1
     or out1.m_flow <= 0) and (rev_out2 or out2.m_flow <= 0)),
    "Flow reversal not supported");
  annotation (
    Icon(graphics),
    Documentation(info="<HTML>
<p>This component allows to split a single flow in two ones. The model is based on mass and energy balance equations, without any mass or energy buildup, and without any pressure drop between the inlet and the outlets.
<p><b>Modelling options</b></p>
<p> If <tt>rev_in1</tt>, <tt>rev_out1</tt> or <tt>rev_out2</tt> is true, the respective flows reversal is allowed. If at least ona among these parameters is false, it is possible to set <tt>checkFlowDirection</tt>.</p>
<p>If <tt>checkFlowDirection</tt> is true, when the flow reversal happen where it is not allowed, the error message is showed.</p>
</HTML>", revisions="<html>
<ul>
<li><i>23 May 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       Allow flows reversal option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),
    Diagram(graphics));
end LowerPlenum_4o;
