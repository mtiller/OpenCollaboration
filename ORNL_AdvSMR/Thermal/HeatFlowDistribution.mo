within ORNL_AdvSMR.Thermal;
model HeatFlowDistribution "Same heat flow through two different surfaces"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N(min=1) = 2 "Number of nodes";
  parameter Modelica.SIunits.Area A1=1 "Side 1 surface area"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.Area A2=1 "Side 2 surface area"
    annotation (Evaluate=true);

  DHT side1(N=N) "Area of side 1 surface" annotation (Placement(transformation(
          extent={{-40,20},{40,40}}, rotation=0)));
  DHT side2(N=N) "Area of side 2 surface" annotation (Placement(transformation(
          extent={{-40,-42},{40,-20}}, rotation=0)));
equation
  side1.T = side2.T "Same temperature";
  side1.phi*A1 + side2.phi*A2 = zeros(N) "Energy balance";
  annotation (
    Icon(graphics={Text(
          extent={{-88,50},{-40,20}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Forward,
          textString="s1"),Text(
          extent={{-100,-44},{100,-72}},
          lineColor={191,95,0},
          textString="%name"),Text(
          extent={{-92,-20},{-40,-50}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Forward,
          textString="s2")}),
    Documentation(info="<HTML>
<p>This model can be used to describe the heat flow through two different surfaces, having a different area; the total heat flow entering on the internal side is equal to the total heat flow going out of the external side.
</HTML>", revisions="<html>
<ul>
<li><i>8 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),
    Diagram(graphics));
end HeatFlowDistribution;
