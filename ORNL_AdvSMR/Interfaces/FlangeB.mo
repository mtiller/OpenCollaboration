within ORNL_AdvSMR.Interfaces;
connector FlangeB "B-type flange connector for water/steam flows"
  extends Flange;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-150,110},{150,50}}, textString="%name")}));
end FlangeB;
