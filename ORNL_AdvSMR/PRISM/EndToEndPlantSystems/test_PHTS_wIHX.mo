within ORNL_AdvSMR.PRISM.EndToEndPlantSystems;
model test_PHTS_wIHX

  // number of Nodes
  parameter Integer noAxialNodes=10 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-80,80},{-100,100}})));

  PrimaryHeatTransportSystem.PrimaryHeatTransportSystem
    primaryHeatTransportSystem(noAxialNodes=10)
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
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
    annotation (Placement(transformation(extent={{-35,-15},{5,25}})));
  IntermediateHeatTransportSystem.IntermediateLoopBlock_wFluidPorts
    intermediateHeatTransportSystem(nNodes=noAxialNodes)
    annotation (Placement(transformation(extent={{20,-55},{60,-15}})));

  Components.CounterCurrentConvection counterCurrentConvection1(nNodes=
        noAxialNodes)
    annotation (Placement(transformation(extent={{57.5,-45},{77.5,-25}})));
  Thermal.HeatSource1D heatSink(
    N=noAxialNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={79.5,-35})));

  Modelica.Blocks.Sources.Ramp ramp(
    startTime=0,
    height=0,
    duration=1,
    offset=-1.56e5)
    annotation (Placement(transformation(extent={{95,-40},{85,-30}})));

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
        origin={-90,15})));
equation
  connect(heatSink.power, ramp.y) annotation (Line(
      points={{81.5,-35},{84.5,-35}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intermediateHeatTransportSystem.intermediateOut,
    counterCurrentConvection1.shellSide) annotation (Line(
      points={{61,-35},{67.5,-35}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrentConvection1.tubeSide, heatSink.wall) annotation (Line(
      points={{72.5,-35},{78,-35}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeOutlet, intermediateHeatTransportSystem.ihxOut)
    annotation (Line(
      points={{-15,-17},{-15,-23.5},{20,-23.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger.tubeInlet, intermediateHeatTransportSystem.ihxIn)
    annotation (Line(
      points={{-15,27},{-15,35},{15,35},{15,-18.5},{20,-18.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intermediateHeatExchanger.shellOutlet, primaryHeatTransportSystem.primaryReturn)
    annotation (Line(
      points={{4,-2},{10,-2},{10,-35},{-35,-35},{-35,10},{-40.9524,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(primaryHeatTransportSystem.primaryOut, intermediateHeatExchanger.shellInlet)
    annotation (Line(
      points={{-40.9524,15},{-35,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(rho_CR.y, primaryHeatTransportSystem.rho_CR) annotation (Line(
      points={{-84.5,15},{-79.0476,15}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end test_PHTS_wIHX;
