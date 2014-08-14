within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model Grid_2in "Ideal grid with finite droop and two inlet"
  parameter Modelica.SIunits.Frequency fn=50 "Nominal frequency";
  parameter Modelica.SIunits.Power Pn "Nominal power installed on the network";
  parameter Real droop(unit="pu") = 0.05 "Network droop";
  Modelica.SIunits.Power Wtot "Total power";
  ThermoPower3.Electrical.PowerConnection connection_A annotation (
      Placement(transformation(extent={{-100,26},{-72,54}}, rotation=0)));
  ThermoPower3.Electrical.PowerConnection connection_B annotation (
      Placement(transformation(extent={{-100,-54},{-72,-26}}, rotation=
            0)));
equation
  connection_A.f = fn + droop*fn*connection_A.W/Pn;
  connection_B.f = fn + droop*fn*connection_B.W/Pn;
  Wtot = connection_A.W + connection_B.W;

  annotation (Diagram(graphics), Icon(graphics={Line(points={{18,-16},{
          2,-38}}, color={0,0,0}),Line(points={{-72,-40},{-36,-20}},
          color={0,0,0}),Ellipse(
                  extent={{100,-68},{-40,68}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-40,0},{
          -6,0},{24,36},{54,50}}, color={0,0,0}),Line(points={{24,36},{
          36,-6}}, color={0,0,0}),Line(points={{-6,0},{16,-14},{40,-52}},
          color={0,0,0}),Line(points={{18,-14},{34,-6},{70,-22}}, color=
           {0,0,0}),Line(points={{68,18},{36,-4},{36,-4}}, color={0,0,0}),
          Ellipse(extent={{-8,2},{-2,-4}},
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
                  fillPattern=FillPattern.Solid),Line(points={{-72,40},
          {-36,20}}, color={0,0,0})}));
end Grid_2in;
