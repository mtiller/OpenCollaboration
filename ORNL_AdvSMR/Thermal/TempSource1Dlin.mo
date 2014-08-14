within ORNL_AdvSMR.Thermal;
model TempSource1Dlin "Linearly Distributed Temperature Source"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N=2 "Number of nodes";
  replaceable DHT wall(N=N) annotation (Placement(transformation(extent={{-40,-40},
            {40,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput temperature_node1 annotation (Placement(
        transformation(
        origin={-40,30},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput temperature_nodeN annotation (Placement(
        transformation(
        origin={40,28},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  wall.T = linspace(
    temperature_node1,
    temperature_nodeN,
    N);
  annotation (
    extent=[20, 10; 60, 50],
    rotation=-90,
    Documentation(info="<HTML>
<p>Model of an ideal 1D temperature source with a linear distribution. The values of the temperature at the two ends of the source are provided by the <tt>temperature_node1</tt> and <tt>temperature_nodeN</tt> signal connectors.
</HTML>", revisions="<html>
<ul>
<li><i>10 Jan 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>
"),
    Diagram(graphics),
    Placement(transformation(
        origin={40,30},
        extent={{-20,-20},{20,20}},
        rotation=270)),
    Diagram,
    Icon(graphics={Text(
          extent={{-100,-46},{100,-72}},
          lineColor={191,95,0},
          textString="%name")}),
    Documentation(info="<HTML>
<p>Model of an ideal 1D temperature source with a linear distribution. The values of the temperature at the two ends of the source are provided by the <tt>temperature_node1</tt> and <tt>temperature_nodeN</tt> signal connectors.
<p><b>Revision history:</b></p>
<ul>
<li><i>10 Jan 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end TempSource1Dlin;
