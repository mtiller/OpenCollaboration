within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths7_pumpWorks_PD_expVol_geom2

  Components.ChannelFlow core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    dpnom(displayUnit="kPa") = 1,
    nNodes=5,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_SMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (
          alpha0=5000),
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-35,0})));
  Components.Pump primaryPump(
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    rho0=1950,
    wstart=0.7663,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    usePowerCharacteristic=true,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    w0=1325/(19*19),
    Np0=1,
    n0=1000,
    redeclare function flowCharacteristic =
        ORNL_SMR.Functions.PumpCharacteristics.linearFlow (head_nom={
            0.05,200}, q_nom={1e-4,7}),
    dp0(displayUnit="kPa") = 10000000,
    V=8/(3^3)) annotation (Placement(transformation(extent={{9.5,-77},{
            -10.5,-57}}, rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    N=5,
    L=0.80,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2)) annotation (
      Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-60,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1000,
    offset=125e6/(19*19*4),
    height=125e6/(19*19*40),
    startTime=1000) annotation (Placement(transformation(extent={{-80,-7.5},
            {-65,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow downcomer(
    Cfnom=0.005,
    hstartin=(700 + 273.15)*2380,
    hstartout=(650 + 273.15)*2380,
    rhonom=1950,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    nNodes=5,
    H=-0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={35,0})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    N=5,
    omega=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2)) annotation (
      Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={55,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1000,
    offset=-125e6/(19*19*4),
    height=-125e6/(19*19*40),
    startTime=1000)
    annotation (Placement(transformation(extent={{75,-7.5},{60,7.5}})));
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
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  Components.SensT coreTi(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-39,-40})));
  Components.SensT coreTo(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-39,40})));
  Components.SensT dcTi(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={39,40})));
  Components.SensT dcTo(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={39,-41})));
  Modelica.Blocks.Math.Add coreDeltaT(k2=-1)
    annotation (Placement(transformation(extent={{-80,25},{-65,40}})));
equation
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-64.25,0},{-62,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{59.25,0},{57,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{48.5,-0.075},{41.55,-0.075},{41.55,0},{53.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{-35,-34},{-35,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{-35,-46},{-35,-60},{-6.5,-60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{-35,34},{-35,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.outlet, header.inlet) annotation (Line(
      points={{-35,46},{-35,60},{-10.1,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(header.outlet, dcTi.inlet) annotation (Line(
      points={{10,60},{35,60},{35,46}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTi.outlet, downcomer.infl) annotation (Line(
      points={{35,34},{35,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, dcTo.inlet) annotation (Line(
      points={{35,-15},{35,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{35,-47},{35,-65},{7.5,-65}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.T, coreDeltaT.u2) annotation (Line(
      points={{-45,-32},{-45,-20},{-90,-20},{-90,28},{-81.5,28}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.T, coreDeltaT.u1) annotation (Line(
      points={{-45,48},{-45,60},{-90,60},{-90,37},{-81.5,37}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(heatSource1D.wall, core.wall) annotation (Line(
      points={{-58.5,0},{-48.5,0},{-48.5,7.77156e-016}},
      color={255,127,0},
      smooth=Smooth.None,
      thickness=0.5));
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
      StopTime=5000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths7_pumpWorks_PD_expVol_geom2;
