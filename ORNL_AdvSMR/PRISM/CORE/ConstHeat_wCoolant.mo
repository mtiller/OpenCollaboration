within ORNL_AdvSMR.PRISM.CORE;
model ConstHeat_wCoolant

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=2 "Number of axial nodes";
  parameter Power Q_total=4.6398e3 "Total thermal power into the channel";

  Thermal.HeatSource1D fuelPin(
    N=nNodes,
    L=5.04,
    omega=0.0116,
    Nt=169*271*2) annotation (Placement(transformation(
        extent={{-20,-10},{20,10}},
        rotation=90,
        origin={-30,0})));
  Modelica.Blocks.Sources.Step step(
    each startTime=100,
    each height=0,
    each offset=Q_total/nNodes)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Thermal.ConvHT_htc convec(N=nNodes) annotation (Placement(transformation(
        extent={{-60,-10},{60,10}},
        rotation=270,
        origin={1.24345e-014,0})));
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
    wnom=0.0123,
    dpnom(displayUnit="kPa") = 586000,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    Nt=169*271*2,
    pstart=100000) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={50,-3.55271e-015})));
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
        origin={50,80})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Trapezoid step1(
    each startTime=200,
    period=500,
    nperiod=1,
    rising=100,
    width=100,
    falling=100,
    amplitude=-0.0123/2,
    each offset=0.0123)
    annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
equation
  // convec.fluidside.gamma = ramp2.y*ones(nNodes);
  convec.fluidside.gamma = 86.018e3*ones(nNodes);
  connect(convec.fluidside, channel.wall) annotation (Line(
      points={{3,-5.55112e-016},{13,-5.55112e-016},{13,-0.15},{35,-0.15}},
      color={255,127,0},
      smooth=Smooth.None));

  connect(tubeIn.flange, channel.infl) annotation (Line(
      points={{55,-66},{55,-30},{50,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, channel.outfl) annotation (Line(
      points={{50,70},{50,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.in_w0, step1.y) annotation (Line(
      points={{61,-80},{79,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPin.wall, convec.otherside) annotation (Line(
      points={{-27,-2.22045e-016},{-15,-2.22045e-016},{-15,5.55112e-016},{-3,
          5.55112e-016}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(fuelPin.power, step.y) annotation (Line(
      points={{-34,2.22045e-016},{-47,2.22045e-016},{-47,0},{-59,0}},
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
end ConstHeat_wCoolant;
