within ORNL_AdvSMR.Thermal;
model TempSource1D "Distributed Temperature Source"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N=2 "Number of nodes";
  replaceable DHT wall(N=N) annotation (Placement(transformation(extent={{-40,-40},
            {40,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput temperature annotation (Placement(
        transformation(
        origin={0,40},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  for i in 1:N loop
    wall.T[i] = temperature;
  end for;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-100,-46},{100,-70}},
          lineColor={191,95,0},
          textString="%name")}),
    Documentation(info="<HTML>
<p>Model of an ideal 1D uniform temperature source. The actual temperature is provided by the <tt>temperature</tt> signal connector.
</HTML>", revisions="<html>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"));
end TempSource1D;
