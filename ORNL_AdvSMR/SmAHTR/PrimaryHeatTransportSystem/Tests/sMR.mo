within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model sMR
  "This model represents the primary heat transport system of a single reactor module."

  Modelica.Fluid.Pipes.DynamicPipe zone1(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    nNodes=2,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    p_a_start=200000,
    p_b_start=100000,
    T_start=923.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  Modelica.Fluid.Pipes.DynamicPipe downcomer(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    nNodes=2,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    p_a_start=150000,
    p_b_start=100000,
    T_start=773.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,0})));

  Modelica.Fluid.Vessels.OpenTank tank(
    height=1,
    level_start=0.5,
    use_T_start=true,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    nPorts=2,
    crossArea=100,
    p_ambient=100000,
    T_ambient=773.15,
    T_start=923.15,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3)})
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Fluid.Pipes.DynamicPipe zone2(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    nNodes=2,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    p_a_start=200000,
    p_b_start=100000,
    T_start=923.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-55,0})));

  Modelica.Fluid.Vessels.ClosedVolume upperPlenum(
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    V=100,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3)},
    nPorts=3,
    use_T_start=true,
    T_start=923.15)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Fluid.Vessels.ClosedVolume lowerPlenum(
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    V=100,
    nPorts=3,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3)},
    T_start=773.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-70})));
  Modelica.Fluid.Machines.ControlledPump pump(
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    m_flow_nominal=10,
    use_T_start=true,
    m_flow_start=1,
    T_start=773.15,
    p_a_nominal=100000,
    p_b_nominal=200000)
    annotation (Placement(transformation(extent={{45,-65},{25,-45}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
      Q_flow=1e6)
    annotation (Placement(transformation(extent={{-80,-5},{-70,5}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(
      Q_flow=1e6)
    annotation (Placement(transformation(extent={{-25,-5},{-15,5}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(
      Q_flow=-1e6) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={85,0})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
equation
  connect(zone1.port_a, lowerPlenum.ports[1]) annotation (Line(
      points={{0,-10},{0,-60},{2.66667,-60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(zone2.port_b, upperPlenum.ports[1]) annotation (Line(
      points={{-55,10},{-55,55},{-2.66667,55},{-2.66667,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(zone1.port_b, upperPlenum.ports[2]) annotation (Line(
      points={{0,10},{0,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(tank.ports[1], upperPlenum.ports[3]) annotation (Line(
      points={{38,60},{38,55},{2.5,55},{2.5,60},{2.66667,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.port_a, tank.ports[2]) annotation (Line(
      points={{70,10},{70,55},{42,55},{42,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(lowerPlenum.ports[2], pump.port_b) annotation (Line(
      points={{9.99201e-016,-60},{2.5,-60},{2.5,-55},{25,-55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, zone2.heatPorts[1]) annotation (Line(
      points={{-70,0},{-64.7,0},{-64.7,-1.45},{-59.4,-1.45}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, zone1.heatPorts[1]) annotation (Line(
      points={{-15,0},{-9.7,0},{-9.7,-1.45},{-4.4,-1.45}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow2.port, downcomer.heatPorts[1]) annotation (Line(
      points={{80,0},{77.2,0},{77.2,1.45},{74.4,1.45}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(zone2.port_a, lowerPlenum.ports[3]) annotation (Line(
      points={{-55,-10},{-55,-55},{-2.66667,-55},{-2.66667,-60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.port_b, pump.port_a) annotation (Line(
      points={{70,-10},{70,-55},{45,-55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow2.port, downcomer.heatPorts[2]) annotation (Line(
      points={{80,0},{77.25,0},{77.25,-1.65},{74.4,-1.65}},
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
    experiment(__Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end sMR;
