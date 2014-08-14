within ORNL_AdvSMR.Icons.Gas;
partial model Mixer

  annotation (Icon(graphics={Ellipse(
          extent={{80,80},{-80,-80}},
          lineColor={128,128,128},
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid),Text(extent={{-100,-84},{100,-110}},
          textString="%name")}), Diagram(graphics));
end Mixer;
