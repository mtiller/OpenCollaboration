within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model balanceOfPlantSystemTwo "Test of STG with condenser control"
  import aSMR = ORNL_AdvSMR;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  ThermoPower3.Water.SourceP sourceLPT(
    h=3.109e6,
    redeclare package Medium = FluidMedium,
    p0=600000) annotation (Placement(transformation(
        origin={-35,40},
        extent={{-5,-5},{5,5}},
        rotation=270)));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.STG_3LRh_valve_cc
    sTG_3LRh(redeclare package FluidMedium = FluidMedium, steamTurbines(
        SSInit=true)) annotation (Placement(transformation(extent={{-90,-55},
            {-10,25}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveHP(k=1) annotation (Placement(
        transformation(extent={{100,-35},{90,-25}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveIP(k=1) annotation (Placement(
        transformation(extent={{100,-55},{90,-45}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveLP(k=1) annotation (Placement(
        transformation(extent={{100,-75},{90,-65}}, rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators annotation (
      Placement(transformation(
        origin={85,-90},
        extent={{-15,-5},{15,5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant n_pump(k=1425) annotation (Placement(
        transformation(extent={{70,-35},{80,-25}}, rotation=0)));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.GeneratorGroup
    singleShaft(
    eta=0.9,
    J_shaft=15000,
    d_shaft=25,
    Pmax=150e6,
    SSInit=true,
    delta_start=0.7) annotation (Placement(transformation(extent={{5,-45},
            {65,15}}, rotation=0)));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = ThermoPower3.Water.StandardWater,
    height_ab=0,
    m_flow_start=63.25,
    use_T_start=false,
    h_start=3.47e6,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    length=10,
    diameter=10,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    p_a_start=12800000,
    p_b_start=12800000,
    T_start=853.15)
    annotation (Placement(transformation(extent={{-55,70},{-75,90}})));

  inner ORNL_AdvSMR.System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyStateInitial,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.PowerPlants.HRSG.Components.PrescribedSpeedPump
    totalFeedPump(
    redeclare package WaterMedium = FluidMedium,
    rho0=1000,
    q_nom={0.0898,0,0.1},
    head_nom={72.74,130,0},
    nominalFlow=89.8,
    n0=1500,
    nominalOutletPressure=600000,
    nominalInletPressure=5398.2) annotation (Placement(transformation(
        origin={-37.5,80},
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant com_valveHP1(k=1500) annotation (
      Placement(transformation(extent={{0,79.5},{-10,89.5}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
      Q_flow=300e6)
    annotation (Placement(transformation(extent={{-85,85},{-70,100}})));
equation
  connect(com_valveHP.y, actuators.Opening_valveHP) annotation (Line(
        points={{89.5,-30},{85,-30},{85,-90}}, color={0,0,127}));
  connect(com_valveIP.y, actuators.Opening_valveIP) annotation (Line(
        points={{89.5,-50},{85,-50},{85,-90}}, color={0,0,127}));
  connect(com_valveLP.y, actuators.Opening_valveLP) annotation (Line(
        points={{89.5,-70},{85,-70},{85,-90}}, color={0,0,127}));
  connect(actuators, sTG_3LRh.ActuatorsBus) annotation (Line(points={{85,
          -90},{0,-90},{0,-43},{-10,-43}}, color={213,255,170}));
  connect(sTG_3LRh.From_SH_LP, sourceLPT.flange) annotation (Line(
      points={{-34,25},{-34,30},{-34,35},{-35,35}},
      thickness=0.5,
      color={0,0,255}));
  connect(n_pump.y, actuators.nPump_feedLP) annotation (Line(points={{
          80.5,-30},{85,-30},{85,-90}}, color={0,0,127}));
  connect(singleShaft.shaft, sTG_3LRh.Shaft_b) annotation (Line(
      points={{5,-15},{-10,-15}},
      color={0,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.To_RH_IP, sTG_3LRh.From_RH_IP) annotation (Line(
      points={{-70,25},{-70,35},{-58,35},{-58,25}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe1.port_b, sTG_3LRh.From_SH_HP) annotation (Line(
      points={{-75,80},{-82,80},{-82,25}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pipe1.port_a, totalFeedPump.outlet) annotation (Line(
      points={{-55,80},{-45,80}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(totalFeedPump.inlet, sTG_3LRh.WaterOut) annotation (Line(
      points={{-30,80},{-18,80},{-18,25}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(com_valveHP1.y, totalFeedPump.pumpSpeed_rpm) annotation (Line(
      points={{-10.5,84.5},{-32.1,84.5}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, pipe1.heatPorts[1]) annotation (Line(
      points={{-70,92.5},{-63.55,92.5},{-63.55,84.4}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, pipe1.heatPorts[2]) annotation (Line(
      points={{-70,92.5},{-66.5,92.5},{-66.5,84.4},{-66.65,84.4}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(StopTime=20000, NumberOfIntervals=10000),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end balanceOfPlantSystemTwo;
