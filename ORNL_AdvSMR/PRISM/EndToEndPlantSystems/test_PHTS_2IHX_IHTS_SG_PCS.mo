within ORNL_AdvSMR.PRISM.EndToEndPlantSystems;
model test_PHTS_2IHX_IHTS_SG_PCS

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{125,45},{105,65}})));

  PrimaryHeatTransportSystem.PrimaryHeatTransportSystem
    primaryHeatTransportSystem(nNodes=10)
    annotation (Placement(transformation(extent={{-115,10},{-75,50}})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger(
    redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
    redeclare package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na,
    nNodes=nNodes,
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
    Twall_start=278.15)
    annotation (Placement(transformation(extent={{-60,23},{-20,63}})));

  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    period=1000,
    offset=0,
    width=100,
    startTime=2000,
    amplitude=1e-4,
    rising=100,
    falling=100) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-125,45})));
  PowerConversionSystem.RankineCycle.superCriticalWaterTurbineGenerator
    superCriticalWaterTurbineGenerator
    annotation (Placement(transformation(extent={{90,-70},{130,-30}})));
  PowerSystems.HeatExchangers.SteamGenerator steamGenerator
    annotation (Placement(transformation(extent={{50,-15.5},{90,24.5}})));
  IntermediateHeatTransportSystem.IntermediateLoopBlock_ihxFluidPorts_sgFluidPorts
    intermediateLoopBlock_ihxFluidPorts_sgFluidPorts
    annotation (Placement(transformation(extent={{0,-25},{40,15}})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger1(
    redeclare package shellMedium = ORNL_AdvSMR.Media.Fluids.Na,
    redeclare package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na,
    nNodes=nNodes,
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
    Twall_start=278.15)
    annotation (Placement(transformation(extent={{-60,-50},{-20,-10}})));
  Components.FlowJoin flowJoin
    annotation (Placement(transformation(extent={{-188.5,-16},{-168.5,4}})));
  Components.FlowSplit flowSplit
    annotation (Placement(transformation(extent={{-73,45},{-63,55}})));
  Components.FlowJoin flowJoin1
    annotation (Placement(transformation(extent={{-13,10},{-3,20}})));
  Components.FlowSplit flowSplit1
    annotation (Placement(transformation(extent={{-3,-5},{-13,5}})));
  Components.FlowJoin flowJoin2
    annotation (Placement(transformation(extent={{-63,30},{-73,40}})));
equation

  connect(rho_CR.y, primaryHeatTransportSystem.rho_CR) annotation (Line(
      points={{-119.5,45},{-114.048,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.sgOut,
    steamGenerator.shellInlet) annotation (Line(
      points={{39.5,-16.5},{45,-16.5},{45,13.5},{52,13.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamGenerator.shellOutlet,
    intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.sgIn) annotation (Line(
      points={{88,-3.5},{95,-3.5},{95,-21.5},{39.5,-21.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamGenerator.tubeOutlet, superCriticalWaterTurbineGenerator.steamIn)
    annotation (Line(
      points={{70,-17.5},{70,-25},{93,-25},{93,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamGenerator.tubeInlet, superCriticalWaterTurbineGenerator.waterOut)
    annotation (Line(
      points={{70,26.5},{70,35},{100,35},{100,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(primaryHeatTransportSystem.primaryOut, flowSplit.in1) annotation (
      Line(
      points={{-75.9524,45},{-73,45},{-73,50},{-71,50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flowSplit.out1, intermediateHeatExchanger.shellInlet) annotation (
      Line(
      points={{-65,52},{-62.5,52},{-62.5,53},{-60,53}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flowSplit.out2, intermediateHeatExchanger1.shellInlet) annotation (
      Line(
      points={{-65,48},{-62,48},{-62,-20},{-60,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flowJoin1.out, intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.ihxIn)
    annotation (Line(
      points={{-5,15},{-2.5,15},{-2.5,11.5},{0,11.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger.tubeOutlet, flowJoin1.in1) annotation (Line(
      points={{-40,21},{-40,17},{-11,17}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger1.tubeOutlet, flowJoin1.in2) annotation (
      Line(
      points={{-40,-52},{-40,-60},{-15,-60},{-15,13},{-11,13}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flowSplit1.in1, intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.ihxOut)
    annotation (Line(
      points={{-5,0},{-2.5,0},{-2.5,6.5},{0,6.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger1.tubeInlet, flowSplit1.out2) annotation (
      Line(
      points={{-40,-8},{-40,-2},{-11,-2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger.tubeInlet, flowSplit1.out1) annotation (
      Line(
      points={{-40,65},{-40,70},{-27.5,70},{-27.5,2},{-11,2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flowJoin2.out, primaryHeatTransportSystem.primaryReturn) annotation (
      Line(
      points={{-71,35},{-73.5,35},{-73.5,40},{-75.9524,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger.shellOutlet, flowJoin2.in1) annotation (
      Line(
      points={{-21,36},{-15,36},{-15,25},{-55,25},{-55,37},{-65,37}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger1.shellOutlet, flowJoin2.in2) annotation (
      Line(
      points={{-21,-37},{-10,-37},{-10,-48},{-53,-48},{-53,23},{-60,23},{-60,33},
          {-65,33}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-130,-70},{130,70}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-130,-70},{130,70}},
        grid={0.5,0.5})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end test_PHTS_2IHX_IHTS_SG_PCS;
