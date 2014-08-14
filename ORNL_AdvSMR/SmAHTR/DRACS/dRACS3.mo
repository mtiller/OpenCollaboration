within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS3

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    diameter=50e-3,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=10,
    height_ab=-10,
    T_start=473.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=10000000,
    p_b_start=10000000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,0})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    diameter=50e-3,
    height_ab=0,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    T_start=293.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=10000000,
    p_b_start=10000000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,60})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    diameter=50e-3,
    length=10,
    height_ab=-10,
    T_start=293.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=10000000,
    p_b_start=10000000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,0})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    diameter=50e-3,
    height_ab=0,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    T_start=473.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=10000000,
    p_b_start=10000000,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={0,-60})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
    alpha=100,
    Q_flow=300e3,
    T_ref=573.15)
    annotation (Placement(transformation(extent={{-35,-100},{-15,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(
    alpha=100,
    Q_flow=-300e3,
    T_ref(displayUnit="degC") = 293.15) annotation (Placement(
        transformation(extent={{-40.5,80},{-20.5,100}})));
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
  connect(fixedHeatFlow.port, pipe3.heatPorts[1]) annotation (Line(
      points={{-15,-90},{2.9,-90},{2.9,-68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, pipe3.heatPorts[2]) annotation (Line(
      points={{-15,-90},{-3.3,-90},{-3.3,-68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe1.port_b, pipe2.port_a) annotation (Line(
      points={{20,60},{60,60},{60,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fixedHeatFlow1.port, pipe1.heatPorts[1]) annotation (Line(
      points={{-20.5,90},{-2.9,90},{-2.9,68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, pipe1.heatPorts[2]) annotation (Line(
      points={{-20.5,90},{3.3,90},{3.3,68.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=5e-007),
    __Dymola_experimentSetupOutput(equdistant=false));
end dRACS3;
