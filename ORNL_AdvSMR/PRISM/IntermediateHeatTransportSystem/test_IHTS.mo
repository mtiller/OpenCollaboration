within ORNL_AdvSMR.PRISM.IntermediateHeatTransportSystem;
model test_IHTS

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  IntermediateLoopBlock intermediateLoopBlock(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Components.CounterCurrentConvection counterFlowConvection(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-65,-10},{-45,10}})));
  Thermal.HeatSource1D heatSource1D1(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={70,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    offset=-2.25e6/2139,
    height=-212.5375e6/2139,
    duration=1000,
    startTime=1100)
    annotation (Placement(transformation(extent={{90,-5},{80,5}})));
  Components.CounterCurrentConvection counterFlowConvection1(nNodes=9)
    annotation (Placement(transformation(extent={{65,-10},{45,10}})));
  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-80,80},{-100,100}})));
  Thermal.HeatSource1D heatSource1D2(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,0})));
  Modelica.Blocks.Sources.Ramp ramp2(
    offset=0,
    startTime=1e3,
    height=212.5e6/2139,
    duration=1000)
    annotation (Placement(transformation(extent={{-90,-5},{-80,5}})));
equation
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{72,0},{79.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource1D2.power, ramp2.y) annotation (Line(
      points={{-72,0},{-79.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource1D2.wall, counterFlowConvection.shellSide) annotation (Line(
      points={{-68.5,-1.11022e-016},{-61.5,-1.11022e-016},{-61.5,0},{-55,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterFlowConvection.tubeSide, intermediateLoopBlock.intermediateIn)
    annotation (Line(
      points={{-50,0},{-40,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(intermediateLoopBlock.intermediateOut, counterFlowConvection1.tubeSide)
    annotation (Line(
      points={{40,0},{50,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(heatSource1D1.wall, counterFlowConvection1.shellSide) annotation (
      Line(
      points={{68.5,1.11022e-016},{62.5,1.11022e-016},{62.5,0},{55,0}},
      color={255,127,0},
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
end test_IHTS;
