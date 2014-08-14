within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_AirToSalt_works
  replaceable package saltMedium = ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_ph;

  Modelica.Fluid.Pipes.DynamicPipe airUp(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    m_flow_start=10,
    length=20,
    height_ab=20,
    nNodes=2,
    diameter=5,
    redeclare package Medium = ThermoPower3.Media.Air,
    p_a_start=100000,
    p_b_start=100000,
    T_start=748.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60.5,100})));

  Modelica.Fluid.Pipes.DynamicPipe airDown(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    m_flow_start=10,
    length=20,
    height_ab=-20,
    nNodes=2,
    diameter=5,
    redeclare package Medium = ThermoPower3.Media.Air,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60.5,100})));
  Modelica.Fluid.Pipes.DynamicPipe airHX(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    m_flow_start=10,
    nNodes=8,
    nParallel=960,
    length=3.81,
    diameter=4.22e-2 - 3.55e-3,
    redeclare package Medium = ThermoPower3.Media.Air,
    p_a_start=100000,
    p_b_start=100000,
    T_start=673.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-0.5,40})));

  inner Modelica.Fluid.System system annotation (Placement(transformation(
          extent={{-190,150},{-150,190}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = ThermoPower3.Media.Air,
    p=100000,
    T=748.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60.5,169.5})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    use_p_in=false,
    p=100000,
    T=298.15,
    redeclare package Medium = ThermoPower3.Media.Air) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60.5,170})));
  Modelica.Fluid.Pipes.DynamicPipe saltUp(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    diameter=50e-3,
    use_T_start=true,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    nNodes=2,
    p_a_start=100000,
    p_b_start=100000,
    T_start=953.15,
    m_flow_start=200,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-30,-90})));
  Modelica.Fluid.Pipes.DynamicPipe saltHX(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    diameter=50e-3,
    height_ab=0,
    use_T_start=true,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nNodes=8,
    m_flow_start=200,
    p_a_start=100000,
    p_b_start=100000,
    T_start=953.15,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={30,-30})));

  Modelica.Fluid.Pipes.DynamicPipe saltDown(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    diameter=50e-3,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nNodes=2,
    m_flow_start=200,
    p_a_start=100000,
    p_b_start=100000,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={90,-90})));
  Modelica.Fluid.Pipes.DynamicPipe plenum(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    nNodes=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nParallel=250,
    length=1,
    diameter=2.22e-2 - 2*0.89e-3,
    m_flow_start=200,
    p_a_start=100000,
    p_b_start=100000,
    T_start=953.15,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={30,-150})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(
    alpha=0,
    Q_flow=1e6,
    T_ref=273.15)
    annotation (Placement(transformation(extent={{-11,-190},{9,-170}})));
  Modelica.Fluid.Vessels.OpenTank tank(
    nPorts=2,
    crossArea=10,
    height=1,
    level_start=0.5,
    use_T_start=true,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=50e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=50e-3)},
    p_ambient=100000,
    T_ambient=803.15,
    T_start=803.15,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{70,-20},{110,20}})));

equation
  connect(airDown.port_b, airHX.port_a) annotation (Line(
      points={{60.5,80},{60.5,40},{19.5,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(airHX.port_b, airUp.port_a) annotation (Line(
      points={{-20.5,40},{-60.5,40},{-60.5,80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.ports[1], airUp.port_b) annotation (Line(
      points={{-60.5,159.5},{-60.5,120}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary1.ports[1], airDown.port_a) annotation (Line(
      points={{60.5,160},{60.5,120}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(saltDown.port_b, plenum.port_a) annotation (Line(
      points={{90,-110},{90,-150},{50,-150}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fixedHeatFlow1.port, plenum.heatPorts[1]) annotation (Line(
      points={{9,-180},{32.9,-180},{32.9,-158.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, plenum.heatPorts[2]) annotation (Line(
      points={{9,-180},{26.7,-180},{26.7,-158.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(saltHX.port_b, tank.ports[1]) annotation (Line(
      points={{50,-30},{86,-30},{86,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(saltDown.port_a, tank.ports[2]) annotation (Line(
      points={{90,-70},{90,-20},{94,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(saltUp.port_b, saltHX.port_a) annotation (Line(
      points={{-30,-70},{-30,-30.5},{10,-30.5},{10,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(plenum.port_b, saltUp.port_a) annotation (Line(
      points={{10,-150},{-30,-150},{-30,-110}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(airHX.heatPorts[1], saltHX.heatPorts[1]) annotation (Line(
      points={{4.725,31.2},{4.725,20},{24.775,20},{24.775,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[2], saltHX.heatPorts[2]) annotation (Line(
      points={{3.175,31.2},{3.175,17},{26.325,17},{26.325,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[3], saltHX.heatPorts[3]) annotation (Line(
      points={{1.625,31.2},{1.625,14},{27.875,14},{27.875,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[4], saltHX.heatPorts[4]) annotation (Line(
      points={{0.075,31.2},{0.075,11},{29.425,11},{29.425,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[5], saltHX.heatPorts[5]) annotation (Line(
      points={{-1.475,31.2},{-1.475,8},{30.975,8},{30.975,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[6], saltHX.heatPorts[6]) annotation (Line(
      points={{-3.025,31.2},{-3.025,5},{32.525,5},{32.525,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[7], saltHX.heatPorts[7]) annotation (Line(
      points={{-4.575,31.2},{-4.575,2},{34.075,2},{34.075,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airHX.heatPorts[8], saltHX.heatPorts[8]) annotation (Line(
      points={{-6.125,31.2},{-6.125,-2},{35.625,-2},{35.625,-21.2}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        grid={1,1}), graphics={Text(
                extent={{-60,20},{60,-20}},
                lineColor={0,85,255},
                textStyle={TextStyle.Bold},
                origin={-160,0},
                rotation=90,
                textString="DRACS")}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        grid={1,1})),
    experiment(StopTime=200, Tolerance=1e-006),
    __Dymola_experimentSetupOutput(equdistant=false));
end dRACS_AirToSalt_works;
