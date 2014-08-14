within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths2_works

  Components.PipeFlow core(
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N=4,
    DynamicMomentum=false,
    pstart=300000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-30})));
  ThermoPower3.Water.PumpNPSH primaryPump(
    V=0.01,
    usePowerCharacteristic=true,
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    Np0=1,
    w0=0.7663,
    rho0=1950,
    wstart=0.7663,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (q_nom={
            1e-4,4e-4}, head_nom={0.05,0.75}),
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    n0=1e6,
    dp0(displayUnit="kPa") = 10000) annotation (Placement(
        transformation(extent={{10,-77},{-10,-57}}, rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,-30})));
  Modelica.Blocks.Sources.Ramp ramp(
    offset=125e6/(19*24),
    duration=10,
    startTime=20,
    height=0) annotation (Placement(transformation(extent={{-95,-37.5},
            {-80,-22.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  ThermoPower3.Water.PressDrop pressDrop(
    wnom=0.7663,
    A=3.6326e-4,
    rhonom=1950,
    FFtype=ThermoPower3.Choices.PressDrop.FFtypes.OpPoint,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    dpnom(displayUnit="kPa") = 10000) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,30})));
  Components.PipeFlow downcomer(
    L=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    H=-0.80,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=(700 + 273.15)*2380,
    hstartout=(650 + 273.15)*2380,
    rhonom=1950,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N=4,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit)
                                                  annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={50,30})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={70,30})));
  ThermoPower3.Water.PressDrop pressDrop1(
    wnom=0.7663,
    A=3.6326e-4,
    rhonom=1950,
    FFtype=ThermoPower3.Choices.PressDrop.FFtypes.OpPoint,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    dpnom(displayUnit="kPa") = 10000) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={50,-30})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=100,
    startTime=500,
    offset=-125e6/(19*24),
    height=0) annotation (Placement(transformation(extent={{95,22.5},{
            80,37.5}})));
equation
  connect(primaryPump.outfl, core.infl) annotation (Line(
      points={{-6,-60},{-50,-60},{-50,-40}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-59,-29.95},{-63.75,-29.95},{-63.75,-30},{-68.5,-30}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-79.25,-30},{-72,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(core.outfl, pressDrop.inlet) annotation (Line(
      points={{-50,-20},{-50,20}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{59,29.95},{63.75,29.95},{63.75,30},{68.5,30}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{79.25,30},{72,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pressDrop.outlet, downcomer.infl) annotation (Line(
      points={{-50,40},{-50,60},{50,60},{50,40}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(downcomer.outfl, pressDrop1.inlet) annotation (Line(
      points={{50,20},{50,-20}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(pressDrop1.outlet, primaryPump.infl) annotation (Line(
      points={{50,-40},{50,-65},{8,-65}},
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
      StopTime=10,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths2_works;
