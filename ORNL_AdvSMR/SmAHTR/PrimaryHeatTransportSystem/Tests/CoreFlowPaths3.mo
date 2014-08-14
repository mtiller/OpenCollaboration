within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths3

  Components.PipeFlow core(
    N=20,
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    rhonom=1000,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 15000,
    pstart=10000000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,0})));
  ThermoPower3.Water.PumpNPSH primaryPump(
    V=0.01,
    CheckValve=true,
    usePowerCharacteristic=true,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (q_nom={
            0.001,0.0015}, head_nom={30,0}),
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    Np0=1,
    w0=0.7663,
    n0=1000,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    hstart=1e5,
    rho0=1500,
    wstart=1,
    dp0(displayUnit="kPa") = 15000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-67.5},{-10,-47.5}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    N=20,
    L=0.80,
    omega=0.0173) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=100,
    startTime=500,
    height=0,
    offset=125e6/(19*72)) annotation (Placement(transformation(extent={
            {-95,-7.5},{-80,7.5}})));
  inner System system(allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow downcomer(
    N=20,
    L=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    rhonom=1950,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    H=-0.80,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 15000,
    pstart=10000000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={50,0})));
  Thermal.HeatSource1D heatSource1D1(
    N=20,
    L=0.80,
    omega=0.0173) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={70,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=100,
    startTime=500,
    height=0,
    offset=-125e6/(19*72))
    annotation (Placement(transformation(extent={{95,-7.5},{80,7.5}})));
  ThermoPower3.Water.Header header(
    S=100,
    H=0,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ThermoPower3.Choices.Init.Options.noInit,
    V=1000,
    pstart=10000000,
    Tmstart=573.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,45},{10,65}})));

equation
  connect(primaryPump.outfl, core.infl) annotation (Line(
      points={{-6,-50.5},{-50,-50.5},{-50,-10}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-59,0.05},{-63.75,0.05},{-63.75,0},{-68.5,0}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-79.25,0},{-72,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{59,-0.05},{63.75,-0.05},{63.75,0},{68.5,0}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{79.25,0},{72,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.outfl, primaryPump.infl) annotation (Line(
      points={{50,-10},{50,-55.5},{8,-55.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(core.outfl, header.inlet) annotation (Line(
      points={{-50,10},{-50,55},{-10.1,55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(header.outlet, downcomer.infl) annotation (Line(
      points={{10,55},{50,55},{50,10}},
      color={0,0,255},
      thickness=1,
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
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths3;
