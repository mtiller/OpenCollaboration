within ORNL_AdvSMR.Components;
model BaseReader_water
  "Base reader for the visualization of the state in the simulation (water)"
  import aSMR = ORNL_AdvSMR;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance "Medium model";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  ORNL_AdvSMR.Interfaces.FlangeA inlet(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}}, rotation=
            0)));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,-20},{80,20}}, rotation=0)));
equation
  inlet.m_flow + outlet.m_flow = 0 "Mass balance";
  inlet.p = outlet.p "No pressure drop";

  // Boundary conditions
  inlet.h_outflow = inStream(outlet.h_outflow);
  inStream(inlet.h_outflow) = outlet.h_outflow;
  annotation (
    Diagram(graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-80,0},{0,32},{80,0},{0,-32},{-80,0}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,20},{80,-20}},
          lineColor={255,255,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="w"),
        Text(extent={{-100,-40},{100,-60}}, textString="%name")}),
    Documentation(info="<HTML>
<p>This component can be inserted in a hydraulic circuit to measure the temperature of the fluid flowing through it.
<p>Flow reversal is supported.
</HTML>", revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end BaseReader_water;
