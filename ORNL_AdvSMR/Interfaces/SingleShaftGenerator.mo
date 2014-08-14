within ORNL_AdvSMR.Interfaces;
partial model SingleShaftGenerator
  "Interface description for electrical generator with single-shaft configuration"

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
        transformation(extent={{-240,-40},{-160,40}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
        transformation(extent={{-40,-220},{40,-140}}), iconTransformation(
          extent={{-40,-220},{40,-140}})));

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-202,14},{-122,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(
          points={{140,160},{140,-160}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{120,160},{120,-160}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{100,160},{100,-160}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{50,20},{100,20}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{50,0},{120,0}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{50,-20},{140,-20}},
          color={0,0,0},
          thickness=0.5),Ellipse(
          extent={{96,24},{104,16}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{116,4},{124,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{136,-16},{144,-24}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Line(
          points={{-34,20},{20,20},{44,34}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-30,0},{20,0},{44,14}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-44,-20},{20,-20},{44,-6}},
          color={0,0,0},
          thickness=0.5),Ellipse(
          extent={{-140,60},{-20,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-120,40},{-40,-40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G")}));
end SingleShaftGenerator;
