within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model forcedFlowLoop "Demonstration of forced circulation with Standard Water"

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-92,80},{-80,92}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeLL(
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    m_flow_start=0.1,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    nNodes=2,
    length=1,
    height_ab=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    diameter=0.25,
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15,
    redeclare package Medium = ThermoPower3.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-40,-40})));

  Modelica.Fluid.Pipes.DynamicPipe pipeUL(
    m_flow_start=0.1,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    nNodes=2,
    length=9,
    height_ab=9,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=0.25,
    redeclare package Medium = ThermoPower3.Water.StandardWater,
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-40,20})));

  Modelica.Fluid.Pipes.DynamicPipe pipeUR(
    nParallel=1,
    m_flow_start=0.1,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    length=9,
    height_ab=-9,
    diameter=0.25,
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15,
    redeclare package Medium = ThermoPower3.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={40,20})));

  Modelica.Fluid.Pipes.DynamicPipe pipeLR(
    nParallel=1,
    m_flow_start=0.1,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    length=1,
    height_ab=-1,
    diameter=0.025,
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15,
    redeclare package Medium = ThermoPower3.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={40,-40})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=473.15) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=180,
        origin={67.5,-37.5})));

  Modelica.Fluid.Vessels.OpenTank tank(
    height=10,
    use_T_start=true,
    use_portsData=true,
    m_flow_small=0.001,
    nPorts=2,
    crossArea=100,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.25, height=0),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25,
        height=0),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.001, height=0)},
    p_ambient=6000000,
    T_ambient=373.15,
    T_start=473.15,
    redeclare package Medium = ThermoPower3.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,68},{10,88}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow
    annotation (Placement(transformation(extent={{-75,-45},{-60,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow1
    annotation (Placement(transformation(extent={{70,10},{55,25}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow2 annotation (Placement(transformation(extent={{-71.5,
            30},{-56.5,45}})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    use_N_in=true,
    use_T_start=true,
    N_nominal=1000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
    m_flow_start=0.5,
    redeclare package Medium = ThermoPower3.Water.StandardWater,
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15)
    annotation (Placement(transformation(extent={{10,-88},{-10,-68}})));

  Modelica.Blocks.Sources.Ramp pumpControl(
    offset=100,
    duration=50,
    startTime=600,
    height=-80)
    annotation (Placement(transformation(extent={{14,-60},{2,-48}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-95,-55},{-80,-40}})));
  Modelica.Blocks.Sources.Constant const1(k=-1e3)
    annotation (Placement(transformation(extent={{-95,40},{-80,55}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{90,40},{75,55}})));
equation
  connect(pipeUL.port_a, pipeLL.port_b) annotation (Line(
      points={{-40,5},{-40,-25}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpControl.y, pump.N_in) annotation (Line(
      points={{1.4,-54},{0,-54},{0,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-79.25,-47.5},{-78,-47.5},{-78,-37.5},{-75,-37.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_a, pipeLR.port_b) annotation (Line(
      points={{10,-78},{40,-78},{40,-55}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, pipeLL.port_a) annotation (Line(
      points={{-10,-78},{-40,-78},{-40,-55}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, pipeLL.heatPorts[1]) annotation (Line(
      points={{-60,-37.5},{-54,-37.5},{-54,-42.175},{-46.6,-42.175}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeUL.port_b, tank.ports[1]) annotation (Line(
      points={{-40,35},{-40,60},{-2,60},{-2,68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeUR.port_a, tank.ports[2]) annotation (Line(
      points={{40,35},{40,60},{0,60},{0,68},{2,68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeUR.port_b, pipeLR.port_a) annotation (Line(
      points={{40,5},{40,-25}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(prescribedHeatFlow1.port, pipeUR.heatPorts[2]) annotation (Line(
      points={{55,17.5},{50,17.5},{50,17.525},{46.6,17.525}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const2.y, prescribedHeatFlow1.Q_flow) annotation (Line(
      points={{74.25,47.5},{72,47.5},{72,17.5},{70,17.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow2.port, pipeUL.heatPorts[2]) annotation (Line(
      points={{-56.5,37.5},{-54,37.5},{-54,22.475},{-46.6,22.475}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const1.y, prescribedHeatFlow2.Q_flow) annotation (Line(
      points={{-79.25,47.5},{-76,47.5},{-76,37.5},{-71.5,37.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fixedTemperature.port, pipeLR.heatPorts[1]) annotation (Line(
      points={{60,-37.5},{53.3,-37.5},{53.3,-37.825},{46.6,-37.825}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(
      StopTime=10800,
      __Dymola_NumberOfIntervals=3600,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(textual=true, doublePrecision=true),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end forcedFlowLoop;
