within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model PowerSensor "Measures power flow through the component"

  PowerConnection port_a annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}}, rotation=0)));
  PowerConnection port_b annotation (Placement(transformation(extent={{
            90,-12},{110,8}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput W "Power flowing from port_a to port_b"
                                          annotation (Placement(
        transformation(
        origin={0,-94},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  port_a.W + port_b.W = 0;
  port_a.f = port_b.f;
  W = port_a.W;
  annotation (Diagram(graphics), Icon(graphics={Ellipse(
                  extent={{-70,70},{70,-70}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,70},{0,
          40}}, color={0,0,0}),Line(points={{22.9,32.8},{40.2,57.3}},
          color={0,0,0}),Line(points={{-22.9,32.8},{-40.2,57.3}}, color=
           {0,0,0}),Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
          Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),Line(
          points={{0,0},{9.02,28.6}}, color={0,0,0}),Polygon(
                  points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-5,5},{5,-5}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-29,-11},{30,-70}},
                  lineColor={0,0,0},
                  textString="W"),Line(points={{-70,0},{-90,0}}, color=
          {0,0,0}),Line(points={{100,0},{70,0}}, color={0,0,0}),Text(
          extent={{-148,88},{152,128}}, textString="%name"),Line(points=
           {{0,-70},{0,-84}}, color={0,0,0})}));
end PowerSensor;
