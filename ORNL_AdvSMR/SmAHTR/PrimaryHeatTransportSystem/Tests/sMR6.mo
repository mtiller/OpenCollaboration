within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model sMR6
  "This model represents the primary heat transport system of a single reactor module."

  Modelica.Fluid.Pipes.DynamicPipe zone1(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    nNodes=10,
    p_a_start=200000,
    p_b_start=100000,
    T_start=823.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));

  Modelica.Fluid.Pipes.DynamicPipe downcomer(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    nNodes=10,
    p_a_start=150000,
    p_b_start=100000,
    T_start=773.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));

  Modelica.Fluid.Vessels.OpenTank upperPlenum(
    level_start=0.5,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3)},
    nPorts=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    height=4,
    crossArea=2,
    p_ambient=100000,
    T_ambient=873.15,
    T_start=823.15)
    annotation (Placement(transformation(extent={{20,45},{40,65}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(
      Q_flow=1e6)
    annotation (Placement(transformation(extent={{-65,-5},{-55,5}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(
      Q_flow=-1e6) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={60,0})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));

  Modelica.Fluid.Machines.PrescribedPump saltPump(
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
    allowFlowReversal=false,
    redeclare package Medium = AHTR.Media.Fluids.flibe_ph,
    use_N_in=false,
    m_flow_start=30,
    p_a_start=101325,
    p_b_start=101325,
    N_nominal=1000,
    V=0.5^3,
    T_start=773.15,
    show_NPSHa=true,
    N_const=100)
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  Modelica.Fluid.Pipes.DynamicPipe xOver(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    diameter=100e-3,
    length=1,
    height_ab=0,
    nNodes=1,
    p_a_start=200000,
    p_b_start=100000,
    T_start=823.15,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,40})));
  Modelica.Fluid.Vessels.ClosedVolume upperPlenum1(
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    use_T_start=true,
    V=100,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3)},
    nPorts=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p_start=200000,
    T_start=823.15) annotation (Placement(transformation(extent={{-40,
            44.5},{-20,64.5}})));
equation

  connect(downcomer.port_b, saltPump.port_a) annotation (Line(
      points={{40,-10},{40,-40},{10,-40}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(saltPump.port_b, zone1.port_a) annotation (Line(
      points={{-10,-40},{-40,-40},{-40,-10}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, zone1.heatPorts[2]) annotation (Line(
      points={{-55,0},{-49.7,0},{-49.7,-2.07},{-44.4,-2.07}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow2.port, downcomer.heatPorts[2]) annotation (Line(
      points={{55,0},{49.7,0},{49.7,2.07},{44.4,2.07}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(xOver.port_b, upperPlenum.ports[1]) annotation (Line(
      points={{10,40},{28,40},{28,45}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.port_a, upperPlenum.ports[2]) annotation (Line(
      points={{40,10},{40,40},{32,40},{32,45}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(zone1.port_b, upperPlenum1.ports[1]) annotation (Line(
      points={{-40,10},{-40,40},{-32,40},{-32,44.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(upperPlenum1.ports[2], xOver.port_a) annotation (Line(
      points={{-28,44.5},{-28,40},{-10,40}},
      color={0,127,255},
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
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end sMR6;
