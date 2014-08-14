within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model Breaker "Circuit breaker"

  PowerConnection connection1 annotation (Placement(transformation(
          extent={{-100,-14},{-72,14}}, rotation=0)));
  PowerConnection connection2 annotation (Placement(transformation(
          extent={{72,-14},{100,14}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput closed annotation (Placement(
        transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  connection1.W + connection2.W = 0;
  if closed then
    connection1.f = connection2.f;
  else
    connection1.W = 0;
  end if;
  annotation (
    Diagram(graphics),
    Icon(graphics={Line(points={{-72,0},{-40,0}}, color={0,0,0}),Line(
          points={{40,0},{72,0}}, color={0,0,0}),Line(
                  points={{-40,0},{30,36},{30,34}},
                  color={0,0,0},
                  thickness=0.5),Ellipse(
                  extent={{-42,4},{-34,-4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{36,4},{44,-4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,60},{0,
          20}}, color={255,85,255})}),
    Documentation(info="<html>
Ideal breaker model. Can only be used to connect a generator to a grid with finite droop. Otherwise, please consider the other models in this package.
</html>"));
end Breaker;
