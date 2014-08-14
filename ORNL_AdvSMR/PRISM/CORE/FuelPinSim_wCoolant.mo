within ORNL_AdvSMR.PRISM.CORE;
model FuelPinSim_wCoolant

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=8 "Number of axial nodes";
  parameter Power Q_total=59.5e3 "Total thermal power into the channel";

  FuelPin fuelPin(
    noAxialNodes=nNodes,
    W_Pu=0.26,
    varConductivity=false)
    annotation (Placement(transformation(extent={{-40,-75.5},{-24.5,75}})));
  Modelica.Blocks.Sources.Step[nNodes] step(
    each startTime=100,
    each height=0,
    each offset=1e3)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Thermal.ConvHT_htc convec(N=nNodes) annotation (Placement(transformation(
        extent={{-75.25,-10},{75.25,10}},
        rotation=270,
        origin={1.06581e-014,-0.25})));
  Components.PipeFlow channel(
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=nNodes,
    L=5.04,
    H=5.04,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    hstartin=28.8858e3 + 1.2753e3*(319 + 273),
    hstartout=28.8858e3 + 1.2753e3*(468 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    A=1.2468e-5,
    Dhyd=4.3e-3,
    DynamicMomentum=true,
    omega=0.0116,
    Nt=1,
    wnom=0.0123,
    dpnom(displayUnit="kPa") = 586000,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    pstart=100000) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={55,-3.55271e-015})));
  Components.SourceW tubeIn(
    p0(displayUnit="bar") = 100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=0.0123,
    h=28.8858e3 + 1.2753e3*(319 + 273)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={55,-76})));
  Components.SinkP tubeOut(
    h=28.8858e3 + 1.2753e3*(468 + 273),
    p0=100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={55,80})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Trapezoid step1(
    each startTime=200,
    period=500,
    nperiod=1,
    rising=100,
    width=100,
    falling=100,
    each offset=0.0123,
    amplitude=0)
    annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
  .UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
    x1=linspace(
        1,
        8,
        8),
    y1=fuelPin.fp[1].T_f .- 273.15,
    x2=linspace(
        1,
        8,
        8),
    y2=fuelPin.fp[2].T_f .- 273.15,
    minX1=1,
    maxX1=8,
    minX2=1,
    maxX2=8,
    minY2=300,
    minY1=300,
    maxY1=500,
    maxY2=500)
    annotation (Placement(transformation(extent={{-210,-70},{-90,30}})));
  .UserInteraction.Outputs.SpatialPlot spatialPlot(
    y=channel.T .- 273.15,
    minX=1,
    minY=300,
    maxY=500,
    x=linspace(
        1,
        nNodes,
        nNodes),
    maxX=nNodes)
    annotation (Placement(transformation(extent={{80,20},{200,90}})));
equation
  connect(step.y, fuelPin.powerIn) annotation (Line(
      points={{-59,0},{-51,0},{-51,-0.25},{-43.875,-0.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPin.wall, convec.otherside) annotation (Line(
      points={{-22.5625,-0.25},{-3,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  // convec.fluidside.gamma = ramp2.y*ones(nNodes);
  convec.fluidside.gamma = 86.018e3*ones(nNodes);
  // Coupling of heat transfer to interface nodes
  for i in 1:nNodes loop
    fuelPin.fp[i].T_cool = convec.fluidside.T[i];
    fuelPin.fp[i].h = convec.fluidside.gamma[i];
  end for;
  connect(convec.fluidside, channel.wall) annotation (Line(
      points={{3,-0.25},{18,-0.25},{18,-0.15},{40,-0.15}},
      color={255,127,0},
      smooth=Smooth.None));

  connect(tubeIn.flange, channel.infl) annotation (Line(
      points={{55,-66},{55,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, channel.outfl) annotation (Line(
      points={{55,70},{55,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.in_w0, step1.y) annotation (Line(
      points={{61,-80},{79,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end FuelPinSim_wCoolant;
