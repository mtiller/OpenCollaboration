within ORNL_AdvSMR.PRISM.CORE;
model CylindricalFuelPelletSim2

  parameter Integer N=2;
  parameter Integer nNodes=2;

  FuelPellet fp(
    R_f=2.7051e-3,
    R_g=3.1242e-3,
    R_c=3.6830e-3,
    W_Pu=0.26,
    W_Zr=0.10,
    redeclare ORNL_AdvSMR.Thermal.HT wall,
    radNodes_c=4,
    radNodes_f=8,
    H_f=5.04,
    H_g=5.04,
    H_c=5.04)
    annotation (Placement(transformation(extent={{-60,-25},{-10,25}})));

  Modelica.Blocks.Sources.Constant const(k=1.35*2*4.6398e3)
    annotation (Placement(transformation(extent={{-90,-7.5},{-75,7.5}})));

  Thermal.ConvHT_htc convec(N=N) annotation (Placement(transformation(
        extent={{-35,-10.25},{35,10.25}},
        rotation=270,
        origin={35.25,0})));

  Thermal.HT_DHT hT_DHT(N=N, exchangeSurface=0.0116*5.04)
    annotation (Placement(transformation(extent={{5,-5},{15,5}})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    startTime=500,
    height=0,
    offset=1000)
    annotation (Placement(transformation(extent={{0,-95},{-15,-80}})));
  Components.PipeFlow channel(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
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
    dpnom(displayUnit="kPa") = 27500,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    DynamicMomentum=true,
    Nt=1,
    A=1.2468e-5,
    omega=0.0116,
    Dhyd=0.0043,
    wnom=0.0123,
    pstart=100000) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={122.5,0})));
  Components.SourceW tubeIn(
    p0(displayUnit="bar") = 100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=0.0246,
    h=28.8858e3 + 1.2753e3*(319 + 273)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={122.5,-90})));
  Components.SinkP tubeOut(
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    p0=100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={122.5,90})));
  Modelica.Blocks.Sources.Trapezoid step1(
    each startTime=200,
    period=500,
    nperiod=1,
    rising=100,
    width=100,
    falling=100,
    amplitude=-0.0246/2,
    each offset=0.0123)
    annotation (Placement(transformation(extent={{168,-90},{148,-70}})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(const.y, fp.powerIn) annotation (Line(
      points={{-74.25,0},{-57.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hT_DHT.DHT_port, convec.otherside) annotation (Line(
      points={{15.5,0},{32.175,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(fp.wall, hT_DHT.HT_port) annotation (Line(
      points={{-12.5,0},{4,0}},
      color={191,0,0},
      smooth=Smooth.None));
  convec.fluidside.gamma = ramp2.y*ones(N);
  fp.T_cool = sum(convec.fluidside.T)/N;
  fp.h = sum(convec.fluidside.gamma)/N;
  connect(convec.fluidside, channel.wall) annotation (Line(
      points={{38.325,-5.55112e-016},{85.5,-5.55112e-016},{85.5,-0.15},{107.5,-0.15}},

      color={255,127,0},
      smooth=Smooth.None));

  connect(tubeIn.flange, channel.infl) annotation (Line(
      points={{122.5,-80},{122.5,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, channel.outfl) annotation (Line(
      points={{122.5,80},{122.5,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.in_w0, step1.y) annotation (Line(
      points={{128.5,-94},{137.5,-94},{137.5,-80},{147,-80}},
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
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CylindricalFuelPelletSim2;
