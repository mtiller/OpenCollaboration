within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model CoreFlowPaths_2models

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
        origin={-20,-30})));
  Components.SourceW sourceW(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    w0=0.7663,
    p0=101325,
    h=(650 + 273.15)*2380) annotation (Placement(transformation(extent=
            {{-90,-90},{-70,-70}})));
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
        transformation(extent={{-47,-92},{-27,-72}}, rotation=0)));
  Components.SinkP sinkP(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,80})));
  Thermal.HeatSource1D heatSource1D(
    N=20,
    L=0.80,
    omega=0.0173) annotation (Placement(transformation(
        extent={{-20,-10},{20,10}},
        rotation=90,
        origin={-60,-30})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=100,
    offset=125e6/(19*72),
    startTime=500,
    height=1e4) annotation (Placement(transformation(extent={{-100,-40},
            {-80,-20}})));
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
        origin={-20,30})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    length=0.80,
    diameter=8.40932e-2,
    height_ab=0.80,
    m_flow_start=0.5,
    useLumpedPressure=true,
    useInnerPortProperties=true,
    nNodes=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=100000,
    p_b_start=100000,
    T_start=973.15) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={70,0})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    N_nominal=1000,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearFlow (
         V_flow_nominal={0.001,0.0015}, head_nominal={30,0}),
    rho_nominal=2200,
    p_a_start=100000,
    p_b_start=100000,
    m_flow_start=0.5,
    T_start=923.15)
    annotation (Placement(transformation(extent={{40,-85},{60,-65}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    m_flow=0.7663,
    T=923.15)
    annotation (Placement(transformation(extent={{5,-85},{25,-65}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    p=100000,
    T=973.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,80})));
equation
  connect(sourceW.flange, Pump1.infl) annotation (Line(
      points={{-70,-80},{-45,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-38,-29.9},{-47.5,-29.9},{-47.5,-30},{-57,-30}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-79,-30},{-64,-30}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(pressDrop.outlet, sinkP.flange) annotation (Line(
      points={{-20,50},{-20,70}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(Pump1.outfl, core.infl) annotation (Line(
      points={{-31,-75},{-20,-75},{-20,-50}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(core.outfl, pressDrop.inlet) annotation (Line(
      points={{-20,-10},{-20,10}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(pump.port_b, pipe.port_a) annotation (Line(
      points={{60,-75},{70,-75},{70,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.ports[1], pump.port_a) annotation (Line(
      points={{25,-75},{40,-75}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(boundary1.ports[1], pipe.port_b) annotation (Line(
      points={{70,70},{70,20}},
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
end CoreFlowPaths_2models;
