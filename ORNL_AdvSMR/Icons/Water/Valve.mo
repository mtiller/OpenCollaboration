within ORNL_AdvSMR.Icons.Water;
partial model Valve

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={
        Line(
          points={{0,40},{0,0}},
          color={0,0,0},
          thickness=0.5),
        Polygon(
          points={{-80,40},{-80,-40},{0,0},{-80,40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255}),
        Polygon(
          points={{80,40},{0,0},{80,-40},{80,40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255}),
        Rectangle(extent={{-25,60},{0,40}}, lineColor={0,0,0}),
        Rectangle(extent={{-25,80},{25,60}}, lineColor={0,0,0}),
        Rectangle(extent={{0,60},{25,40}}, lineColor={0,0,0})}), Diagram(
        coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics));
end Valve;
