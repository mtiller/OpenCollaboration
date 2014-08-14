within ORNL_AdvSMR.Thermal;
model ConvHTLumped "Lumped parameter convective heat transfer"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Modelica.SIunits.ThermalConductance G
    "Constant thermal conductance";
  HT side1 annotation (Placement(transformation(extent={{-40,20},{40,40}},
          rotation=0)));
  HT side2 annotation (Placement(transformation(extent={{-40,-20},{40,-42}},
          rotation=0)));
equation
  side1.Q_flow = G*(side1.T - side2.T) "Convective heat transfer";
  side1.Q_flow = -side2.Q_flow "Energy balance";
  annotation (Icon(graphics={Text(
          extent={{-98,-76},{102,-100}},
          lineColor={191,95,0},
          textString="%name")}), Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two lumped parameter objects, with a constant heat transfer coefficient.
</HTML>", revisions="<html>
<li><i>28 Dic 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end ConvHTLumped;
