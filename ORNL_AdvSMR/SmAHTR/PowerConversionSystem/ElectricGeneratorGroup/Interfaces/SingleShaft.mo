within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces;
partial model SingleShaft
  "Base Class for alternator group, configuration single-shaft (one generator)"
  import aSMR = ORNL_AdvSMR;
  parameter Modelica.SIunits.Frequency fn=50 "Nominal frequency of the grid";
  parameter Modelica.SIunits.Power Pn "Nominal power installed on the grid";
  parameter Real eta=1 "Conversion efficiency of the electric generator";
  parameter Modelica.SIunits.MomentOfInertia J_shaft=0
    "Total inertia of the system";
  parameter Real d_shaft=0 "Damping constant of the shaft";
  parameter Modelica.SIunits.AngularVelocity omega_nom=2*Modelica.Constants.pi
      *fn/2 "Nominal angular velocity of the shaft";
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (
     Placement(transformation(extent={{-220,-20},{-180,20}}, rotation=
           0)));
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
end SingleShaft;
