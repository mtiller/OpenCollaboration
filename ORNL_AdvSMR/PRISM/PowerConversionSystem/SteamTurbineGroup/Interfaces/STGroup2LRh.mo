within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model STGroup2LRh
  "Base class for Steam Turbine Group with two pressure levels and reheat"
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance;
  parameter Boolean SSInit=false "Steady-state initialization";

  ORNL_AdvSMR.Interfaces.FlangeA From_SH_HP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-180,180},{-140,
            220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB To_RH_IP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-120,180},{-80,
            220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA From_RH_IP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-60,180},{-20,
            220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA From_SH_LP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{60,180},{100,
            220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB WaterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{140,180},{
            180,220}}, rotation=0)));
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
          extent={{66,-162},{94,-170}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{80,-128},{80,-80}},
          color={0,0,255}),Ellipse(
          extent={{60,-126},{100,-166}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{90,-136},{70,-136},{90,-146},
          {70,-156},{90,-156},{90,-156}}, color={0,0,255}),Line(points={{80,-170},
          {80,-180},{160,-180},{160,196}}, color={0,0,255}),Ellipse(
          extent={{146,-132},{174,-160}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{160,-160},{160,-132},{
          172,-154},{160,-132},{148,-154}}, color={0,0,255}),Line(points={{-160,
          198},{-160,30}}, color={0,0,255}),Line(points={{-100,200},{-100,88}},
          color={0,0,255}),Line(points={{-40,200},{-40,30}}, color={0,0,255}),
          Rectangle(
          extent={{-200,14},{200,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(points={{20,58},{20,140},{80,140},{80,
          198}}, color={0,0,255}),Polygon(
          points={{-166,148},{-154,148},{-160,132},{-166,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-106,134},{-94,134},{-100,150},{-106,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-46,148},{-34,148},{-40,132},{-46,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{14,116},{26,116},{20,100},{14,116}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-160,30},{-160,-30},{-100,-90},{-100,90},{-160,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-40,30},{-40,-30},{80,-90},{80,90},{-40,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{154,134},{166,134},{160,150},{154,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{114,-174},{114,-186},{130,-180},{114,-174}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}));

end STGroup2LRh;
