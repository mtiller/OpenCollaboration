within ORNL_AdvSMR.Thermal;
model ConvHT "1D Convective heat transfer"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N=2 "Number of Nodes";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma
    "Constant heat transfer coefficient";

  DHT side1(N=N) annotation (Placement(transformation(extent={{-40,20},{40,40}},
          rotation=0)));
  DHT side2(N=N) annotation (Placement(transformation(extent={{-40,-42},{40,-20}},
          rotation=0)));
equation
  side1.phi = gamma*(side1.T - side2.T) "Convective heat transfer";
  side1.phi = -side2.phi "Energy balance";
  annotation (Icon(graphics={Text(
          extent={{-100,-44},{100,-68}},
          lineColor={191,95,0},
          textString="%name")}), Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two 1D objects, with a constant heat transfer coefficient.
<p>Node <tt>j</tt> on side 1 interacts with node <tt>j</tt> on side 2.
</HTML>", revisions="<html>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end ConvHT;
