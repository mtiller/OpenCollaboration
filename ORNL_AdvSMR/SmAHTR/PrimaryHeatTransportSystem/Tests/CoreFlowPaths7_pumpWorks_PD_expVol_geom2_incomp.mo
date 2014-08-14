within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths7_pumpWorks_PD_expVol_geom2_incomp

  Components.PipeFlow_incompressible core(
    Cfnom=0.005,
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
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-45,0})));
  Components.Pump_Incompressible primaryPump(
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    rho0=1950,
    wstart=0.7663,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    usePowerCharacteristic=true,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    dp0(displayUnit="kPa") = 15000,
    w0=1325/(19*19),
    V=0.008,
    Np0=1,
    n0=1000,
    redeclare function flowCharacteristic =
        ORNL_SMR.Functions.PumpCharacteristics.linearFlow (q_nom={1e-4,
            10}, head_nom={0.05,250})) annotation (Placement(
        transformation(extent={{9.5,-77},{-10.5,-57}}, rotation=0)));
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
    height=125e6/(19*19*40)) annotation (Placement(transformation(
          extent={{-90,-7.5},{-75,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow_incompressible downcomer(
    Cfnom=0.005,
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
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    wnom=1325/(19*19),
    pstart=100000) annotation (Placement(transformation(
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
    height=-125e6/(19*19*40))
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));
  Components.Header_Incompressible header(
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

equation
  connect(primaryPump.outfl, core.infl) annotation (Line(
      points={{-6.5,-60},{-45,-60},{-45,-15}},
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
      points={{45,-15},{45,-65},{7.5,-65}},
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
      points={{52.5,0.075},{61,0.075},{61,0},{63.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-52.5,-0.075},{-61,-0.075},{-61,0},{-63.5,0}},
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
      StopTime=20000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end CoreFlowPaths7_pumpWorks_PD_expVol_geom2_incomp;
