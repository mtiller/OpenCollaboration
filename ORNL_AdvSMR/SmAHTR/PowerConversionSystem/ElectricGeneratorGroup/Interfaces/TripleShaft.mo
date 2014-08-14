within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces;
partial model TripleShaft
  "Base Class for alternator group, configuration triple-shaft (three generator)"
  import aSMR = ORNL_AdvSMR;

  //grid
  parameter Modelica.SIunits.Frequency fn=50 "Nominal frequency of the grid";
  parameter Modelica.SIunits.Power Pn "Nominal power installed on the grid";

  //generators
  parameter Real eta_A=1 "Conversion efficiency of the electric generator"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Real eta_B=1 "Conversion efficiency of the electric generator"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Real eta_C=1 "Conversion efficiency of the electric generator"
    annotation (Dialog(group="Generator-Shaft C"));

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
  parameter Modelica.SIunits.MomentOfInertia J_shaft_C=0
    "Total inertia of the steam turbogenerator"
    annotation (Dialog(group="Generator-Shaft C"));
  parameter Real d_shaft_C=0 "Damping constant of the shaft"
    annotation (Dialog(group="Generator-Shaft C"));
  parameter Modelica.SIunits.AngularVelocity omega_nom_C=2*Modelica.Constants.pi
      *fn/2 "Nominal angular velocity of the shaft"
    annotation (Dialog(group="Generator-Shaft C"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_B
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_A
    annotation (Placement(transformation(extent={{-220,100},{-180,140}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_C
    annotation (Placement(transformation(extent={{-220,-140},{-180,-100}},
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
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
                    extent={{-200,200},{200,-200}},
                    lineColor={170,170,255},
                    fillColor={230,230,230},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{-200,134},{-120,106}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Line(
                    points={{140,180},{140,-180}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{120,180},{120,-180}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{100,180},{100,-180}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,140},{100,140}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,120},{120,120}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,100},{140,100}},
                    color={0,0,0},
                    thickness=0.5),Ellipse(
                    extent={{96,144},{104,136}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),Ellipse(
                    extent={{116,124},{124,116}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),Ellipse(
                    extent={{136,104},{144,96}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),Line(
                    points={{-34,140},{20,140},{44,154}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-30,120},{20,120},{44,134}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-44,100},{20,100},{44,114}},
                    color={0,0,0},
                    thickness=0.5),Ellipse(
                    extent={{-136,176},{-24,64}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Text(
                    extent={{-120,160},{-40,80}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid,
                    textString="G"),Rectangle(
                    extent={{-200,-106},{-120,-134}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Line(
                    points={{50,-100},{100,-100}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,-120},{120,-120}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,-140},{140,-140}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-34,-100},{20,-100},{44,-86}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-30,-120},{20,-120},{44,-106}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-44,-140},{20,-140},{44,-126}},
                    color={0,0,0},
                    thickness=0.5),Ellipse(
                    extent={{-136,-64},{-24,-176}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Text(
                    extent={{-120,-80},{-40,-160}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid,
                    textString="G"),Ellipse(
                    extent={{96,-96},{104,-104}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),Ellipse(
                    extent={{116,-116},{124,-124}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),Ellipse(
                    extent={{136,-136},{144,-144}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{-200,14},{-120,-14}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Line(
                    points={{50,20},{100,20}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,0},{120,0}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{50,-20},{140,-20}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-34,20},{20,20},{44,34}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-30,0},{20,0},{44,14}},
                    color={0,0,0},
                    thickness=0.5),Line(
                    points={{-44,-20},{20,-20},{44,-6}},
                    color={0,0,0},
                    thickness=0.5),Ellipse(
                    extent={{-136,56},{-24,-56}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Text(
                    extent={{-120,40},{-40,-40}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid,
                    textString="G"),Ellipse(
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
                    fillPattern=FillPattern.Solid)}));
end TripleShaft;
