within ORNL_AdvSMR.Icons.Water;
partial model Header

  annotation (Icon(graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{70,70},{-70,-70}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Text(extent={{-100,-84},{100,-110}}, textString="%name")}), Diagram(
        graphics));
end Header;
