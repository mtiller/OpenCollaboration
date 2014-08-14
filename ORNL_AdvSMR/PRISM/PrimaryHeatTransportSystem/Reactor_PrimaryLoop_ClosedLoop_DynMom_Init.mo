within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model Reactor_PrimaryLoop_ClosedLoop_DynMom_Init

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  Components.ChannelFlow2 core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    hstartin=28.8858e3 + 1.2753e3*(400 + 273),
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    hstartout=28.8858e3 + 1.2753e3*(550 + 273),
    nNodes=nNodes,
    DynamicMomentum=true,
    pstart=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit) annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={25,0})));
  Components.Pump primaryPump(
    usePowerCharacteristic=true,
    n0=1000,
    redeclare package Medium = Medium,
    rho0=950,
    dp0(displayUnit="kPa") = 15000,
    hstart=28.8858e3 + 1.2753e3*(400 + 273),
    Np0=1,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1e-3,1e-1},
          head_nom={5e-1,4e1}),
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower (power=1e3),
    V=0,
    w0=20,
    wstart=20,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState) annotation (Placement(
        transformation(extent={{54.5,-92},{34.5,-72}}, rotation=0)));
  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow downcomer(
    Cfnom=0.005,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    nNodes=5,
    H=-0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    redeclare package Medium = Medium,
    hstartout=28.8858e3 + 1.2753e3*(400 + 273),
    hstartin=28.8858e3 + 1.2753e3*(550 + 273),
    DynamicMomentum=true,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={65.5,0})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    N=5,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2)) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={85.5,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=2000,
    height=0,
    startTime=0,
    offset=-5e3)
    annotation (Placement(transformation(extent={{105.5,-7.5},{90.5,7.5}})));
  Components.Header header(
    H=0,
    Cm=2500,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    S=100,
    gamma=0.1,
    V=1000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    allowFlowReversal=true,
    hstart=28.8858e3 + 1.2753e3*(550 + 273),
    pstart=100000,
    Tmstart=773.15,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState)
    annotation (Placement(transformation(extent={{35,65},{55,85}})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={21,-40})));
  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={21,40})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={69.5,40})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={69.5,-41})));
  CORE.FuelPinModel fuelPinModel(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-10,-75},{5.5,75}})));
  CORE.ReactorKinetics reactorKinetics(
    noAxialNodes=9,
    noFuelAssemblies=1,
    noFuelPins=1,
    alpha_f=0,
    alpha_c=0,
    Q_nom=7.5e3,
    T_f0=1073.15,
    T_c0=623.15)
    annotation (Placement(transformation(extent={{-70,-20},{-30,20}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    period=1000,
    offset=0,
    amplitude=5e-5,
    width=1000,
    startTime=5000,
    rising=1000,
    falling=1000)
    annotation (Placement(transformation(extent={{-95,-7.5},{-80,7.5}})));

equation
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{89.75,0},{87.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{73,0.075},{73.05,0.075},{73.05,0},{84,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{25,-34},{25,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{25,-46},{25,-75},{38.5,-75}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{25,34},{25,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.outlet, header.inlet) annotation (Line(
      points={{25,46},{25,75},{35,75}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(header.outlet, dcTi.inlet) annotation (Line(
      points={{55,75},{65.5,75},{65.5,46}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTi.outlet, downcomer.infl) annotation (Line(
      points={{65.5,34},{65.5,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, dcTo.inlet) annotation (Line(
      points={{65.5,-15},{65.5,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{65.5,-47},{65.5,-80},{52.5,-80}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-79.25,0},{-70,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPinModel.powerIn) annotation (Line(
      points={{-30,0},{-13.875,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.T_fe, reactorKinetics.T_fe) annotation (Line(
      points={{-2.25,-75},{-2.25,-95},{-38,-95},{-38,-20}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(fuelPinModel.heatOut, core.wall) annotation (Line(
      points={{7.4375,0},{19,0}},
      color={127,0,0},
      smooth=Smooth.None));
  reactorKinetics.T_ce = sum(core.T)/nNodes;

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
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Reactor_PrimaryLoop_ClosedLoop_DynMom_Init;
