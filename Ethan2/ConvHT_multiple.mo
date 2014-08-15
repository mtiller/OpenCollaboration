within Ethan2;
model ConvHT_multiple
  "1D Convective heat transfer, for modeling multiple parallel components"
  extends ThermoPower3.Icons.HeatFlow;
  parameter Integer N=2 "Number of Nodes";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma
    "Constant heat transfer coefficient";
    parameter Integer Np = 1 "number of parallel components";

  ThermoPower3.Thermal.DHT side1(N=N) annotation (Placement(transformation(
          extent={{-40,20},{40,40}}, rotation=0)));
  ThermoPower3.Thermal.DHT side2(N=N) annotation (Placement(transformation(
          extent={{-40,-42},{40,-20}}, rotation=0)));
equation
  side1.phi = gamma*(side1.T - side2.T) "Convective heat transfer";
  side1.phi = -Np*side2.phi "Energy balance";
  annotation (Icon(graphics={Text(
            extent={{-100,-44},{100,-68}},
            lineColor={191,95,0},
            textString="%name"),
        Text(
          extent={{62,44},{82,20}},
          lineColor={0,0,0},
          textString="1"),
        Text(
          extent={{64,-22},{84,-46}},
          lineColor={0,0,0},
          textString="2")}),       Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two 1D objects, with a constant heat transfer coefficient.
<p>Node <tt>j</tt> on side 1 interacts with node <tt>j</tt> on side 2.
</HTML>",
        revisions="<html>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end ConvHT_multiple;
