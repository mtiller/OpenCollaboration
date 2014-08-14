within ORNL_AdvSMR.Icons.Water;
partial model SourceW

  annotation (Icon(graphics={
        Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,-20},{66,0},{-12,20},{34,0},{-12,-20}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-100,-52},{100,-80}}, textString="%name")}));

end SourceW;
