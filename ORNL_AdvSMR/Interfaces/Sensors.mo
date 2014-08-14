within ORNL_AdvSMR.Interfaces;
expandable connector Sensors
  // Empty connector, defined by expansion

  annotation (Icon(graphics={Polygon(
          points={{-100,100},{100,100},{100,0},{100,-100},{-100,-100},{-100,100}},
          lineColor={255,170,213},
          fillColor={127,0,127},
          fillPattern=FillPattern.Solid),Text(
          extent={{-60,60},{60,-60}},
          lineColor={255,255,255},
          fillColor={127,0,127},
          fillPattern=FillPattern.Solid,
          textString="S")}));

end Sensors;
