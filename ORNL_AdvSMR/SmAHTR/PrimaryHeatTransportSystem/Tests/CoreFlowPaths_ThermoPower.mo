within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths_ThermoPower

  Components.PipeFlow core(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N=20,
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Cfnom,
    Cfnom=0.005,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    dpnom(displayUnit="kPa") = 15000,
    rhonom=1950,
    A=3.6326e-4) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-30})));
  Components.SourceW sourceW(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    w0=0.7663,
    p0=101325,
    h=(650 + 273.15)*2380) annotation (Placement(transformation(extent=
            {{-70,-90},{-50,-70}})));
  ThermoPower3.Water.PumpNPSH Pump1(
    V=0.01,
    CheckValve=true,
    usePowerCharacteristic=true,
    n0=1500,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (q_nom={
            0.001,0.0015}, head_nom={30,0}),
    wstart=0,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    Np0=1,
    rho0=2839,
    w0=0.7663,
    dp0(displayUnit="kPa") = 15000) annotation (Placement(
        transformation(extent={{-27,-92},{-7,-72}}, rotation=0)));
  Components.SinkP sinkP(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,80})));
  Thermal.HeatSource1D heatSource1D(
    N=20,
    L=0.80,
    omega=0.0173) annotation (Placement(transformation(
        extent={{-20,-10},{20,10}},
        rotation=90,
        origin={-40,-30})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=100,
    offset=125e6/(19*72),
    startTime=500,
    height=1e4) annotation (Placement(transformation(extent={{-80,-40},
            {-60,-20}})));
  inner System system annotation (Placement(transformation(extent={{-100,
            80},{-80,100}})));
  ThermoPower3.Water.PressDrop pressDrop(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    wnom=0.7663,
    FFtype=ThermoPower3.Choices.PressDrop.FFtypes.OpPoint,
    dpnom(displayUnit="kPa") = 15000,
    rhonom=1950,
    A=3.6326e-4) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,30})));
equation
  connect(sourceW.flange, Pump1.infl) annotation (Line(
      points={{-50,-80},{-25,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-18,-29.9},{-27.5,-29.9},{-27.5,-30},{-37,-30}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-59,-30},{-44,-30}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(pressDrop.outlet, sinkP.flange) annotation (Line(
      points={{0,50},{0,70}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(Pump1.outfl, core.infl) annotation (Line(
      points={{-11,-75},{0,-75},{0,-50}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(core.outfl, pressDrop.inlet) annotation (Line(
      points={{0,-10},{0,10}},
      color={0,127,255},
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
    __Dymola_experimentSetupOutput(textual=true, doublePrecision=true));
end CoreFlowPaths_ThermoPower;
