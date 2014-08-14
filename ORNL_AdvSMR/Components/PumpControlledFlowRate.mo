within ORNL_AdvSMR.Components;
model PumpControlledFlowRate "Pump with flow rate control"

  replaceable package FluidMedium = ORNL_AdvSMR.Media.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;

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

  //PID for flow rate control
  parameter Real Kp=4 "Proportional gain (normalised units)"
    annotation (Dialog(tab="PID"));
  parameter Modelica.SIunits.Time Ti=200 "Integral time"
    annotation (Dialog(tab="PID"));
  parameter Modelica.SIunits.Time Td=0 "Derivative time"
    annotation (Dialog(tab="PID"));
  parameter Real PVmin=-1 "Minimum value of process variable for scaling"
    annotation (Dialog(tab="PID"));
  parameter Real PVmax=1 "Maximum value of process variable for scaling"
    annotation (Dialog(tab="PID"));
  parameter Real CSmin=500 "Minimum value of control signal for scaling"
    annotation (Dialog(tab="PID"));
  parameter Real CSmax=2500 "Maximum value of control signal for scaling"
    annotation (Dialog(tab="PID"));
  parameter Real PVstart=0.5 "Start value of PV (scaled)"
    annotation (Dialog(tab="PID"));
  parameter Real CSstart=0.5 "Start value of CS (scaled)"
    annotation (Dialog(tab="PID"));
  parameter Modelica.SIunits.Time T_filter=1 "Time Constant of the filter"
    annotation (Dialog(tab="PID"));

public
  ThermoPower3.PowerPlants.HRSG.Components.PrescribedSpeedPump pump(
    redeclare package WaterMedium = FluidMedium,
    q_nom=q_nom,
    head_nom=head_nom,
    n0=n0,
    hstart=hstart,
    Np0=Np0,
    V=V,
    rho0=rho0,
    nominalOutletPressure=nominalOutletPressure,
    nominalInletPressure=nominalInletPressure,
    nominalFlow=nominalFlow,
    SSInit=SSInit) annotation (Placement(transformation(
        origin={-24,0},
        extent={{16,16},{-16,-16}},
        rotation=180)));
  ThermoPower3.Water.SensW feed_w(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(
        origin={30,4},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ORNL_AdvSMR.Interfaces.FlangeA inlet(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}, rotation
          =0)));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput setpoint_FlowRate annotation (Placement(
        transformation(extent={{-120,54},{-88,86}}, rotation=0)));
  ThermoPower3.PowerPlants.Control.PID pID(
    Kp=Kp,
    Ti=Ti,
    Td=Td,
    PVmin=PVmin,
    PVmax=PVmax,
    CSmin=CSmin,
    CSmax=CSmax,
    PVstart=PVstart,
    CSstart=CSstart,
    steadyStateInit=SSInit) annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=T_filter,
    y_start=n0,
    initType=if SSInit then Modelica.Blocks.Types.Init.SteadyState else
        Modelica.Blocks.Types.Init.NoInit) annotation (Placement(transformation(
          extent={{-26,40},{-46,60}}, rotation=0)));

equation
  connect(pID.PV, feed_w.w) annotation (Line(points={{10,46},{60,46},{60,10},{
          38,10}}, color={0,0,127}));
  connect(pID.SP, setpoint_FlowRate) annotation (Line(points={{10,54},{20,54},{
          20,70},{-104,70}}, color={0,0,127}));
  connect(firstOrder.u, pID.CS)
    annotation (Line(points={{-24,50},{-10,50}}, color={0,0,127}));
  connect(firstOrder.y, pump.pumpSpeed_rpm) annotation (Line(points={{-47,50},{
          -60,50},{-60,9.6},{-35.52,9.6}}, color={0,0,127}));
  connect(outlet, feed_w.outlet) annotation (Line(
      points={{100,0},{68,0},{68,-8.88178e-016},{36,-8.88178e-016}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(feed_w.inlet, pump.outlet) annotation (Line(
      points={{24,8.88178e-016},{8,8.88178e-016},{8,-1.95943e-015},{-8,-1.95943e-015}},

      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));

  connect(pump.inlet, inlet) annotation (Line(
      points={{-40,1.95943e-015},{-66,1.95943e-015},{-66,0},{-100,0}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-118},{100,-144}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-62,60},{58,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-32,32},{-32,-28},{46,0},{-32,32}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-88,90},{-48,50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,88},{-50,52}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Line(points={{-48,70},{-2,70},{-2,60}}, color={0,0,127}),
        Line(
          points={{-62,0},{-80,0}},
          color={0,0,255},
          thickness=0.5),
        Line(points={{-70,0},{-70,50}}, color={0,0,255}),
        Polygon(
          points={{-70,46},{-72,40},{-68,40},{-70,46}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,72},{-30,68},{-24,70},{-30,72}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}), Diagram(graphics));
end PumpControlledFlowRate;
