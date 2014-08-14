within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths7_pump_expVol_geom2_mult

  ThermoPower3.Water.Flow1D core(
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    dpnom(displayUnit="kPa") = 1,
    N=5,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    HydraulicCapacitance=ORNL_AdvSMR.Choices.Flow1D.HCtypes.Middle,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Cfnom,
    Cfnom=0.005,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-45,0})));
  Components.Pump primaryPump(
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    rho0=1950,
    wstart=0.7663,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    usePowerCharacteristic=true,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    w0=1325/(19*19),
    n0=1000,
    V=8/(4^3),
    dp0(displayUnit="kPa") = 10000,
    redeclare function flowCharacteristic =
        ORNL_SMR.Functions.PumpCharacteristics.linearFlow (head_nom={
            0.05,200}, q_nom={1e-4,7}),
    Np0=1) annotation (Placement(transformation(extent={{30,-100},{10,-80}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    N=5,
    L=0.80,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2)) annotation (
      Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-65,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1000,
    startTime=10000,
    offset=125e6/(19*19*4),
    height=-125e6/(19*19*40)) annotation (Placement(transformation(
          extent={{-90,-7.5},{-75,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  ThermoPower3.Water.Flow1D downcomer(
    hstartin=(700 + 273.15)*2380,
    hstartout=(650 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    N=5,
    H=-0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    pstart=100000,
    HydraulicCapacitance=ORNL_AdvSMR.Choices.Flow1D.HCtypes.Middle,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Cfnom,
    Cfnom=0.005) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={45,1.77636e-015})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    N=5,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2)) annotation (
      Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={65,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1000,
    startTime=10000,
    offset=-125e6/(19*19*4),
    height=125e6/(19*19*40))
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));
  Components.Header header(
    H=0,
    Cm=2500,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    S=100,
    gamma=0.1,
    V=1000,
    pstart=100000,
    Tmstart=873.15)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));

  Components.SensT sensT1(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-49,-40})));
  Components.SensT sensT2(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-49,40})));
  Components.SensT sensT3(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={49,40})));
  Components.SensT sensT4(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={49,-41})));
  Modelica.Blocks.Math.Add coreDeltaT(k2=-1)
    annotation (Placement(transformation(extent={{-85,25},{-70,40}})));
  ThermoPower3.Water.Flow1D core1(
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    dpnom(displayUnit="kPa") = 1,
    N=5,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    pstart=300000,
    HydraulicCapacitance=ORNL_AdvSMR.Choices.Flow1D.HCtypes.Middle,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Cfnom,
    Cfnom=0.005) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-15,0})));
  Components.LowerPlenum_2o lowerPlenum(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph, checkFlowDirection=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-41,-69})));
  Components.UpperPlenum_2i upperPlenum_2i(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    allowFlowReversal=false,
    checkFlowDirection=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-41,72.5})));
equation
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-74.25,0},{-67,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{74.25,0},{67,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{52.5,1.31839e-015},{61,1.31839e-015},{61,0},{63.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-52.5,4.57967e-016},{-61,4.57967e-016},{-61,0},{-63.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));

  connect(sensT1.outlet, core.infl) annotation (Line(
      points={{-45,-34},{-45,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensT2.inlet, core.outfl) annotation (Line(
      points={{-45,34},{-45,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(header.outlet, sensT3.inlet) annotation (Line(
      points={{10,90},{45,90},{45,46}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensT3.outlet, downcomer.infl) annotation (Line(
      points={{45,34},{45,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, sensT4.inlet) annotation (Line(
      points={{45,-15},{45,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensT4.outlet, primaryPump.infl) annotation (Line(
      points={{45,-47},{45,-88},{28,-88}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensT1.T, coreDeltaT.u2) annotation (Line(
      points={{-55,-32},{-55,-20},{-95,-20},{-95,28},{-86.5,28}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(sensT2.T, coreDeltaT.u1) annotation (Line(
      points={{-55,48},{-55,60},{-95,60},{-95,37},{-86.5,37}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(lowerPlenum.in1, primaryPump.outfl) annotation (Line(
      points={{-41,-75},{-41,-83},{14,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(lowerPlenum.out1, sensT1.inlet) annotation (Line(
      points={{-45,-63},{-45,-46}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(lowerPlenum.out2, core1.infl) annotation (Line(
      points={{-37,-63},{-37,-55},{-15,-55},{-15,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensT2.outlet, upperPlenum_2i.in1) annotation (Line(
      points={{-45,46},{-45,66.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(core1.outfl, upperPlenum_2i.in2) annotation (Line(
      points={{-15,15},{-15,50},{-37,50},{-37,66.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(header.inlet, upperPlenum_2i.out) annotation (Line(
      points={{-10.1,90},{-41,90},{-41,78.5}},
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
      StopTime=20000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths7_pump_expVol_geom2_mult;
