within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model Reactor_PrimaryLoop_UpperPlenum_wIHX

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.ChannelFlow2 core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    L=5.04,
    H=5.04,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    Nt=2139*2,
    A=1.9799e-4,
    omega=2.4936e-2,
    Dhyd=3.1758e-2,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    rhonom=900,
    hstartin=28.8858e3 + 1.2753e3*(319 + 273),
    hstartout=28.8858e3 + 1.2753e3*(468 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={0,0})));
  Components.Pump primaryPump(
    wstart=0.7663,
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
    V=0.1,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState) annotation (Placement(
        transformation(extent={{29,-95},{9,-75}}, rotation=0)));
  Components.Plenum upperPlenum(
    redeclare package Medium = Medium,
    A=4,
    V0=1,
    ystart=1,
    initOpt=Choices.Init.Options.noInit,
    hstart=28.8858e3 + 1.2753e3*(468 + 273),
    pext=200000) annotation (Placement(transformation(extent={{0,60},{40,85}})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,-40})));
  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,40.5})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,40})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={49,-61})));
  CORE.FuelPinModel fuelPinModel(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-25,-22.5},{-20,22.5}})));
  CORE.ReactorKinetics reactorKinetics(
    noAxialNodes=9,
    noFuelAssemblies=1,
    noFuelPins=1,
    alpha_f=0,
    alpha_c=0,
    Q_nom=212.5e3,
    T_f0=1073.15,
    T_c0=623.15)
    annotation (Placement(transformation(extent={{-75,-20},{-35,20}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    offset=0,
    startTime=2000,
    rising=500,
    width=500,
    falling=500,
    period=1500,
    amplitude=0)
    annotation (Placement(transformation(extent={{-95,-5},{-85,5}})));

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1000,
    duration=6000,
    height=-500,
    startTime=10000)
    annotation (Placement(transformation(extent={{34,-70},{24,-60}})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger
    annotation (Placement(transformation(extent={{50,-5},{91.5,36.5}})));
  Components.SourceW tubeIn(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    h=28.8858e3 + 1.2753e3*(282 + 273),
    w0=1152.9,
    p0(displayUnit="bar") = 100000) annotation (Placement(transformation(
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=90,
        origin={70.5,62.5})));
  Components.SinkP tubeOut(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=90,
        origin={71,-27.5})));
equation
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{0,-34},{0,-29.5},{-8.88178e-016,-29.5},{-8.88178e-016,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));

  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{-4.44089e-016,-46},{-4.44089e-016,-78},{13,-78}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{-4.44089e-016,34.5},{-4.44089e-016,24.5},{8.88178e-016,24.5},{
          8.88178e-016,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{45,-67},{45,-83},{27,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-84.5,0},{-75,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPinModel.powerIn) annotation (Line(
      points={{-35,0},{-26.25,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.T_fe, reactorKinetics.T_fe) annotation (Line(
      points={{-22.5,-22.5},{-22.5,-35},{-43,-35},{-43,-20}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(fuelPinModel.heatOut, core.wall) annotation (Line(
      points={{-19.375,0},{-6,0}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(upperPlenum.inlet, coreTo.outlet) annotation (Line(
      points={{5,64},{5,55},{0,55},{0,46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum.outlet, dcTi.inlet) annotation (Line(
      points={{35,64},{35,55},{40,55},{40,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  reactorKinetics.T_ce = sum(core.T)/nNodes;

  connect(ramp1.y, primaryPump.in_n) annotation (Line(
      points={{23.5,-65},{21.6,-65},{21.6,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcTi.outlet, intermediateHeatExchanger.shellInlet) annotation (Line(
      points={{40,34},{40,25.0875},{52.075,25.0875}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.shellOutlet, dcTo.inlet) annotation (Line(
      points={{89.425,7.45},{95,7.45},{95,-45.5},{45,-45.5},{45,-55}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, intermediateHeatExchanger.tubeOutlet) annotation (
      Line(
      points={{71,-20},{71,-7.075},{70.75,-7.075}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.flange, intermediateHeatExchanger.tubeInlet) annotation (Line(
      points={{70.5,55},{70.5,38.575},{70.75,38.575}},
      color={0,127,255},
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
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Reactor_PrimaryLoop_UpperPlenum_wIHX;
