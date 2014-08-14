within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model STGroup2L
  "Base class for Steam Turbine Group with two pressure levels"
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;
  parameter Boolean SSInit=false "Steady-state initialization";

  ORNL_AdvSMR.Interfaces.FlangeA From_SH_HP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-140,
            180},{-100,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA From_SH_LP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-20,
            180},{20,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB WaterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{
            120,180},{160,220}}, rotation=0)));
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
                    extent={{46,-162},{74,-170}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Line(points={{60,-126},
          {60,-78}}, color={0,0,255}),Ellipse(
                    extent={{40,-126},{80,-166}},
                    lineColor={0,0,255},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Line(points={{70,-136},
          {50,-136},{70,-146},{50,-156},{70,-156},{70,-156}}, color={
          0,0,255}),Line(points={{60,-170},{60,-180},{140,-180},{140,
          200}}, color={0,0,255}),Ellipse(
                    extent={{126,-132},{154,-160}},
                    lineColor={0,0,255},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Line(points={{140,
          -160},{140,-132},{152,-154},{140,-132},{128,-154}}, color={
          0,0,255}),Rectangle(
                    extent={{-200,14},{200,-14}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Line(points={{-120,30},{
          -120,200}}, color={0,0,255}),Line(points={{0,30},{0,200}},
          color={0,0,255}),Polygon(
                    points={{-126,148},{-114,148},{-120,132},{-126,
            148}},  lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-6,148},{6,148},{0,132},{-6,148}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-120,30},{-120,-30},{-60,-90},{-60,90},{
            -120,30}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{0,30},{0,-30},{60,-90},{60,90},{0,30}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{134,134},{146,134},{140,150},{134,134}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{94,-174},{94,-186},{110,-180},{94,-174}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255})}));

end STGroup2L;
