within ORNL_AdvSMR.Icons.Water;
partial model SourceP

  annotation (Icon(graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,34},{28,-26}},
          lineColor={255,255,255},
          textString="P"),
        Text(extent={{-100,-78},{100,-106}}, textString="%name")}));
end SourceP;
