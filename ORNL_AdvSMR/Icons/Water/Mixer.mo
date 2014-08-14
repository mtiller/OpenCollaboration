within ORNL_AdvSMR.Icons.Water;
partial model Mixer

  annotation (Icon(graphics={Ellipse(
          extent={{80,80},{-80,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Text(extent={{-100,-84},{100,-110}}, textString=
              "%name")}), Diagram(graphics));
end Mixer;
