within ORNL_AdvSMR.Sensors;
model SensP "Pressure sensor for water/steam flows"
  extends ThermoPower3.Icons.Water.SensP;
  replaceable package Medium = ThermoPower3.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  Modelica.Blocks.Interfaces.RealOutput p annotation (Placement(transformation(
          extent={{60,40},{100,80}}, rotation=0)));
  ThermoPower3.Water.FlangeA flange(redeclare package Medium = Medium, m_flow(
        min=0)) annotation (Placement(transformation(extent={{-20,-60},{20,-20}},
          rotation=0)));
equation
  flange.m_flow = 0;
  p = flange.p;
  flange.h_outflow = 0;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-42,92},{44,36}},
          lineColor={0,0,0},
          textString="p")}),
    Documentation(info="<HTML>
<p>This component can be connected to any A-type or B-type connector to measure the pressure of the fluid flowing through it. In this case, it is possible to connect more than two <tt>Flange</tt> connectors together.
</HTML>", revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end SensP;
