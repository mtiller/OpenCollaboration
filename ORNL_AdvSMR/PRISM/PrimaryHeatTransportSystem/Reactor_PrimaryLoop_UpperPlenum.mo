within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model Reactor_PrimaryLoop_UpperPlenum

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow core(
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
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    hstartout=28.8858e3 + 1.2753e3*(550 + 273),
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={20,0})));
  Components.PipeFlow downcomer(
    Cfnom=0.005,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
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
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    H=-0.80,
    nNodes=nNodes,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={60,0})));
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
        transformation(extent={{50,-95},{30,-75}}, rotation=0)));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    N=nNodes) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={80.5,0})));
  Components.Plenum upperPlenum(
    redeclare package Medium = Medium,
    A=4,
    V0=1,
    ystart=1,
    initOpt=Choices.Init.Options.noInit,
    hstart=28.8858e3 + 1.2753e3*(550 + 273),
    pext=200000)
    annotation (Placement(transformation(extent={{20,60},{60,85}})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,-40})));
  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,40})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,40})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-41})));
  CORE.ReactorKinetics reactorKinetics(
    noAxialNodes=9,
    noFuelAssemblies=1,
    noFuelPins=1,
    alpha_f=0,
    alpha_c=0,
    Q_nom=10e3,
    T_f0=1073.15,
    T_c0=623.15)
    annotation (Placement(transformation(extent={{-85,-20},{-45,20}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    offset=0,
    startTime=2000,
    rising=500,
    width=500,
    falling=500,
    period=1500,
    amplitude=-1e-4)
    annotation (Placement(transformation(extent={{-105,-5},{-95,5}})));

  Modelica.Blocks.Sources.Ramp ramp(
    offset=-337.85e3,
    duration=950,
    height=-337.85e3*0.54875,
    startTime=2200)
    annotation (Placement(transformation(extent={{95,-5},{85,5}})));

  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1000,
    duration=6000,
    height=-500,
    startTime=10000)
    annotation (Placement(transformation(extent={{55,-70},{45,-60}})));

  CORE.FuelPin fuelPin(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-30,-75},{-14.5,75}})));
  Thermal.ConvHT_htc convec(N=nNodes) annotation (Placement(transformation(
        extent={{-75,-10},{75,10}},
        rotation=270,
        origin={0,0})));
equation
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{67.5,0.075},{68.05,0.075},{68.05,0},{79,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{20,-34},{20,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{20,-46},{20,-78},{34,-78}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{20,34},{20,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTi.outlet, downcomer.infl) annotation (Line(
      points={{60,34},{60,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, dcTo.inlet) annotation (Line(
      points={{60,-15},{60,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{60,-47},{60,-83},{48,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-94.5,0},{-85,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{82.5,0},{84.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(upperPlenum.inlet, coreTo.outlet) annotation (Line(
      points={{25,64},{25,55},{20,55},{20,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum.outlet, dcTi.inlet) annotation (Line(
      points={{55,64},{55,55},{60,55},{60,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ramp1.y, primaryPump.in_n) annotation (Line(
      points={{44.5,-65},{42.6,-65},{42.6,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  for i in 1:nNodes loop
    fuelPin.fp[i].T_cool = convec.fluidside.T[i];
    fuelPin.fp[i].h = 1e4;
  end for;
  convec.fluidside.gamma = 1e4*ones(nNodes);
  reactorKinetics.T_ce = sum(core.T)/nNodes;
  reactorKinetics.T_fe = 500;

  connect(fuelPin.wall, convec.otherside) annotation (Line(
      points={{-12.5625,0},{-3,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPin.powerIn) annotation (Line(
      points={{-45,0},{-33.875,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(convec.fluidside, core.wall) annotation (Line(
      points={{3,0},{8,0},{8,-0.075},{12.5,-0.075}},
      color={255,127,0},
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
end Reactor_PrimaryLoop_UpperPlenum;
