within ORNL_AdvSMR.Thermal;
model HeatSource1D "Distributed Heat Flow Source"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N=2 "Number of nodes";
  parameter Integer Nt=1 "Number of tubes";
  parameter Modelica.SIunits.Length L "Source length";
  parameter Modelica.SIunits.Length omega "Source perimeter (single tube)";
  replaceable DHT wall(N=N) annotation (Placement(transformation(extent={{-40,-40},
            {40,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput power annotation (Placement(
        transformation(
        origin={0,40},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  for i in 1:N loop
    wall.phi[i] = -power/(omega*L*Nt);
  end for;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-100,-44},{100,-68}},
          lineColor={191,95,0},
          textString="%name")}),
    Documentation(info="<HTML>
<p>Model of an ideal tubular heat flow source, with uniform heat flux. The actual heating power is provided by the <tt>power</tt> signal connector.
</HTML>", revisions="<html>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"));
end HeatSource1D;
