within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model STGroup3LRh
  "Base class for Steam Turbine Group with three pressure levels and reheat"
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
          extent={{86,-162},{114,-170}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{80,-126},{120,-166}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{110,-136},{90,-136},{110,
          -146},{90,-156},{110,-156},{110,-156}}, color={0,0,255}),Line(points=
          {{100,-168},{100,-186},{160,-186},{160,202}}, color={0,0,255}),Line(
          points={{140,-88},{140,-110},{100,-110},{100,-126}}, color={0,0,255}),
          Ellipse(
          extent={{146,-132},{174,-160}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{160,-160},{160,-132},{
          172,-154},{160,-132},{148,-154}}, color={0,0,255}),Rectangle(
          extent={{-200,14},{200,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(points={{-100,200},{-100,90}}, color={0,
          0,255}),Line(points={{-40,30},{-40,200}}, color={0,0,255}),Line(
          points={{80,30},{80,200}}, color={0,0,255}),Line(points={{20,90},{20,
          130},{80,130}}, color={0,0,255}),Ellipse(
          extent={{76,134},{84,126}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{-160,30},{-160,120},{-160,
          146},{-160,204}}, color={0,0,255}),Polygon(
          points={{-166,148},{-154,148},{-160,132},{-166,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-46,148},{-34,148},{-40,132},{-46,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-106,134},{-94,134},{-100,150},{-106,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{40,136},{40,124},{56,130},{40,136}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{74,166},{86,166},{80,150},{74,166}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{74,106},{86,106},{80,90},{74,106}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-160,30},{-160,-30},{-100,-90},{-100,90},{-160,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-40,30},{-40,-30},{20,-90},{20,90},{-40,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{80,30},{80,-30},{140,-90},{140,90},{80,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{154,134},{166,134},{160,150},{154,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{126,-180},{126,-192},{142,-186},{126,-180}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}));

end STGroup3LRh;
