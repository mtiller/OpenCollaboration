within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_AirTower3
  package FlueGasMedium = Modelica.Media.Air.DryAirNasa;
  package FluidMedium = ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_ph;
  //ThermoPower3.Water.StandardWater;

  //gas
  parameter Modelica.SIunits.MassFlowRate gasNomFlowRate=20
    "Nominal mass flowrate";
  parameter Modelica.SIunits.Temperature Tstart_G_In=25 + 273.15
    "Inlet air temperature start value";
  parameter Modelica.SIunits.Temperature Tstart_G_Out=475 + 273.15
    "Outlet air temperature start value";

  //fluid
  parameter Modelica.SIunits.MassFlowRate fluidNomFlowRate=200
    "Nominal flow rate through the fluid side";
  parameter Modelica.SIunits.Pressure fluidNomPressure=1.01325e7
    "Nominal pressure in the fluid side inlet";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_G(fixed=
        false) = 40 "Constant heat transfer coefficient in the gas side";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_F=4000
    "Constant heat transfer coefficient in the fluid side";
  parameter Modelica.SIunits.Temperature Tstart_M_In=Tstart_F_In
    "Inlet metal wall temperature start value";
  parameter Modelica.SIunits.Temperature Tstart_M_Out=Tstart_F_Out
    "Outlet metal wall temperature start value";
  parameter Modelica.SIunits.Temperature Tstart_F_In=
      FluidMedium.temperature_ph(fluidNomPressure, hstart_F_In)
    "Inlet fluid temperature start value";
  parameter Modelica.SIunits.Temperature Tstart_F_Out=
      FluidMedium.temperature_ph(fluidNomPressure, hstart_F_Out)
    "Outlet fluid temperature start value";
  parameter Modelica.SIunits.SpecificEnthalpy hstart_F_In=4.514e6
    "Nominal specific enthalpy";
  parameter Modelica.SIunits.SpecificEnthalpy hstart_F_Out=2.002e6
    "Nominal specific enthalpy";

  ThermoPower3.PowerPlants.HRSG.Components.HE2ph hE(
    redeclare package FluidMedium = FluidMedium,
    redeclare package FlueGasMedium = FlueGasMedium,
    exchSurface_G=30501.9,
    exchSurface_F=2296.328,
    extSurfaceTub=2704.564,
    gasVol=10,
    fluidVol=15.500,
    metalVol=6.001,
    rhomcm=7900*612.58,
    lambda=20,
    gasNomFlowRate=585.5,
    gasNomPressure=0,
    fluidNomFlowRate=fluidNomFlowRate,
    fluidNomPressure=fluidNomPressure,
    gamma_G=gamma_G,
    gamma_F=gamma_F,
    Tstartbar_G=Tstart_G,
    Tstartbar_M=Tstart_M,
    SSInit=SSInit,
    N_G=16,
    N_F=16) annotation (Placement(transformation(extent={{-30,-20},{10,20}},
          rotation=0)));
  //Start value
  parameter Modelica.SIunits.Temperature Tstart_G=(Tstart_G_In +
      Tstart_G_Out)/2;
  parameter Modelica.SIunits.Temperature Tstart_M=(Tstart_M_In +
      Tstart_M_Out)/2;
  parameter Boolean SSInit=true "Steady-state initialization";
  inner ThermoPower3.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SourceW sourseW_water(
    redeclare package Medium = FluidMedium,
    w0=fluidNomFlowRate,
    p0=fluidNomPressure,
    h=hstart_F_In) annotation (Placement(transformation(
        origin={-10,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Water.SinkP sinkP_water(
    redeclare package Medium = FluidMedium,
    p0=fluidNomPressure,
    h=hstart_F_Out) annotation (Placement(transformation(
        origin={-10,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Gas.SinkP sinkP_gas(
    redeclare package Medium = FlueGasMedium,
    T=Tstart_G_Out,
    p0=101325) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,70})));
  ThermoPower3.Water.SensT T_waterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(
        origin={-6,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Gas.SensT T_gasOut(redeclare package Medium =
        FlueGasMedium) annotation (Placement(transformation(extent={{20,-6},
            {40,14}}, rotation=0)));
  ThermoPower3.Gas.Flow1D flow1D(
    redeclare package Medium = FlueGasMedium,
    Nt=1,
    L=25,
    H=-25,
    A=Modelica.Constants.pi*4.37^2/4,
    omega=Modelica.Constants.pi*4.37,
    Dhyd=4.37,
    wnom=25,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    N=25,
    Cfnom=1e-3,
    DynamicMomentum=true,
    UniformComposition=true,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    dpnom=1013.25) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,30})));
  ThermoPower3.Gas.SourceW sourceW_gas(
    redeclare package Medium = FlueGasMedium,
    T=Tstart_G_In,
    allowFlowReversal=false,
    w0=gasNomFlowRate) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,70})));
  ThermoPower3.Thermal.HeatSource1D heatSource1D(
    L=25,
    omega=Modelica.Constants.pi*4.37,
    N=25) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-70,30})));
  Modelica.Blocks.Sources.Step step(
    height=0,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.Step step1(
    offset=fluidNomFlowRate,
    startTime=900,
    height=-2/4*fluidNomFlowRate)
    annotation (Placement(transformation(extent={{30,60},{10,80}})));
  ThermoPower3.Gas.Flow1D flow1D1(
    redeclare package Medium = FlueGasMedium,
    Nt=1,
    L=25,
    A=Modelica.Constants.pi*4.37^2/4,
    omega=Modelica.Constants.pi*4.37,
    Dhyd=4.37,
    wnom=25,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    N=25,
    Cfnom=1e-3,
    DynamicMomentum=true,
    UniformComposition=true,
    H=25,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    dpnom=1013.25) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,30})));
  ThermoPower3.Thermal.HeatSource1D heatSource1D1(
    L=25,
    omega=Modelica.Constants.pi*4.37,
    N=25) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));
  Modelica.Blocks.Sources.Step step2(
    height=0,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
initial equation
  hstart_F_Out = hE.waterOut.h_outflow;

equation
  connect(T_gasOut.inlet, hE.gasOut) annotation (Line(
      points={{24,0},{24,0},{10,0}},
      color={159,159,223},
      thickness=1));
  connect(sinkP_water.flange, T_waterOut.outlet) annotation (Line(
      points={{-10,-70},{-10,-56}},
      thickness=0.5,
      color={0,0,255}));

  connect(T_waterOut.inlet, hE.waterOut) annotation (Line(
      points={{-10,-44},{-10,-20}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourseW_water.flange, hE.waterIn) annotation (Line(
      points={{-10,50},{-10,20}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(flow1D.outfl, hE.gasIn) annotation (Line(
      points={{-50,20},{-50,0},{-30,0}},
      color={159,159,223},
      smooth=Smooth.None,
      thickness=1));
  connect(sourceW_gas.flange, flow1D.infl) annotation (Line(
      points={{-50,60},{-50,40}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  connect(heatSource1D.wall, flow1D.wall) annotation (Line(
      points={{-67,30},{-55,30}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(step.y, heatSource1D.power) annotation (Line(
      points={{-79,40},{-77,40},{-77,30},{-74,30}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(step1.y, sourseW_water.in_w0) annotation (Line(
      points={{9,70},{4,70},{4,64},{-4,64}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D1.outfl, sinkP_gas.flange) annotation (Line(
      points={{50,40},{50,60}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  connect(T_gasOut.outlet, flow1D1.infl) annotation (Line(
      points={{36,0},{50,0},{50,20}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D1.wall, heatSource1D1.wall) annotation (Line(
      points={{55,30},{67,30}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(step2.y, heatSource1D1.power) annotation (Line(
      points={{79,40},{77,40},{77,30},{74,30}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
    experiment,
    __Dymola_experimentSetupOutput);
end dRACS_AirTower3;
