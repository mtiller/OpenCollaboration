within ORNL_AdvSMR.Components;
model PumpFilter "Pump with filter"

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
  parameter Modelica.SIunits.Time T_filter=1 "Time Constant of the filter"
    annotation (Dialog(group="Filter"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart=1e5
    "Fluid Specific Enthalpy Start Value"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));

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
        origin={-4,0},
        extent={{16,16},{-16,-16}},
        rotation=180)));
  ThermoPower3.Water.Flange inlet(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}, rotation
          =0)));
  ThermoPower3.Water.Flange outlet(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput setpoint_FlowRate annotation (Placement(
        transformation(extent={{-120,54},{-88,86}}, rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=T_filter,
    y_start=n0,
    initType=if SSInit then Modelica.Blocks.Types.Init.SteadyState else
        Modelica.Blocks.Types.Init.NoInit) annotation (Placement(transformation(
          extent={{-10,40},{-30,60}}, rotation=0)));
equation
  connect(firstOrder.y, pump.pumpSpeed_rpm) annotation (Line(points={{-31,50},{
          -60,50},{-60,9.6},{-15.52,9.6}}, color={0,0,127}));
  connect(firstOrder.u, setpoint_FlowRate) annotation (Line(points={{-8,50},{20,
          50},{20,70},{-104,70}}, color={0,0,127}));
  connect(pump.inlet, inlet) annotation (Line(
      points={{-20,1.95943e-015},{-59,1.95943e-015},{-59,0},{-100,0}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pump.outlet, outlet) annotation (Line(
      points={{12,-1.95943e-015},{58,-1.95943e-015},{58,0},{100,0}},
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
          textString="F"),
        Line(points={{-48,70},{-2,70},{-2,60}}, color={0,0,127}),
        Line(
          points={{-62,0},{-80,0}},
          color={0,0,255},
          thickness=0.5),
        Polygon(
          points={{-30,72},{-30,68},{-24,70},{-30,72}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end PumpFilter;
