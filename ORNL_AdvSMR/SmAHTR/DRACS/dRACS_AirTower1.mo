within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_AirTower1
  package FlueGasMedium = ThermoPower3.Media.FlueGas;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  //gas
  parameter Modelica.SIunits.MassFlowRate gasNomFlowRate=585.5
    "Nominal mass flowrate";
  parameter Modelica.SIunits.Temperature Tstart_G_In=747.15
    "Inlet gas temperature start value";
  parameter Modelica.SIunits.Temperature Tstart_G_Out=620.3
    "Outlet gas temperature start value";

  //fluid
  parameter Modelica.SIunits.MassFlowRate fluidNomFlowRate=175.5
    "Nominal flow rate through the fluid side";
  parameter Modelica.SIunits.Pressure fluidNomPressure=137.1e5
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
  parameter Modelica.SIunits.SpecificEnthalpy hstart_F_In=1.514e6
    "Nominal specific enthalpy";
  parameter Modelica.SIunits.SpecificEnthalpy hstart_F_Out=2.002e6
    "Nominal specific enthalpy";

  ThermoPower3.PowerPlants.HRSG.Components.HE2ph hE(
    redeclare package FluidMedium = FluidMedium,
    redeclare package FlueGasMedium = FlueGasMedium,
    N_G=4,
    N_F=4,
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
    SSInit=SSInit) annotation (Placement(transformation(extent={{-20,-20},
            {20,20}}, rotation=0)));
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
        origin={0,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Water.SinkP sinkP_water(
    redeclare package Medium = FluidMedium,
    p0=fluidNomPressure,
    h=hstart_F_Out) annotation (Placement(transformation(
        origin={0,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Gas.SinkP sinkP_gas(redeclare package Medium =
        FlueGasMedium, T=Tstart_G_Out) annotation (Placement(
        transformation(extent={{60,-10},{80,10}}, rotation=0)));
  ThermoPower3.Gas.SourceW sourceW_gas(
    redeclare package Medium = FlueGasMedium,
    w0=gasNomFlowRate,
    T=Tstart_G_In) annotation (Placement(transformation(extent={{-70,-10},
            {-50,10}}, rotation=0)));
  ThermoPower3.Water.SensT T_waterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(
        origin={4,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Gas.SensT T_gasOut(redeclare package Medium =
        FlueGasMedium) annotation (Placement(transformation(extent={{30,-6},
            {50,14}}, rotation=0)));
  Modelica.Blocks.Sources.Step step(
    height=-fluidNomFlowRate/2,
    offset=fluidNomFlowRate,
    startTime=3600)
    annotation (Placement(transformation(extent={{40,60},{20,80}})));
initial equation
  hstart_F_Out = hE.waterOut.h_outflow;

equation
  connect(T_gasOut.inlet, hE.gasOut) annotation (Line(
      points={{34,0},{34,0},{20,0}},
      color={159,159,223},
      thickness=0.5));
  connect(T_gasOut.outlet, sinkP_gas.flange) annotation (Line(
      points={{46,0},{46,0},{60,0}},
      color={159,159,223},
      thickness=0.5));
  connect(sinkP_water.flange, T_waterOut.outlet) annotation (Line(
      points={{1.83697e-015,-70},{1.83697e-015,-56},{-8.88178e-016,-56}},
      thickness=0.5,
      color={0,0,255}));

  connect(T_waterOut.inlet, hE.waterOut) annotation (Line(
      points={{8.88178e-016,-44},{8.88178e-016,-20},{0,-20}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourseW_water.flange, hE.waterIn) annotation (Line(
      points={{-1.83697e-015,50},{-1.83697e-015,20},{0,20}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sourceW_gas.flange, hE.gasIn) annotation (Line(
      points={{-50,0},{-20,0}},
      color={159,159,223},
      thickness=0.5,
      smooth=Smooth.None));
  connect(step.y, sourseW_water.in_w0) annotation (Line(
      points={{19,70},{14,70},{14,64},{6,64}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
            {{-100,-100},{100,100}}), graphics));
end dRACS_AirTower1;
