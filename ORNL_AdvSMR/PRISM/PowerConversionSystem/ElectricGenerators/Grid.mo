within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGenerators;
model Grid "Ideal grid with finite droop"
  parameter Modelica.SIunits.Frequency fn=50 "Nominal frequency";
  parameter Modelica.SIunits.Power Pn "Nominal power installed on the network";
  parameter Real droop=0.05 "Network droop";
  PowerConnection connection annotation (Placement(transformation(extent={{-100,
            -14},{-72,14}}, rotation=0)));
equation
  connection.f = fn + droop*fn*connection.W/Pn;
  annotation (Diagram(graphics), Icon(graphics={Line(points={{18,-16},{2,-38}},
          color={0,0,0}),Line(points={{-72,0},{-40,0}}, color={0,0,0}),Ellipse(
          extent={{100,-68},{-40,68}},
          lineColor={0,0,0},
          lineThickness=0.5),Line(points={{-40,0},{-6,0},{24,36},{54,50}},
          color={0,0,0}),Line(points={{24,36},{36,-6}}, color={0,0,0}),Line(
          points={{-6,0},{16,-14},{40,-52}}, color={0,0,0}),Line(points={{18,-14},
          {34,-6},{70,-22}}, color={0,0,0}),Line(points={{68,18},{36,-4},{36,-4}},
          color={0,0,0}),Ellipse(
          extent={{-8,2},{-2,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{20,38},{26,32}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{52,54},{58,48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{14,-12},{20,-18}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{66,22},{72,16}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{32,-2},{38,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{38,-50},{44,-56}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{66,-18},{72,-24}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{0,-34},{6,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end Grid;
