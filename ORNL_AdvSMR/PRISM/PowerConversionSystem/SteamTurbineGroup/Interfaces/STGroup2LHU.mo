within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model STGroup2LHU
  "Base class for Steam Turbine Group with two pressure levels and coupling Heat Usage"
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance;
  parameter Boolean SSInit=false "Steady-state initialization";

  ORNL_AdvSMR.Interfaces.FlangeB WaterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{120,180},{
            160,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA WaterFromHU(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{120,-220},{
            160,-180}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB SteamForHU(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-80,-220},{-40,
            -180}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA HPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-140,180},{-100,220}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA LPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-20,180},{20,220}}, rotation=
            0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b annotation (
      Placement(transformation(extent={{180,-20},{220,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a annotation (
      Placement(transformation(extent={{-220,-20},{-180,20}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus annotation (Placement(
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
          extent={{34,-168},{62,-176}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{48,-134},{48,-70}},
          color={0,0,255}),Ellipse(
          extent={{28,-132},{68,-172}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{58,-142},{38,-142},{58,-152},
          {38,-162},{58,-162},{58,-162}}, color={0,0,255}),Ellipse(
          extent={{136,-136},{144,-144}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{140,-140},{140,-198}},
          color={0,0,255}),Line(points={{140,-140},{140,190}}, color={0,0,255}),
          Line(points={{48,-174},{48,-186},{110,-186},{110,-140},{140,-140}},
          color={0,0,255}),Ellipse(
          extent={{126,-92},{154,-120}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{140,-120},{140,-92},{152,
          -114},{140,-92},{128,-114}}, color={0,0,255}),Ellipse(
          extent={{-20,136},{-12,128}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{-60,-196},{-60,-110},{
          100,-110},{100,132},{0,132}}, color={0,0,255}),Line(points={{-60,92},
          {-60,132},{0,132}}, color={0,0,255}),Line(points={{0,132},{0,200}},
          color={0,0,255}),Rectangle(
          extent={{-200,16},{200,-12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(points={{-120,30},{-120,202}}, color={0,
          0,255}),Line(points={{-12,132},{-12,122},{-12,32}}, color={0,0,255}),
          Polygon(
          points={{-50,138},{-50,126},{-34,132},{-50,138}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-126,150},{-114,150},{-120,134},{-126,150}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-6,170},{6,170},{0,154},{-6,170}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-18,104},{-6,104},{-12,88},{-18,104}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{26,138},{26,126},{42,132},{26,138}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Ellipse(
          extent={{0,136},{8,128}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-16,136},{4,128}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-120,32},{-120,-28},{-60,-88},{-60,92},{-120,32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-12,32},{-12,-28},{48,-88},{48,92},{-12,32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-66,-134},{-54,-134},{-60,-150},{-66,-134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{134,134},{146,134},{140,150},{134,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{134,-170},{146,-170},{140,-154},{134,-170}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{80,-180},{80,-192},{96,-186},{80,-180}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}));

end STGroup2LHU;
