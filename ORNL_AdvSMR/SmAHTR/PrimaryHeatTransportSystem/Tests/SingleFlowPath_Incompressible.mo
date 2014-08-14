within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model SingleFlowPath_Incompressible

  Components.PipeFlow_incompressible core(
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    rhonom=1950,
    N=4,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible,
    hstartin=4e6,
    hstartout=4e6,
    L=0.80,
    H=0.80,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-50,0})));
  Components.Pump_Incompressible primaryPump(
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    w0=0.7663,
    rho0=1950,
    wstart=0.7663,
    usePowerCharacteristic=true,
    n0=100,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    dp0(displayUnit="kPa") = 15000,
    redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible,
    CheckValve=true,
    V=0.1,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (head_nom=
           {0.05,0.75}, q_nom={1e-4,5e-4})) annotation (Placement(
        transformation(extent={{10,-80},{-10,-60}}, rotation=0)));
  Thermal.HeatSource1D heatIn(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,0})));
  Modelica.Blocks.Sources.Trapezoid heatInFun(
    offset=125e6/(19*24),
    nperiod=1,
    rising=500,
    falling=500,
    startTime=3000,
    amplitude=125e6/(19*24)/10,
    width=5000,
    period=6000) annotation (Placement(transformation(extent={{-95,-7.5},
            {-80,7.5}})));
  inner System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.PipeFlow_incompressible downcomer(
    L=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    H=-0.80,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=1950,
    N=4,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible,
    pstart=100000,
    hstartin=2.25e6,
    hstartout=2.25e6) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={50,0})));
  Thermal.HeatSource1D heatOut(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={70,0})));
  Modelica.Blocks.Sources.Trapezoid heatOutFunc(
    offset=-125e6/(19*24),
    nperiod=1,
    rising=500,
    falling=500,
    amplitude=-125e6/(19*24)/10,
    width=5000,
    startTime=3000,
    period=6000)
    annotation (Placement(transformation(extent={{95,-7.5},{80,7.5}})));
  Components.Header_Incompressible header(
    H=0,
    Cm=2500,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=1000,
    S=100,
    gamma=0.1,
    redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    pstart=100000,
    Tmstart=873.15)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  Modelica.Blocks.Sources.Ramp pumpRpm(
    height=0,
    duration=0,
    startTime=0,
    offset=6)
    annotation (Placement(transformation(extent={{30,-55},{15,-40}})));
  Modelica.Blocks.Sources.IntegerConstant noPumps(k=1) annotation (
      Placement(transformation(extent={{-30,-55},{-15,-40}})));
equation
  connect(heatInFun.y, heatIn.power) annotation (Line(
      points={{-79.25,0},{-77,0},{-77,1.11022e-016},{-72,1.11022e-016}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(heatOutFunc.y, heatOut.power) annotation (Line(
      points={{79.25,0},{72,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.outfl, primaryPump.infl) annotation (Line(
      points={{50,-15},{50,-68},{8,-68}},
      color={0,127,255},
      pattern=LinePattern.None,
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.infl, header.outlet) annotation (Line(
      points={{50,15},{50,60},{10,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(downcomer.wall, heatOut.wall) annotation (Line(
      points={{63.5,-0.075},{66,-0.075},{66,0},{68.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(core.wall, heatIn.wall) annotation (Line(
      points={{-63.5,0.075},{-66,0.075},{-66,0},{-68.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(pumpRpm.y, primaryPump.in_n) annotation (Line(
      points={{14.25,-47.5},{2.6,-47.5},{2.6,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(noPumps.y, primaryPump.in_Np) annotation (Line(
      points={{-14.25,-47.5},{-2.8,-47.5},{-2.8,-62}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(core.infl, primaryPump.outfl) annotation (Line(
      points={{-50,-15},{-50,-63},{-6,-63}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.outfl, header.inlet) annotation (Line(
      points={{-50,15},{-50,60},{-10.1,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
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
end SingleFlowPath_Incompressible;
