within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model MultipleFlowPaths_LowerSplit_UpperJoin_Incompressible

  Components.PipeFlow_incompressible core(
    L=0.80,
    H=0.80,
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
    hstartin=2.5e6,
    hstartout=2.5e6,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-50,0})));
  Components.Pump_Incompressible primaryPump(
    V=0.01,
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    w0=0.7663,
    rho0=1950,
    wstart=0.7663,
    usePowerCharacteristic=true,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (head_nom=
           {0.05,0.75}, q_nom={1e-4,5e-4}),
    dp0(displayUnit="kPa") = 15000,
    redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible,
    CheckValve=true,
    n0=100) annotation (Placement(transformation(extent={{25,-80},{5,-60}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-70,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=250,
    offset=125e6/(19*24*4),
    duration=500,
    height=0) annotation (Placement(transformation(extent={{-95,-7.5},{
            -80,7.5}})));
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
    hstartin=2.25e6,
    hstartout=2.25e6,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    pstart=100000) annotation (Placement(transformation(
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
    offset=-125e6/(19*24*4),
    startTime=250,
    duration=500,
    height=0)
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
    annotation (Placement(transformation(extent={{5,50},{25,70}})));

  Components.FlowSplit flowSplit(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible)
    annotation (Placement(transformation(extent={{0,-73},{-20,-53}})));
  Components.PipeFlow_incompressible annulus(
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    Cfnom=0.005,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    rhonom=1950,
    N=4,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible,
    hstartin=2.5e6,
    hstartout=2.5e6,
    pstart=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit)
                                                  annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-25,0})));
  Components.FlowJoin flowJoin(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_incompressible)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    duration=250,
    offset=100,
    startTime=250,
    height=0)
    annotation (Placement(transformation(extent={{40,-50},{30,-40}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=2)
    annotation (Placement(transformation(extent={{-10,-50},{0,-40}})));
equation
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-79.25,0},{-77,0},{-77,1.11022e-016},{-72,1.11022e-016}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{79.25,0},{72,0}},
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
  connect(flowSplit.in1, primaryPump.outfl) annotation (Line(
      points={{-4,-63},{9,-63}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit.out2, core.infl) annotation (Line(
      points={{-16,-67},{-50,-67},{-50,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(annulus.infl, flowSplit.out1) annotation (Line(
      points={{-25,-15},{-25,-59},{-16,-59}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None}));
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
  connect(ramp3.y, primaryPump.in_n) annotation (Line(
      points={{29.5,-45},{17.6,-45},{17.6,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integerConstant.y, primaryPump.in_Np) annotation (Line(
      points={{0.5,-45},{12.2,-45},{12.2,-62}},
      color={255,127,0},
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
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end MultipleFlowPaths_LowerSplit_UpperJoin_Incompressible;
