within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model MultipleFlowPaths_LowerSplit_UpperJoin

  Components.PipeFlow core(
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    N=4,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    Cfnom=5e-3,
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-55,0})));
  ThermoPower3.Water.Pump primaryPump(
    V=0.01,
    redeclare function powerCharacteristic =
        Functions.PumpCharacteristics.constantPower,
    w0=0.7663,
    rho0=1950,
    wstart=0.7663,
    usePowerCharacteristic=true,
    n0=100,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (head_nom=
           {0.05,0.75}, q_nom={1e-4,5e-4}),
    dp0(displayUnit="kPa") = 15000,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    Np0=2) annotation (Placement(transformation(extent={{20,-80},{0,-60}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-75,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=250,
    duration=250,
    height=0,
    offset=125e6/(19*24*16)) annotation (Placement(transformation(
          extent={{-95,-7.5},{-80,7.5}})));
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
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    dpnom(displayUnit="kPa") = 1,
    pstart=100000,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={45,1.77636e-015})));
  Thermal.HeatSource1D heatSource1D1(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={65,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=250,
    startTime=500,
    height=0,
    offset=-125e6/(19*24*16))
    annotation (Placement(transformation(extent={{90,-7.5},{75,7.5}})));
  Components.Header header(
    H=0,
    Cm=2500,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    V=1000,
    S=100,
    gamma=0.1,
    pstart=100000,
    Tmstart=873.15,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{0,75},{20,95}})));

  Components.FlowSplit lowerPlenum(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph) annotation (Placement(
        transformation(extent={{-2.5,-73},{-22.5,-53}})));
  Components.PipeFlow annulus(
    L=0.80,
    H=0.80,
    omega=0.0173,
    Dhyd=84.0932e-3,
    wnom=0.7663,
    A=3.6326e-4,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    hstartin=(650 + 273.15)*2380,
    hstartout=(700 + 273.15)*2380,
    rhonom=1950,
    N=4,
    dpnom(displayUnit="kPa") = 1,
    redeclare package Medium = ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph,
    allowFlowReversal=false,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    Cfnom=5e-3,
    pstart=300000) annotation (Placement(transformation(
        extent={{-15,15},{15,-15}},
        rotation=90,
        origin={-25,0})));
  Components.UpperPlenum_2i upperPlenum(redeclare package Medium =
        ORNL_SMR.Media.Fluids.LiFBeF2.flibe_ph)
    annotation (Placement(transformation(extent={{-60,35},{-20,75}})));
  Thermal.HeatSource1D heatSource1D2(
    L=0.80,
    omega=0.0173,
    N=4) annotation (Placement(transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={-5,0})));
  Modelica.Blocks.Sources.Ramp ramp2(
    startTime=250,
    duration=250,
    height=0,
    offset=0)
    annotation (Placement(transformation(extent={{15,-7.5},{0,7.5}})));
equation
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-79.25,0},{-77,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D1.power) annotation (Line(
      points={{74.25,0},{67,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(downcomer.outfl, primaryPump.infl) annotation (Line(
      points={{45,-15},{45,-68},{18,-68}},
      color={0,127,255},
      pattern=LinePattern.None,
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.infl, header.outlet) annotation (Line(
      points={{45,15},{45,85},{20,85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(downcomer.wall, heatSource1D1.wall) annotation (Line(
      points={{58.5,-0.075},{61,-0.075},{61,0},{63.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(core.wall, heatSource1D.wall) annotation (Line(
      points={{-68.5,0.075},{-71,0.075},{-71,0},{-73.5,0}},
      color={255,127,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(lowerPlenum.in1, primaryPump.outfl) annotation (Line(
      points={{-6.5,-63},{4,-63}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(lowerPlenum.out2, core.infl) annotation (Line(
      points={{-18.5,-67},{-55,-67},{-55,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(annulus.infl, lowerPlenum.out1) annotation (Line(
      points={{-25,-15},{-25,-59},{-18.5,-59}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None}));
  connect(core.outfl, upperPlenum.in1) annotation (Line(
      points={{-55,15},{-55,39},{-55,63},{-52,63}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None}));
  connect(annulus.outfl, upperPlenum.in2) annotation (Line(
      points={{-25,15},{-25,31},{-25,47},{-52,47}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None}));
  connect(upperPlenum.out, header.inlet) annotation (Line(
      points={{-28,55},{-28,85},{-0.1,85}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(ramp2.y, heatSource1D2.power) annotation (Line(
      points={{-0.75,0},{-3,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource1D2.wall, annulus.wall) annotation (Line(
      points={{-6.5,0},{-9,0},{-9,0.075},{-11.5,0.075}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Text(
                  extent={{-10,2.5},{10,-2.5}},
                  lineColor={0,0,0},
                  textString="Upper Plenum",
                  origin={-62.5,55},
                  rotation=90),Text(
                  extent={{-25,-70},{-5,-75}},
                  lineColor={0,0,0},
                  textString="Lower Plenum")}),
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
end MultipleFlowPaths_LowerSplit_UpperJoin;
