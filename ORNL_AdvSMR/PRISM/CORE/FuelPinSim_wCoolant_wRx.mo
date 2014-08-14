within ORNL_AdvSMR.PRISM.CORE;
model FuelPinSim_wCoolant_wRx

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=10 "Number of axial nodes";

  parameter Power Q_nom=250e6 "Reactor nominal heat rating (W)"
    annotation (Dialog(tab="General"));
  parameter Integer noRadialNodes=4 "Number of radial zones"
    annotation (Dialog(tab="General"));
  parameter Integer noAxialNodes=8 "Number of axial zones"
    annotation (Dialog(tab="General"));
  parameter Integer noFuelAssemblies=10 "Number of fuel assemblies"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Integer noFuelPins=12*12 "Number of fuel pins in an assembly"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Length H_fuelPin=3 "Active height of a fuel pin"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Boolean usePowerProfile=true "Use power profile output"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  /* Neutron kinetic parameters */
  parameter Real[6] beta={0.000215,0.001424,0.001274,0.002568,0.000748,0.000273}
    "Delayed neutron precursor fractions"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real[6] lambda(unit="1/s") = {0.0124,0.0305,0.111,0.301,1.14,3.01}
    "Decay constants for each precursor group"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real Lambda(unit="s") = 0.03 "Mean neutron generation time"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  /* Reactivity feedback parameters */
  parameter Real alpha_f=-3.80 "Fuel Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter Temperature T_f0=1300 + 273.15 "Fuel reference temperature"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter Real alpha_c=-0.51 "Coolant density feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter Temperature T_c0=675 + 273.15 "Coolant reference temperature"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  /* Fuel Cycle Parameters */
  parameter Time T_op=360*24*3600 "Time since reactor startup"
    annotation (Dialog(tab="Kinetics", group="Fuel Cycle Parameters"));

  FuelPin fuelPin(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{0,-50},{11,50}})));

  Thermal.ConvHT_htc convec(N=nNodes) annotation (Placement(transformation(
        extent={{-40,-7.5},{40,7.5}},
        rotation=270,
        origin={37.5,0})));

  Components.PipeFlow channel(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.PartialBundleHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=nNodes,
    L=5.04,
    H=5.04,
    A=1.9799e-4,
    omega=2.4936e-2,
    Dhyd=3.1758e-2,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=false,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    Nt=2,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    pstart=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,0})));
  Components.SourceW tubeIn(
    h=28.8858e3 + 1.2753e3*(282 + 273),
    p0(displayUnit="bar") = 100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=16*1126.4/(169*271)) annotation (Placement(transformation(
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=90,
        origin={80,-37.5})));
  Components.SinkP tubeOut(
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    p0=100000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na) annotation (
      Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=90,
        origin={80,38})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ReactorKinetics reactorKinetics(
    noAxialNodes=nNodes,
    alpha_c=0,
    noFuelAssemblies=1,
    noFuelPins=1,
    alpha_f=0,
    Q_nom=12e3,
    H_fuelPin=5.04,
    T_f0=817.9,
    T_c0=623.15)
    annotation (Placement(transformation(extent={{-70,-25},{-20,25}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    period=1000,
    offset=0,
    width=100,
    rising=100,
    falling=100,
    startTime=500,
    amplitude=0)
    annotation (Placement(transformation(extent={{-95,-7.5},{-80,7.5}})));
  Modelica.Blocks.Sources.Trapezoid w(
    nperiod=1,
    period=1000,
    width=100,
    rising=100,
    falling=100,
    startTime=500,
    amplitude=0,
    offset=16*1126.4/(169*271))
    annotation (Placement(transformation(extent={{50.5,-79.5},{65.5,-64.5}})));

equation
  connect(fuelPin.wall, convec.otherside) annotation (Line(
      points={{12.375,0},{35.25,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convec.fluidside, channel.wall) annotation (Line(
      points={{39.75,-4.44089e-016},{48,-4.44089e-016},{48,-0.05},{75,-0.05}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(tubeIn.flange, channel.infl) annotation (Line(
      points={{80,-30},{80,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, channel.outfl) annotation (Line(
      points={{80,30.5},{80,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-79.25,0},{-70,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPin.powerIn) annotation (Line(
      points={{-20,0},{-2.75,0}},
      color={0,0,127},
      smooth=Smooth.None));
  reactorKinetics.T_ce = 0;
  reactorKinetics.T_fe = sum(fuelPin.fp.T_f[1])/nNodes;
  convec.fluidside.gamma = 10e3*ones(nNodes);
  // Coupling of heat transfer to interface nodes
  for i in 1:nNodes loop
    fuelPin.fp[i].T_cool = convec.fluidside.T[i];
    fuelPin.fp[i].h = convec.fluidside.gamma[i];
  end for;
  connect(w.y, tubeIn.in_w0) annotation (Line(
      points={{66.25,-72},{95.5,-72},{95.5,-40.5},{84.5,-40.5}},
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
end FuelPinSim_wCoolant_wRx;
