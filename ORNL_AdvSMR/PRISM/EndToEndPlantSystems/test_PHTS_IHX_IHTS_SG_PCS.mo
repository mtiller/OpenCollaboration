within ORNL_AdvSMR.PRISM.EndToEndPlantSystems;
model test_PHTS_IHX_IHTS_SG_PCS

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{115,45},{95,65}})));

  PrimaryHeatTransportSystem.PrimaryHeatTransportSystem
    primaryHeatTransportSystem(nNodes=10)
    annotation (Placement(transformation(extent={{-105,15},{-65,55}})));
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
    annotation (Placement(transformation(extent={{-60,21},{-20,61}})));

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
        origin={-115,50})));
  PowerConversionSystem.RankineCycle.superCriticalWaterTurbineGenerator
    superCriticalWaterTurbineGenerator
    annotation (Placement(transformation(extent={{80,-70},{120,-30}})));
  PowerSystems.HeatExchangers.SteamGenerator steamGenerator
    annotation (Placement(transformation(extent={{25,-17},{65,23}})));
  IntermediateHeatTransportSystem.IntermediateLoopBlock_ihxFluidPorts_sgFluidPorts
    intermediateLoopBlock_ihxFluidPorts_sgFluidPorts
    annotation (Placement(transformation(extent={{-25,-25},{15,15}})));
equation
  connect(intermediateHeatExchanger.shellOutlet, primaryHeatTransportSystem.primaryReturn)
    annotation (Line(
      points={{-21,34},{-15,34},{-15,15},{-60,15},{-60,45},{-65.9524,45}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(primaryHeatTransportSystem.primaryOut, intermediateHeatExchanger.shellInlet)
    annotation (Line(
      points={{-65.9524,50},{-63,50},{-63,51},{-60,51}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(rho_CR.y, primaryHeatTransportSystem.rho_CR) annotation (Line(
      points={{-109.5,50},{-104.048,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeOutlet,
    intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.ihxIn) annotation (Line(
      points={{-40,19},{-40,11.5},{-25,11.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger.tubeInlet,
    intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.ihxOut) annotation (Line(
      points={{-40,63},{-40,70},{-30,70},{-30,6.5},{-25,6.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.sgOut,
    steamGenerator.shellInlet) annotation (Line(
      points={{14.5,-16.5},{20,-16.5},{20,12},{27,12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamGenerator.shellOutlet,
    intermediateLoopBlock_ihxFluidPorts_sgFluidPorts.sgIn) annotation (Line(
      points={{63,-5},{70,-5},{70,-21.5},{14.5,-21.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamGenerator.tubeOutlet, superCriticalWaterTurbineGenerator.steamIn)
    annotation (Line(
      points={{45,-19},{45,-26.5},{83,-26.5},{83,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamGenerator.tubeInlet, superCriticalWaterTurbineGenerator.waterOut)
    annotation (Line(
      points={{45,25},{45,33.5},{90,33.5},{90,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-120,-70},{120,70}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-120,-70},{120,70}},
        grid={0.5,0.5})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end test_PHTS_IHX_IHTS_SG_PCS;
