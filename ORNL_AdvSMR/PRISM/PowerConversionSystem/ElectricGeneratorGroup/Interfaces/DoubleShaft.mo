within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Interfaces;
partial model DoubleShaft
  "Base Class for alternator group, configuration double-shaft (two generator)"
  import aSMR = ORNL_AdvSMR;

  //grid
  parameter Modelica.SIunits.Frequency fn=50 "Nominal frequency of the grid";
  parameter Modelica.SIunits.Power Pn "Nominal power installed on the grid";

  //generators
  parameter Real eta_A=1 "Conversion efficiency of the electric generator"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Real eta_B=1 "Conversion efficiency of the electric generator"
    annotation (Dialog(group="Generator-Shaft B"));

  //other parameter
  parameter Modelica.SIunits.MomentOfInertia J_shaft_A=0
    "Total inertia of the steam turbogenerator"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Real d_shaft_A=0 "Damping constant of the shaft"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Modelica.SIunits.AngularVelocity omega_nom_A=2*Modelica.Constants.pi
      *fn/2 "Nominal angular velocity of the shaft"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Modelica.SIunits.MomentOfInertia J_shaft_B=0
    "Total inertia of the steam turbogenerator"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Real d_shaft_B=0 "Damping constant of the shaft"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Modelica.SIunits.AngularVelocity omega_nom_B=2*Modelica.Constants.pi
      *fn/2 "Nominal angular velocity of the shaft"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_B annotation (
      Placement(transformation(extent={{-220,-120},{-180,-80}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_A annotation (
      Placement(transformation(extent={{-222,80},{-182,120}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus annotation (Placement(
        transformation(extent={{220,-160},{180,-120}}, rotation=0)));
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
          extent={{-204,114},{-124,86}},
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
          points={{48,120},{98,120}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{48,100},{118,100}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{48,80},{138,80}},
          color={0,0,0},
          thickness=0.5),Ellipse(
          extent={{96,124},{104,116}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{116,104},{124,96}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{136,84},{144,76}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Line(
          points={{-36,120},{18,120},{42,134}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-32,100},{18,100},{42,114}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-46,80},{18,80},{42,94}},
          color={0,0,0},
          thickness=0.5),Ellipse(
          extent={{-142,160},{-22,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-122,140},{-42,60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),Rectangle(
          extent={{-202,-86},{-122,-114}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(
          points={{50,-80},{100,-80}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{50,-100},{120,-100}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{50,-120},{140,-120}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-34,-80},{20,-80},{44,-66}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-30,-100},{20,-100},{44,-86}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-44,-120},{20,-120},{44,-106}},
          color={0,0,0},
          thickness=0.5),Ellipse(
          extent={{-140,-40},{-20,-160}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-120,-60},{-40,-140}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),Ellipse(
          extent={{96,-76},{104,-84}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{116,-96},{124,-104}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{136,-116},{144,-124}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end DoubleShaft;
