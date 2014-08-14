within ORNL_AdvSMR.Icons.Gas;
partial model Valve

  annotation (Icon(graphics={Line(
          points={{0,40},{0,0}},
          color={0,0,0},
          thickness=0.5),Polygon(
          points={{-80,40},{-80,-40},{0,0},{-80,40}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid),Polygon(
          points={{80,40},{0,0},{80,-40},{80,40}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={159,159,223},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-20,60},{20,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}), Diagram(graphics));
end Valve;
