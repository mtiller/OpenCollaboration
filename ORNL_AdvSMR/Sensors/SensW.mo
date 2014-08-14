within ORNL_AdvSMR.Sensors;
model SensW "Mass Flowrate sensor for water/steam"
  extends ThermoPower3.Icons.Water.SensThrough;
  replaceable package Medium = ThermoPower3.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";
  ThermoPower3.Water.FlangeA inlet(redeclare package Medium = Medium, m_flow(
        min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-80,-60},{-40,-20}}, rotation
          =0)));
  ThermoPower3.Water.FlangeB outlet(redeclare package Medium = Medium, m_flow(
        max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,-60},{80,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput w annotation (Placement(transformation(
          extent={{60,40},{100,80}}, rotation=0)));
equation
  inlet.m_flow + outlet.m_flow = 0 "Mass balance";

  // Boundary conditions
  inlet.p = outlet.p;
  inlet.h_outflow = inStream(outlet.h_outflow);
  inStream(inlet.h_outflow) = outlet.h_outflow;
  w = inlet.m_flow;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-42,92},{40,32}},
          lineColor={0,0,0},
          textString="w")}),
    Documentation(info="<HTML>
<p>This component can be inserted in a hydraulic circuit to measure the flowrate of the fluid flowing through it.
<p>Flow reversal is supported.
</HTML>", revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"));
end SensW;
