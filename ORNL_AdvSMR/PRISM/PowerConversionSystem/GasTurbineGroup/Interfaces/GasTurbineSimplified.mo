within ORNL_AdvSMR.PRISM.PowerConversionSystem.GasTurbineGroup.Interfaces;
partial model GasTurbineSimplified
  replaceable package FlueGasMedium = ThermoPower3.Media.FlueGas constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  ThermoPower3.Gas.FlangeB flueGasOut(redeclare package Medium = FlueGasMedium)
    annotation (Placement(transformation(extent={{90,70},{110,90}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput GTLoad "GT unit load in p.u."
    annotation (Placement(transformation(extent={{-112,-12},{-88,12}}, rotation
          =0)));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-44,8},{38,-6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Ellipse(
          extent={{-20,80},{20,40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),Polygon(
          points={{-20,18},{-24,24},{-24,64},{-20,64},{-20,18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{20,18},{24,24},{24,64},{20,64},{20,18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{80,60},{76,56},{76,82},{100,82},{100,78},{80,78},{80,60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{-80,70},{-20,30},{-20,-30},{-80,-70},{-80,70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{80,70},{20,30},{20,-30},{80,-70},{80,-70},{80,70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255})}));
end GasTurbineSimplified;
