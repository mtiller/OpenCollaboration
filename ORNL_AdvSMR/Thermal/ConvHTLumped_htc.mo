within ORNL_AdvSMR.Thermal;
model ConvHTLumped_htc
  "Lumped parameter convective heat transfer between a HT and a HThtc"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  HT otherside annotation (Placement(transformation(extent={{-40,-20},{40,-40}},
          rotation=0)));
  HThtc_in fluidside annotation (Placement(transformation(extent={{-40,20},{40,
            40}}, rotation=0)));
equation
  fluidside.Q_flow = fluidside.G*(fluidside.T - otherside.T)
    "Convective heat transfer";
  fluidside.Q_flow + otherside.Q_flow = 0 "Energy balance";
  annotation (
    Icon(graphics={Text(
          extent={{-100,-74},{100,-100}},
          lineColor={191,95,0},
          textString="%name")}),
    Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two lumped parameter objects. The heat transfer coefficient is supplied by the <tt>fluidside</tt> connector.
</HTML>", revisions="<html>
<li><i>28 Dic 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Diagram(graphics));
end ConvHTLumped_htc;
