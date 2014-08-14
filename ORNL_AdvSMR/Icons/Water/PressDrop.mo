within ORNL_AdvSMR.Icons.Water;
partial model PressDrop

  annotation (Icon(graphics={Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder),Polygon(
          points={{-80,40},{-42,40},{-20,12},{20,12},{40,40},{80,40},{80,-40},{
            40,-40},{20,-12},{-20,-12},{-40,-40},{-80,-40},{-80,40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255})}), Diagram(graphics));

end PressDrop;
