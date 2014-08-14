within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths7_pumpWorks_PD_expVol

  Components.PipeFlow core(
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 1,
    N=5,
    L=0.80,
    H=0.80,
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-45,0})));
  ThermoPower3.Water.Pump primaryPump(
    V=0.01,
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    w0=0.7663,
    rho0=1950,
    wstart=0.7663,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    usePowerCharacteristic=true,
    n0=100,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (head_nom=
           {0.05,0.75}, q_nom={1e-4,5e-4}),
    dp0(displayUnit="kPa") = 15000,
    Np0=5) annotation (Placement(transformation(extent={{10,-77},{-10,-57}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    omega=0.0173,
    N=5,
    L=0.80) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-65,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=250,
    duration=150,
    height=0,
    offset=125e6/(19*24*3)) annotation (Placement(transformation(extent=
           {{-90,-7.5},{-75,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow downcomer(
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=(700 + 273.15)*2380,
    hstartout=(650 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    N=5,
    H=-0.80,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={45,1.77636e-015})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    omega=0.0173,
    N=5) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={65,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=200,
    startTime=300,
    height=0,
    offset=-125e6/(19*24*3))
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));
  Components.Header header(
    H=0,
    Cm=2500,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    V=1000,
    S=100,
    gamma=0.1,
    pstart=100000,
    Tmstart=873.15)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

equation
  connect(primaryPump.outfl, core.infl) annotation (Line(
      points={{-6,-60},{-45,-60},{-45,-15}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-74.25,0},{-67,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{74.25,0},{67,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.outfl, primaryPump.infl) annotation (Line(
      points={{45,-15},{45,-65},{8,-65}},
      color={0,127,255},
      pattern=LinePattern.None,
      thickness=1,
      smooth=Smooth.None));
  connect(core.outfl, header.inlet) annotation (Line(
      points={{-45,15},{-45,60},{-10.1,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(downcomer.infl, header.outlet) annotation (Line(
      points={{45,15},{45,60},{10,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{58.5,-0.075},{61,-0.075},{61,0},{63.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-58.5,0.075},{-61,0.075},{-61,0},{-63.5,0}},
      color={255,127,0},
      thickness=0.5,
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
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths7_pumpWorks_PD_expVol;
