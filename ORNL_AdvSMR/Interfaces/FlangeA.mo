within ORNL_AdvSMR.Interfaces;
connector FlangeA "A-type flange connector for water/steam flows"
  extends Flange;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-100,100},{100,-100}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Diagram(graphics={Ellipse(
          extent={{-60,60},{60,-60}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),Text(
          extent={{-140,110},{140,50}},
          textString="%name",
          pattern=LinePattern.None,
          fontSize=0)}));
end FlangeA;
