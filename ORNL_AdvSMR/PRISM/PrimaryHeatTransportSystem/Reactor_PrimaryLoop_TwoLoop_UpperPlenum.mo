within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model Reactor_PrimaryLoop_TwoLoop_UpperPlenum

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
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
    pstart=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit) annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-20.5,0})));
  Components.PipeFlow downcomer(
    Cfnom=0.005,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    redeclare package Medium = Medium,
    hstartout=28.8858e3 + 1.2753e3*(400 + 273),
    hstartin=28.8858e3 + 1.2753e3*(550 + 273),
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    H=-0.80,
    nNodes=nNodes,
    wnom=15,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={59.5,0})));
  Components.Pump primaryPump(
    wstart=0.7663,
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
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    n0=1000,
    V=0.5) annotation (Placement(transformation(extent={{49.5,-95},{29.5,-75}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    N=nNodes) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={77,0})));
  Components.Plenum upperPlenum(
    redeclare package Medium = Medium,
    A=4,
    V0=1,
    ystart=1,
    initOpt=Choices.Init.Options.noInit,
    hstart=28.8858e3 + 1.2753e3*(550 + 273),
    pext=200000)
    annotation (Placement(transformation(extent={{-10,75},{30,100}})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24.5,-40})));
  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24.5,30})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={63.5,30})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={63.5,-41})));
  CORE.FuelPinModel fuelPinModel(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-49,-36.5},{-41.5,36.5}})));
  CORE.ReactorKinetics reactorKinetics(
    noAxialNodes=9,
    noFuelAssemblies=1,
    noFuelPins=1,
    alpha_f=0,
    alpha_c=0,
    Q_nom=10e3,
    T_f0=1073.15,
    T_c0=623.15)
    annotation (Placement(transformation(extent={{-90.5,-15},{-60,15}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    offset=0,
    rising=500,
    width=500,
    falling=500,
    period=1500,
    amplitude=0,
    startTime=0) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-95,40})));

  Modelica.Blocks.Sources.Ramp ramp(
    height=0,
    duration=1,
    startTime=0,
    offset=-0.338e6*0.1)
    annotation (Placement(transformation(extent={{94.5,-5},{84.5,5}})));

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    startTime=5000,
    offset=1000,
    height=-500)
    annotation (Placement(transformation(extent={{54.5,-70},{44.5,-60}})));
  Components.LowerPlenum_2o lowerPlenum_2o annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={19.5,-78})));
  Components.ChannelFlow2 core1(
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
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=28.8858e3 + 1.2753e3*(400 + 273),
    hstartout=28.8858e3 + 1.2753e3*(400 + 273),
    pstart=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit) annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={5,-0.5})));
  Components.SensT coreTi1(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1,-40.5})));
  Components.SensT coreTo1(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1,29.5})));
  Components.UpperPlenum_2i upperPlenum_2i annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-5,60})));
equation
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{67,0.075},{67.55,0.075},{67.55,0},{75.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{-20.5,-34},{-20.5,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{-20.5,24},{-20.5,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTi.outlet, downcomer.infl) annotation (Line(
      points={{59.5,24},{59.5,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, dcTo.inlet) annotation (Line(
      points={{59.5,-15},{59.5,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{59.5,-47},{59.5,-83},{47.5,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-95,34.5},{-95,0},{-90.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPinModel.powerIn) annotation (Line(
      points={{-60,0},{-50.875,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.T_fe, reactorKinetics.T_fe) annotation (Line(
      points={{-45.25,-36.5},{-45.25,-45},{-66.1,-45},{-66.1,-15}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(fuelPinModel.heatOut, core.wall) annotation (Line(
      points={{-40.5625,0},{-26.5,0}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{79,0},{84,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(upperPlenum.outlet, dcTi.inlet) annotation (Line(
      points={{25,79},{25,50},{59.5,50},{59.5,36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  reactorKinetics.T_ce = sum(core.T)/nNodes;

  connect(ramp1.y, primaryPump.in_n) annotation (Line(
      points={{44,-65},{42.1,-65},{42.1,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lowerPlenum_2o.in1, primaryPump.outfl) annotation (Line(
      points={{25.5,-78},{33.5,-78}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coreTi1.outlet, core1.infl) annotation (Line(
      points={{5,-34.5},{5,-15.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo1.inlet, core1.outfl) annotation (Line(
      points={{5,23.5},{5,14.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.outlet, upperPlenum_2i.in1) annotation (Line(
      points={{-20.5,36},{-20.5,45.5},{-9,45.5},{-9,54}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum_2i.in2, coreTo1.outlet) annotation (Line(
      points={{-1,54},{-1,45.5},{5,45.5},{5,35.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum_2i.out, upperPlenum.inlet) annotation (Line(
      points={{-5,66},{-5,79}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(lowerPlenum_2o.out2, coreTi1.inlet) annotation (Line(
      points={{13.5,-74},{5,-74},{5,-46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(lowerPlenum_2o.out1, coreTi.inlet) annotation (Line(
      points={{13.5,-82},{-20.5,-82},{-20.5,-46}},
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
end Reactor_PrimaryLoop_TwoLoop_UpperPlenum;
