within ORNL_AdvSMR.Components;
model PrescribedSpeedPump "Prescribed speed pump"
  replaceable package WaterMedium =
      Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  parameter Modelica.SIunits.VolumeFlowRate q_nom[3]
    "Nominal volume flow rates";
  parameter Modelica.SIunits.Height head_nom[3] "Nominal heads";
  parameter Integer Np0=1 "Nominal number of pumps in parallel";
  parameter Modelica.SIunits.Volume V=0 "Pump Internal Volume";
  parameter Modelica.SIunits.Density rho0 "Nominal density";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n0
    "Nominal rpm";
  parameter Modelica.SIunits.Pressure nominalOutletPressure
    "Nominal outlet pressure";
  parameter Modelica.SIunits.Pressure nominalInletPressure
    "Nominal inlet pressure";
  parameter Modelica.SIunits.MassFlowRate nominalFlow "Nominal mass flow rate";
  parameter Modelica.SIunits.SpecificEnthalpy hstart=1e5
    "Fluid Specific Enthalpy Start Value"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));
  function flowCharacteristic =
      ORNL_AdvSMR.Functions.PumpCharacteristics.quadraticFlow (q_nom=q_nom,
        head_nom=head_nom);

  ORNL_AdvSMR.Interfaces.FlangeA inlet(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}, rotation
          =0)));
  ORNL_AdvSMR.Interfaces.FlangeA outlet(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
  ORNL_AdvSMR.Components.Pump feedWaterPump(
    redeclare package Medium = WaterMedium,
    redeclare function flowCharacteristic = flowCharacteristic,
    n0=n0,
    hstart=hstart,
    Np0=Np0,
    rho0=rho0,
    V=V,
    initOpt=if SSInit then ORNL_AdvSMR.Choices.Init.Options.steadyState else
        ORNL_AdvSMR.Choices.Init.Options.noInit,
    dp0=nominalOutletPressure - nominalInletPressure,
    wstart=nominalFlow,
    w0=nominalFlow) annotation (Placement(transformation(extent={{-40,-24},{0,
            16}}, rotation=0)));

  Modelica.Blocks.Interfaces.RealInput pumpSpeed_rpm annotation (Placement(
        transformation(extent={{-92,40},{-52,80}}, rotation=0),
        iconTransformation(extent={{-92,40},{-52,80}})));

equation
  connect(inlet, feedWaterPump.infl) annotation (Line(
      points={{-100,0},{-67,0},{-36,0}},
      thickness=0.5,
      color={0,0,255}));
  connect(pumpSpeed_rpm, feedWaterPump.in_n) annotation (Line(points={{-72,60},
          {-25.2,60},{-25.2,12}}, color={0,0,127}));
  connect(outlet, feedWaterPump.outfl) annotation (Line(
      points={{100,0},{10,0},{10,10},{-8,10}},
      thickness=0.5,
      color={0,0,255}));
  annotation (Icon(graphics={
        Text(
          extent={{-100,-118},{100,-144}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-40,40},{-40,-40},{50,0},{-40,40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}), Diagram(graphics));
end PrescribedSpeedPump;
