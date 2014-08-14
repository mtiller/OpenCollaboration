within ORNL_AdvSMR.PRISM.IntermediateHeatTransportSystem;
model test_IHTS_wPrimFlow_IHX

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-80,80},{-100,100}})));

  IntermediateLoopBlock_wFluidPorts intermediateLoopBlock(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-10,-30},{50,30}})));

  Thermal.HeatSource1D heatSource1D1(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={82,0})));

  Modelica.Blocks.Sources.Ramp ramp(
    startTime=0,
    height=0,
    offset=-282e6/2139,
    duration=1) annotation (Placement(transformation(extent={{100,-5},{90,5}})));

  Components.SinkP primaryOut(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na, h=28.8858e3 + 1.2753e3*(319 + 273))
    annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=0,
        origin={-22.5,-8})));

  Components.SourceW primaryIn(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1126.4,
    h=28.8858e3 + 1.2753e3*(468 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=0,
        origin={-89.5,9})));

  Components.CounterCurrentConvection counterCurrentConvection1(nNodes=nNodes)
    annotation (Placement(transformation(extent={{55,-10},{75,10}})));
  Modelica.Blocks.Sources.Ramp w(
    height=-1126.4/2,
    offset=1126.4,
    duration=500,
    startTime=50000) annotation (Placement(transformation(
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=180,
        origin={-107.5,22.5})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger(
    redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
    redeclare package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na,
    noAxialNodes=nNodes,
    flowPathLength=1,
    shellDiameter=1,
    shellFlowArea=1,
    shellPerimeter=1,
    shellHeatTrArea=1,
    shellWallThickness=1,
    tubeFlowArea=1,
    tubePerimeter=1,
    tubeHeatTrArea=1,
    tubeWallThickness=1,
    tubeWallRho=1,
    tubeWallCp=1,
    tubeWallK=1,
    tubeDiameter=1,
    Twall_start=274.15,
    dT=274.15)
    annotation (Placement(transformation(extent={{-77,-20},{-37,20}})));
  Modelica.Blocks.Sources.Ramp h(
    offset=28.8858e3 + 1.2753e3*(468 + 273),
    height=-1.2753e3*10,
    duration=0.1,
    startTime=500) annotation (Placement(transformation(
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=90,
        origin={-86.5,42.5})));
equation
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{84,0},{89.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intermediateLoopBlock.intermediateOut, counterCurrentConvection1.shellSide)
    annotation (Line(
      points={{51.5,0},{65,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrentConvection1.tubeSide, heatSource1D1.wall) annotation (
      Line(
      points={{70,0},{73.5,0},{73.5,1.11022e-016},{80.5,1.11022e-016}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeInlet, intermediateLoopBlock.ihxIn)
    annotation (Line(
      points={{-57,22},{-57,24.75},{-10,24.75}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeOutlet, intermediateLoopBlock.ihxOut)
    annotation (Line(
      points={{-57,-22},{-57,-25},{-15,-25},{-15,17.25},{-10,17.25}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(primaryIn.flange, intermediateHeatExchanger.shellInlet) annotation (
      Line(
      points={{-82,9},{-79.5,9},{-79.5,10},{-77,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.shellOutlet, primaryOut.flange) annotation
    (Line(
      points={{-38,-7},{-34,-7},{-34,-8},{-30,-8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(w.y, primaryIn.in_w0) annotation (Line(
      points={{-99.25,22.5},{-92.5,22.5},{-92.5,13.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(h.y, primaryIn.in_h) annotation (Line(
      points={{-86.5,34.25},{-86.5,13.5}},
      color={0,0,127},
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
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end test_IHTS_wPrimFlow_IHX;
