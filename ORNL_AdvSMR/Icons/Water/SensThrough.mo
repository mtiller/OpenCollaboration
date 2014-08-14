within ORNL_AdvSMR.Icons.Water;
model SensThrough

  annotation (Icon(graphics={
        Rectangle(
          extent={{-40,-20},{40,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Line(points={{0,20},{0,-20}}, color={0,0,0}),
        Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
        Line(points={{40,60},{60,60}}),
        Text(extent={{-100,-76},{100,-100}}, textString="%name")}));

end SensThrough;
