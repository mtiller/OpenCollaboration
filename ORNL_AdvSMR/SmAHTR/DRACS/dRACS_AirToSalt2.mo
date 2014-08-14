within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_AirToSalt2

  Modelica.Fluid.Pipes.DynamicPipe airUp(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = Media.Fluids.Air,
    nNodes=2,
    diameter=5,
    length=25,
    height_ab=25,
    m_flow_start=25,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60.5,100})));

  Modelica.Fluid.Pipes.DynamicPipe airDown(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = Media.Fluids.Air,
    nNodes=2,
    diameter=5,
    length=25,
    height_ab=-25,
    p_a_start=100000,
    p_b_start=100000,
    m_flow_start=25) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60.5,100})));
  Modelica.Fluid.Pipes.DynamicPipe airHX(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = Media.Fluids.Air,
    nNodes=8,
    diameter=5,
    m_flow_start=25,
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
    redeclare package Medium = Media.Fluids.Air,
    p=100000,
    T=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60.5,149.5})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = Media.Fluids.Air,
    p=100000,
    T=298.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60.5,150})));
  Modelica.Fluid.Pipes.DynamicPipe saltUp(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    diameter=50e-3,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    nNodes=2,
    p_a_start=100000,
    p_b_start=100000,
    T_start=773.15) annotation (Placement(transformation(
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
    m_flow_start=1,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    nNodes=8,
    p_a_start=100000,
    p_b_start=100000,
    T_start=673.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={30,-30})));

  Modelica.Fluid.Pipes.DynamicPipe saltDown(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    diameter=50e-3,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    nNodes=2,
    p_a_start=100000,
    p_b_start=100000,
    T_start=673.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={90,-90})));
  Modelica.Fluid.Pipes.DynamicPipe plenum(
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
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    p_a_start=100000,
    p_b_start=100000,
    T_start=773.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={30,-150})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow fixedHeatFlow1(
     alpha=0, T_ref=273.15)
    annotation (Placement(transformation(extent={{-10,-190},{10,-170}})));
  Modelica.Fluid.Vessels.OpenTank tank(
    nPorts=2,
    crossArea=10,
    height=1,
    level_start=0.5,
    use_T_start=true,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=50e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=50e-3)},
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    p_ambient=100000,
    T_ambient=773.15,
    T_start=673.15)
    annotation (Placement(transformation(extent={{70,-20},{110,20}})));

  Modelica.Blocks.Sources.Step step(
    startTime=200,
    offset=1e5,
    height=9e5) annotation (Placement(transformation(extent={{-54,-190},{
            -34,-170}})));
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
      points={{-60.5,139.5},{-60.5,120}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary1.ports[1], airDown.port_a) annotation (Line(
      points={{60.5,140},{60.5,120}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(saltDown.port_b, plenum.port_a) annotation (Line(
      points={{90,-110},{90,-150},{50,-150}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
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
  connect(fixedHeatFlow1.port, plenum.heatPorts[1]) annotation (Line(
      points={{10,-180},{32.9,-180},{32.9,-158.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, plenum.heatPorts[2]) annotation (Line(
      points={{10,-180},{27,-180},{27,-158.8},{26.7,-158.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(step.y, fixedHeatFlow1.Q_flow) annotation (Line(
      points={{-33,-180},{-10,-180}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        grid={1,1})),
    experiment(
      StopTime=500,
      __Dymola_NumberOfIntervals=2000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput(equdistant=false));
end dRACS_AirToSalt2;
