within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model MultipleFlowPaths_LowerPlenum_UpperPlenum

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
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    N=4,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 1,
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-50,0})));
  ThermoPower3.Water.Pump primaryPump(
    V=0.01,
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    Np0=1,
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
    dp0(displayUnit="kPa") = 15000) annotation (Placement(
        transformation(extent={{25,-80},{5,-60}}, rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=250,
    height=125e6/(19*24*4),
    offset=125e6/(19*24*4),
    duration=250) annotation (Placement(transformation(extent={{-90,-7.5},
            {-75,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
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
    N=4,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    dpnom(displayUnit="kPa") = 1,
    pstart=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState)
                                                       annotation (
      Placement(transformation(
        extent={{15,15},{-15,-15}},
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
    height=-125e6/(19*24*4),
    offset=-125e6/(19*24*4),
    duration=250,
    startTime=300)
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
    annotation (Placement(transformation(extent={{5,50},{25,70}})));

  Components.PipeFlow annulus(
    L=0.80,
    H=0.80,
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
    N=4,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 1,
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-25,0})));
  Components.FlowJoin flowJoin(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Components.ClosedVolume lowerPlenum(
    nPorts=3,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    V=1000,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=84.0932e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        84.0932e-3),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=84.0932e-3)},
    m_flow_small=0.01,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_portsData=false,
    p_start=100000,
    T_start=923.15) annotation (Placement(transformation(extent={{-15,-70},
            {-35,-90}})));
equation
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-74.25,0},{-72,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{74.25,0},{72,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.outfl, primaryPump.infl) annotation (Line(
      points={{50,-15},{50,-68},{23,-68}},
      color={0,127,255},
      pattern=LinePattern.None,
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.infl, header.outlet) annotation (Line(
      points={{50,15},{50,60},{25,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{63.5,-0.075},{66,-0.075},{66,0},{68.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-63.5,0.075},{-66,0.075},{-66,0},{-68.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(flowJoin.out, header.inlet) annotation (Line(
      points={{-4,60},{4.9,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(core.outfl, flowJoin.in1) annotation (Line(
      points={{-50,15},{-50,64},{-16,64}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None}));
  connect(annulus.outfl, flowJoin.in2) annotation (Line(
      points={{-25,15},{-25,56},{-16,56}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None}));
  connect(lowerPlenum.ports[1], primaryPump.outfl) annotation (Line(
      points={{-22.3333,-70},{-22.3333,-63},{9,-63}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(annulus.infl, lowerPlenum.ports[2]) annotation (Line(
      points={{-25,-15},{-25,-70}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(core.infl, lowerPlenum.ports[3]) annotation (Line(
      points={{-50,-15},{-50,-65.5},{-27.6667,-65.5},{-27.6667,-70}},
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
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end MultipleFlowPaths_LowerPlenum_UpperPlenum;
