within ORNL_AdvSMR.PRISM.IntermediateHeatTransportSystem;
model test_IHTS_wPrimFlow

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-80,80},{-100,100}})));

  IntermediateLoopBlock intermediateLoopBlock(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));

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
    duration=1)
    annotation (Placement(transformation(extent={{100.5,-5},{90.5,5}})));

  Components.PipeFlow ihxShell(
    Cfnom=0.005,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    nNodes=nNodes,
    L=5.04,
    H=-5.04,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    Nt=2139*2,
    A=1.9799e-4,
    omega=2.4936e-2,
    Dhyd=3.1758e-2,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    rhonom=900,
    hstartin=28.8858e3 + 1.2753e3*(468 + 273),
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    hstartout=28.8858e3 + 1.2753e3*(468 + 273),
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={-90,0})));

  Components.SinkP sinkP(redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(319 + 273)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,-60})));

  Components.SourceW sourceW(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1126.4,
    h=28.8858e3 + 1.2753e3*(468 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,60})));

  Components.CounterCurrentConvection counterCurrentConvection(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Components.CounterCurrentConvection counterCurrentConvection1(nNodes=nNodes)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-1126.4/2,
    offset=1126.4,
    startTime=5000,
    duration=500)
    annotation (Placement(transformation(extent={{-55,56.5},{-70,71.5}})));
equation
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{84,0},{90,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW.flange, ihxShell.infl) annotation (Line(
      points={{-90,50},{-90,15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinkP.flange, ihxShell.outfl) annotation (Line(
      points={{-90,-50},{-90,-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ihxShell.wall, counterCurrentConvection.shellSide) annotation (Line(
      points={{-82.5,0.075},{-71.25,0.075},{-71.25,0},{-60,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrentConvection.tubeSide, intermediateLoopBlock.intermediateIn)
    annotation (Line(
      points={{-55,0},{-40,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(intermediateLoopBlock.intermediateOut, counterCurrentConvection1.shellSide)
    annotation (Line(
      points={{40,0},{60,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrentConvection1.tubeSide, heatSource1D1.wall) annotation (
      Line(
      points={{65,0},{73.5,0},{73.5,1.11022e-016},{80.5,1.11022e-016}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(ramp1.y, sourceW.in_w0) annotation (Line(
      points={{-70.75,64},{-84,64}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end test_IHTS_wPrimFlow;
