within ORNL_AdvSMR.PRISM.EndToEndPlantSystems;
model test_PHTS_wIHX_wSG

  // number of Nodes
  parameter Integer noAxialNodes=10 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{140,60},{120,80}})));

  PrimaryHeatTransportSystem.PrimaryHeatTransportSystem
    primaryHeatTransportSystem(noAxialNodes=10)
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger(
    redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
    redeclare package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na,
    noAxialNodes=noAxialNodes,
    allowFlowReversal=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
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
    flowPathLength=1,
    tubeDiameter=1,
    Twall_start=278.15)
    annotation (Placement(transformation(extent={{-60,0},{-20,40}})));
  IntermediateHeatTransportSystem.IntermediateLoopBlock_w2FluidPorts
    intermediateHeatTransportSystem(nNodes=noAxialNodes)
    annotation (Placement(transformation(extent={{0,-40},{40,0}})));

  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    period=1000,
    offset=0,
    width=100,
    startTime=2000,
    rising=100,
    falling=100,
    amplitude=1e-3) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-132,35})));
  PowerSystems.HeatExchangers.SteamGenerator steamGenerator(
    redeclare package tubeMedium = ORNL_AdvSMR.Media.StandardWater,
    shellDiameter=1,
    shellFlowArea=1,
    shellPerimeter=1,
    shellWallThickness=1,
    tubeFlowArea=1,
    tubePerimeter=1,
    tubeHeatTrArea=1,
    tubeWallThickness=1,
    tubeWallRho=1,
    tubeWallCp=11,
    tubeWallK=1,
    flowPathLength=1,
    shellHeatTrArea=1)
    annotation (Placement(transformation(extent={{60,-60},{120,0}})));
  Components.SourceW tubeIn(
    w0=1152.9,
    h=28.8858e3 + 1.2753e3*(282 + 273),
    redeclare package Medium = ORNL_AdvSMR.Media.StandardWater,
    p0=10000000000) annotation (Placement(transformation(
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=270,
        origin={90,29.5})));
  Components.SinkP tubeOut(
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    redeclare package Medium = ORNL_AdvSMR.Media.StandardWater,
    p0=100000) annotation (Placement(transformation(
        extent={{-7.5,-7.75},{7.5,7.75}},
        rotation=270,
        origin={90.25,-90.5})));
equation
  connect(primaryHeatTransportSystem.primaryOut, intermediateHeatExchanger.shellInlet)
    annotation (Line(
      points={{-80.9524,35},{-66,35},{-66,30},{-60,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));

  connect(rho_CR.y, primaryHeatTransportSystem.rho_CR) annotation (Line(
      points={{-126.5,35},{-119.048,35}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeOutlet, intermediateHeatTransportSystem.fromIHX)
    annotation (Line(
      points={{-40,-2},{-40,-6},{0,-6}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(intermediateHeatTransportSystem.toIHX, intermediateHeatExchanger.tubeInlet)
    annotation (Line(
      points={{0,-14},{-7.5,-14},{-7.5,60.5},{-40,60.5},{-40,42}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(intermediateHeatExchanger.shellOutlet, primaryHeatTransportSystem.primaryReturn)
    annotation (Line(
      points={{-21,13},{-14,13},{-14,-20},{-74,-20},{-74,30},{-80.9524,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(tubeIn.flange, steamGenerator.tubeInlet) annotation (Line(
      points={{90,22},{90,3}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(tubeOut.flange, steamGenerator.tubeOutlet) annotation (Line(
      points={{90.25,-83},{90.25,-63},{90,-63}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(steamGenerator.shellInlet, intermediateHeatTransportSystem.toSG)
    annotation (Line(
      points={{63,-16.5},{49.5,-16.5},{49.5,-26},{40,-26}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(steamGenerator.shellOutlet, intermediateHeatTransportSystem.fromSG)
    annotation (Line(
      points={{117,-42},{140,-42},{140,-72},{50,-72},{50,-34},{40,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-160,-100},{160,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-160,-100},{160,100}},
        grid={2,2})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end test_PHTS_wIHX_wSG;
