within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths5_Flibe_noPD

  Components.PipeFlow core(
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 15000,
    avoidInletEnthalpyDerivative=false,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N=4,
    pstart=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,0})));
  ThermoPower3.Water.Pump primaryPump(
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
    rho0=1950,
    dp0(displayUnit="kPa") = 15000,
    n0=100,
    wstart=0.7663,
    initOpt=ThermoPower3.Choices.Init.Options.noInit,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=100,
    startTime=500,
    offset=125e6/(19*72),
    height=125e6/(19*72)) annotation (Placement(transformation(extent={
            {-95,-7.5},{-80,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Components.PipeFlow downcomer(
    L=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=(700 + 273.15)*2380,
    hstartout=(650 + 273.15)*2380,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 15000,
    H=-0.80,
    avoidInletEnthalpyDerivative=false,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N=4,
    pstart=100000) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={50,0})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={70,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=100,
    offset=-125e6/(19*72),
    height=-125e6/(19*72),
    startTime=1000)
    annotation (Placement(transformation(extent={{95,-7.5},{80,7.5}})));
  ThermoPower3.Water.Header header(
    V=1000,
    S=100,
    H=0,
    Cm=5000,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    gamma=0,
    pstart=100000,
    Tmstart=873.15,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{-10,35},{10,55}})));

  ClosedSystemInitializer closedSystemInitializer(p_start=100000,
      redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{-45,60},{-25,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{-75,61},{-55,81}})));
equation
  connect(primaryPump.outfl, core.infl) annotation (Line(
      points={{-6,-53},{-50,-53},{-50,-10}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-59,0.05},{-62,0.05},{-62,0},{-68.5,0}},
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
      points={{50,-10},{50,-58},{8,-58}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.outfl, header.inlet) annotation (Line(
      points={{-50,10},{-50,45},{-10.1,45}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.infl, header.outlet) annotation (Line(
      points={{50,10},{50,45},{10,45}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(closedSystemInitializer.port, header.inlet) annotation (Line(
      points={{-35,61},{-35,45},{-10.1,45}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(realExpression.y, closedSystemInitializer.initialConditionResidual)
    annotation (Line(
      points={{-54,71},{-44,71}},
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
      StopTime=10,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths5_Flibe_noPD;
