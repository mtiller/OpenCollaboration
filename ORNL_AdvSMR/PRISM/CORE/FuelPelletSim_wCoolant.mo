within ORNL_AdvSMR.PRISM.CORE;
model FuelPelletSim_wCoolant

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=2 "Number of axial nodes";
  parameter Power Q_total=4.6398e3 "Total thermal power into the channel";

  FuelPellet fuelPin(W_Pu=0.26, varConductivity=true)
    annotation (Placement(transformation(extent={{-55,-10},{-35,10}})));
  Modelica.Blocks.Sources.Step[nNodes] step(
    each startTime=100,
    each height=0,
    each offset=Q_total/nNodes)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Thermal.ConvHT_htc convec(N=nNodes) annotation (Placement(transformation(
        extent={{-70,-10},{70,10}},
        rotation=270,
        origin={10,0})));
  Components.PipeFlow channel(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    L=5.04,
    H=5.04,
    dpnom(displayUnit="kPa") = 27500,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    A=0.00702,
    omega=0.0085,
    Dhyd=3.1660e-3,
    wnom=1126.4,
    nNodes=nNodes,
    Nt=2*169*271,
    pstart=100000) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={50,0})));
  Components.SourceW tubeIn(
    h=28.8858e3 + 1.2753e3*(282 + 273),
    p0(displayUnit="bar") = 100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1126.4) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,-90})));
  Components.SinkP tubeOut(
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    p0=100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,90})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Trapezoid step1(
    each offset=1126.4,
    each startTime=200,
    rising=0,
    width=250,
    falling=0,
    period=500,
    nperiod=1,
    amplitude=-1126.4/2)
    annotation (Placement(transformation(extent={{95,-90},{75,-70}})));
  Thermal.HT_DHT hT_DHT(exchangeSurface=1, N=nNodes)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
equation
  // convec.fluidside.gamma = ramp2.y*ones(nNodes);
  convec.fluidside.gamma = 50e3*ones(nNodes);
  // Coupling of heat transfer to interface nodes
  for i in 1:nNodes loop
    fuelPin.T_cool = convec.fluidside.T[i];
    fuelPin.h = convec.fluidside.gamma[i];
  end for;

  connect(tubeIn.flange, channel.infl) annotation (Line(
      points={{50,-80},{50,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, channel.outfl) annotation (Line(
      points={{50,80},{50,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.in_w0, step1.y) annotation (Line(
      points={{56,-94},{65,-94},{65,-80},{74,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step[1].y, fuelPin.powerIn) annotation (Line(
      points={{-69,0},{-54,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPin.wall, hT_DHT.HT_port) annotation (Line(
      points={{-36,0},{-22,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convec.fluidside, channel.wall) annotation (Line(
      points={{13,-5.55112e-016},{23,-5.55112e-016},{23,-0.15},{35,-0.15}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(hT_DHT.DHT_port, convec.otherside) annotation (Line(
      points={{1,0},{4,0},{4,4.44089e-016},{7,4.44089e-016}},
      color={255,127,0},
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
end FuelPelletSim_wCoolant;
