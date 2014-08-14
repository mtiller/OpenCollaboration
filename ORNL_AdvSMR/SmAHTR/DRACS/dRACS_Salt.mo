within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_Salt

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=923.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,0})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=823.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,60})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=673.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,0})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=923.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={0,-60})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=773.15)
    annotation (Placement(transformation(extent={{-40,75},{-20,95}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
    alpha=0,
    Q_flow=10e6,
    T_ref=273.15)
    annotation (Placement(transformation(extent={{-35,-95},{-15,-75}})));
  Modelica.Fluid.Vessels.OpenTank tank(
    nPorts=2,
    crossArea=10,
    height=1,
    level_start=0.5,
    use_T_start=true,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    p_ambient=100000,
    T_ambient=673.15,
    T_start=773.15,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3)})
    annotation (Placement(transformation(extent={{45,65},{70,90}})));
equation
  connect(pipe2.port_b, pipe3.port_a) annotation (Line(
      points={{60,-20},{60,-60},{20,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe3.port_b, pipe.port_a) annotation (Line(
      points={{-20,-60},{-60,-60},{-60,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe.port_b, pipe1.port_a) annotation (Line(
      points={{-60,20},{-60,60},{-20,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fixedTemperature.port, pipe1.heatPorts[1]) annotation (Line(
      points={{-20,85},{-2.9,85},{-2.9,68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedTemperature.port, pipe1.heatPorts[2]) annotation (Line(
      points={{-20,85},{3.3,85},{3.3,68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, pipe3.heatPorts[1]) annotation (Line(
      points={{-15,-85},{2.9,-85},{2.9,-68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, pipe3.heatPorts[2]) annotation (Line(
      points={{-15,-85},{-3.3,-85},{-3.3,-68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe1.port_b, tank.ports[1]) annotation (Line(
      points={{20,60},{55,60},{55,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe2.port_a, tank.ports[2]) annotation (Line(
      points={{60,20},{60,42.5},{60,42.5},{60,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=100,
      NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput(equdistant=false));
end dRACS_Salt;
