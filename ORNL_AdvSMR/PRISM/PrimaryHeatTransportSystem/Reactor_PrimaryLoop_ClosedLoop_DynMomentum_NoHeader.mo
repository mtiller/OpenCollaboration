within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model Reactor_PrimaryLoop_ClosedLoop_DynMomentum_NoHeader

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  Components.ChannelFlow2 core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    hstartin=28.8858e3 + 1.2753e3*(400 + 273),
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    hstartout=28.8858e3 + 1.2753e3*(550 + 273),
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={25,0})));
  Components.Pump primaryPump(
    wstart=0.7663,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    n0=1000,
    redeclare package Medium = Medium,
    rho0=950,
    dp0(displayUnit="kPa") = 15000,
    hstart=28.8858e3 + 1.2753e3*(400 + 273),
    Np0=1,
    w0=20,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1e-3,1e-1},
          head_nom={5,5}),
    usePowerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    V=0.1) annotation (Placement(transformation(extent={{55,-92},{35,-72}},
          rotation=0)));
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
    redeclare package Medium = Medium,
    hstartout=28.8858e3 + 1.2753e3*(400 + 273),
    hstartin=28.8858e3 + 1.2753e3*(550 + 273),
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.NoFriction,
    pstart=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit) annotation (Placement(
        transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={65,0})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    N=5,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2)) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={85.5,0})));
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
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={69,-41})));
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
    width=1000,
    startTime=5000,
    rising=1000,
    falling=1000,
    amplitude=1e-4)
    annotation (Placement(transformation(extent={{-95,-7.5},{-80,7.5}})));

  Components.Drum2States drum2States(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    Vd=1000,
    Vdcr=500,
    Mmd=500,
    Mmdcr=250,
    cm=2500,
    pstart=100000,
    Vldstart=500,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState)
    annotation (Placement(transformation(extent={{35,70},{55,90}})));
equation
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{72.5,0.075},{73.05,0.075},{73.05,0},{84,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{25,-34},{25,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{25,-46},{25,-75},{39,-75}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{25,34},{25,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, dcTo.inlet) annotation (Line(
      points={{65,-15},{65,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{65,-47},{65,-80},{53,-80}},
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
  heatSource1D1.power = -25.442e3;
  reactorKinetics.T_ce = sum(core.T)/nNodes;

  connect(drum2States.feed, coreTo.outlet) annotation (Line(
      points={{36,75.6},{25,75.6},{25,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(drum2States.steam, downcomer.infl) annotation (Line(
      points={{51.8,87.2},{65,87.2},{65,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
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
end Reactor_PrimaryLoop_ClosedLoop_DynMomentum_NoHeader;
