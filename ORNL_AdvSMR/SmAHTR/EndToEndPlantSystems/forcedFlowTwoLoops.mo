within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model forcedFlowTwoLoops
  "Demonstration of forced circulation with Standard Water"

  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_ph
    constrainedby ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium;

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-95,80},{-80,95}})));
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
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-55,-25})));

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
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15,
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-55,30})));

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
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-15,30})));

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
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-15,-25})));

  Modelica.Fluid.Vessels.ClosedVolume priUpperPlenum(
    use_T_start=true,
    use_portsData=true,
    m_flow_small=0.001,
    nPorts=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.25, height=0),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25,
        height=0),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.001, height=0)},
    V=100,
    redeclare package Medium = Medium,
    p_start=6000000,
    T_start=473.15)
    annotation (Placement(transformation(extent={{-45,65},{-25,85}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow annotation (Placement(transformation(extent={{-80,
            -31.5},{-70,-21.5}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow2 annotation (Placement(transformation(extent={{-80,
            26.5},{-70,36.5}})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    use_N_in=true,
    use_T_start=true,
    N_nominal=1000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
    m_flow_start=0.5,
    T_start=473.15,
    p_a_start=6000000,
    p_b_start=6000000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-25,-70},{-45,-50}})));

  Modelica.Blocks.Sources.Ramp pumpControl(
    startTime=600,
    height=0,
    duration=300,
    offset=100)
    annotation (Placement(transformation(extent={{-20,-50},{-30,-40}})));
  Modelica.Blocks.Sources.Constant const(k=1e4) annotation (Placement(
        transformation(extent={{-95,-31.5},{-85,-21.5}})));
  Modelica.Blocks.Sources.Constant const1(k=0) annotation (Placement(
        transformation(extent={{-95,26.5},{-85,36.5}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeLL1(
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
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={15,-30})));

  Modelica.Fluid.Pipes.DynamicPipe pipeUL1(
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
    p_a_start=6000000,
    p_b_start=6000000,
    T_start=473.15,
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={15,30})));

  Modelica.Fluid.Pipes.DynamicPipe pipeUR1(
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
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={55,30})));

  Modelica.Fluid.Pipes.DynamicPipe pipeLR1(
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
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={55,-30})));

  Modelica.Fluid.Vessels.ClosedVolume secUpperPlenum(
    use_T_start=true,
    use_portsData=true,
    m_flow_small=0.001,
    nPorts=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.25, height=0),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.25,
        height=0),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.001, height=0)},
    V=1000,
    p_start=6000000,
    T_start=473.15,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{25,65},{45,85}})));
  Modelica.Fluid.Machines.PrescribedPump pump1(
    use_N_in=true,
    use_T_start=true,
    N_nominal=1000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
    m_flow_start=0.5,
    T_start=473.15,
    p_a_start=6000000,
    p_b_start=6000000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{45,-70},{25,-50}})));
  Modelica.Blocks.Sources.Ramp pumpControl1(
    duration=600,
    offset=100,
    startTime=3000,
    height=0)
    annotation (Placement(transformation(extent={{50,-50},{40,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow1
    annotation (Placement(transformation(extent={{80,26.5},{70,36.5}})));
  Modelica.Blocks.Sources.Constant const2(k=-1e4)
    annotation (Placement(transformation(extent={{95,26.5},{85,36.5}})));

equation
  connect(pipeUL.port_a, pipeLL.port_b) annotation (Line(
      points={{-55,20},{-55,-15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumpControl.y, pump.N_in) annotation (Line(
      points={{-30.5,-45},{-35,-45},{-35,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_a, pipeLR.port_b) annotation (Line(
      points={{-25,-60},{-15,-60},{-15,-35}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pump.port_b, pipeLL.port_a) annotation (Line(
      points={{-45,-60},{-55,-60},{-55,-35}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipeUL.port_b, priUpperPlenum.ports[1]) annotation (Line(
      points={{-55,40},{-55,60},{-37,60},{-37,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipeUR.port_b, pipeLR.port_a) annotation (Line(
      points={{-15,20},{-15,-15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(prescribedHeatFlow2.port, pipeUL.heatPorts[2]) annotation (Line(
      points={{-70,31.5},{-65,31.5},{-65,31.65},{-59.4,31.65}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(const1.y, prescribedHeatFlow2.Q_flow) annotation (Line(
      points={{-84.5,31.5},{-80,31.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-84.5,-26.5},{-80,-26.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, pipeLL.heatPorts[1]) annotation (Line(
      points={{-70,-26.5},{-64.7,-26.5},{-64.7,-26.45},{-59.4,-26.45}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(pipeUR.port_a, priUpperPlenum.ports[2]) annotation (Line(
      points={{-15,40},{-15,60},{-33,60},{-33,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumpControl1.y, pump1.N_in) annotation (Line(
      points={{39.5,-45},{35,-45},{35,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump1.port_a, pipeLR1.port_b) annotation (Line(
      points={{45,-60},{55,-60},{55,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pump1.port_b, pipeLL1.port_a) annotation (Line(
      points={{25,-60},{15,-60},{15,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipeUL1.port_b, secUpperPlenum.ports[1]) annotation (Line(
      points={{15,40},{15,60},{33,60},{33,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipeUR1.port_a, secUpperPlenum.ports[2]) annotation (Line(
      points={{55,40},{55,60},{37,60},{37,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipeUR1.port_b, pipeLR1.port_a) annotation (Line(
      points={{55,20},{55,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipeUR.heatPorts[1], pipeLL1.heatPorts[1]) annotation (Line(
      points={{-10.6,31.45},{-1.5,31.45},{-1.5,-31.45},{10.6,-31.45}},
      color={127,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipeUR.heatPorts[2], pipeLL1.heatPorts[2]) annotation (Line(
      points={{-10.6,28.35},{-3,28.35},{-3,-28.35},{10.6,-28.35}},
      color={127,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipeLR.heatPorts[1], pipeUL1.heatPorts[1]) annotation (Line(
      points={{-10.6,-23.55},{1.5,-23.55},{1.5,28.55},{10.6,28.55}},
      color={127,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipeLR.heatPorts[2], pipeUL1.heatPorts[2]) annotation (Line(
      points={{-10.6,-26.65},{3,-26.65},{3,31.65},{10.6,31.65}},
      color={127,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prescribedHeatFlow1.port, pipeUR1.heatPorts[1]) annotation (
      Line(
      points={{70,31.5},{64.7,31.5},{64.7,31.45},{59.4,31.45}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(const2.y, prescribedHeatFlow1.Q_flow) annotation (Line(
      points={{84.5,31.5},{80,31.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipeUL1.port_a, pipeLL1.port_b) annotation (Line(
      points={{15,20},{15,-20}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(
      StopTime=6000,
      Interval=10,
      Tolerance=1e-009,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(textual=true, doublePrecision=true),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end forcedFlowTwoLoops;
