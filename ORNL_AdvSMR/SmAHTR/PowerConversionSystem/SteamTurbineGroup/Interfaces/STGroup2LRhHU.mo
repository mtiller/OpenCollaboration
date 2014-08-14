within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model STGroup2LRhHU
  "Base class for Steam Turbine Group with two pressure levels and reheat, and with coupling Heat Usage"
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;
  parameter Boolean SSInit=false "Steady-state initialization";

  ORNL_AdvSMR.Interfaces.FlangeB SteamForHU(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-58,
            -220},{-18,-180}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA WaterFromHU(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{
            140,-220},{180,-180}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB WaterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{
            140,180},{180,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA HPT_In(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-180,
            180},{-140,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB HPT_Out(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-120,
            180},{-80,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA IPT_In(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-60,
            180},{-20,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA LPT_In(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{60,
            180},{100,220}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b
    annotation (Placement(transformation(extent={{180,-20},{220,20}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus
                                         annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus
                                             annotation (Placement(
        transformation(extent={{220,-160},{180,-120}}, rotation=0)));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
                    extent={{-200,200},{200,-200}},
                    lineColor={170,170,255},
                    fillColor={230,230,230},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{66,-168},{94,-176}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Line(points={{80,-134},
          {80,-74}}, color={0,0,255}),Ellipse(
                    extent={{60,-132},{100,-172}},
                    lineColor={0,0,255},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Line(points={{90,-142},
          {70,-142},{90,-152},{70,-162},{90,-162},{90,-162}}, color={
          0,0,255}),Ellipse(
                    extent={{156,-136},{164,-144}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Line(points={{160,
          -140},{160,-198}}, color={0,0,255}),Line(points={{160,-140},
          {160,194}}, color={0,0,255}),Line(points={{80,-176},{80,-186},
          {130,-186},{130,-140},{160,-140}}, color={0,0,255}),Ellipse(
                    extent={{146,-92},{174,-120}},
                    lineColor={0,0,255},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Line(points={{160,
          -120},{160,-92},{172,-114},{160,-92},{148,-114}}, color={0,
          0,255}),Ellipse(
                    extent={{76,136},{84,128}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Line(points={{-98,
          132},{134,132},{134,-110},{-40,-110},{-40,-198}}, color={0,
          0,255}),Line(points={{80,132},{80,192}}, color={0,0,255}),
          Line(points={{-160,198},{-160,30}}, color={0,0,255}),Line(
          points={{-100,200},{-100,88}}, color={0,0,255}),Line(points=
           {{-40,200},{-40,30}}, color={0,0,255}),Rectangle(
                    extent={{-200,14},{200,-14}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Ellipse(
                    extent={{-104,136},{-96,128}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{-74,138},{-74,126},{-58,132},{-74,138}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-166,128},{-154,128},{-160,112},{-166,
            128}},  lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{104,138},{104,126},{120,132},{104,138}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{74,170},{86,170},{80,154},{74,170}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-46,106},{-34,106},{-40,90},{-46,106}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-106,152},{-94,152},{-100,168},{-106,152}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-160,30},{-160,-30},{-100,-90},{-100,90},
            {-160,30}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{-40,30},{-40,-30},{80,-90},{80,90},{-40,
            30}},   lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{154,-170},{166,-170},{160,-154},{154,-170}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{100,-180},{100,-192},{116,-186},{100,-180}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-46,-134},{-34,-134},{-40,-150},{-46,-134}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{154,134},{166,134},{160,150},{154,134}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255})}));

end STGroup2LRhHU;
