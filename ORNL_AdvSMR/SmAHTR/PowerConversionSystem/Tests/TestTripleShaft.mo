within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.Tests;
model TestTripleShaft

protected
  ThermoPower3.PowerPlants.Buses.Sensors sensors annotation (Placement(
        transformation(
        origin={75,45},
        extent={{-5,-5},{5,5}},
        rotation=180)));
  ThermoPower3.PowerPlants.Buses.Actuators actuators annotation (
      Placement(transformation(extent={{70,-70},{80,-60}}, rotation=0)));
public
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{20,-98},{40,-78}},
          rotation=0)));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.TripleShaft_static
    tripleShaft(
    Pn=50e8,
    J_shaft_A=2000,
    J_shaft_B=2000,
    J_shaft_C=2000,
    omega_nom_A=314.16/2,
    omega_nom_B=314.16/2,
    omega_nom_C=314.16/2,
    SSInit=true) annotation (Placement(transformation(extent={{0,-50},{
            80,30}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola Turbine1(
    wstart=70.59,
    wnom=70.59,
    Kt=0.00307,
    eta_iso_nom=0.83,
    PRstart=5,
    pnom=12800000) annotation (Placement(transformation(extent={{-80,30},
            {-40,70}}, rotation=0)));
  ThermoPower3.Water.SourceW sourceW1(
    h=3.47e6,
    w0=67.6,
    p0=12800000) annotation (Placement(transformation(extent={{-90,40},
            {-80,50}}, rotation=0)));
  ThermoPower3.Water.SinkP sinkP1(h=3.1076e6, p0=2980000) annotation (
      Placement(transformation(extent={{-40,80},{-30,90}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola Turbine2(
    eta_iso_nom=0.9,
    Kt=0.01478,
    wstart=81.1,
    wnom=81.1,
    PRstart=5,
    pnom=2700000) annotation (Placement(transformation(extent={{-80,-30},
            {-40,10}}, rotation=0)));
  ThermoPower3.Water.SourceW sourceW2(
    h=3.554e6,
    w0=81.1,
    p0=2700000) annotation (Placement(transformation(extent={{-90,20},{
            -80,30}}, rotation=0)));
  ThermoPower3.Water.SinkP sinkP2(h=3.128e6, p0=600000) annotation (
      Placement(transformation(extent={{-40,20},{-30,30}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola Turbine3(
    wstart=89.82,
    wnom=89.82,
    Kt=0.0769,
    PRstart=5,
    pnom=600000) annotation (Placement(transformation(extent={{-80,-90},
            {-40,-50}}, rotation=0)));
  ThermoPower3.Water.SourceW sourceW3(
    h=3.109e6,
    w0=89.82,
    p0=600000) annotation (Placement(transformation(extent={{-90,-40},{
            -80,-30}}, rotation=0)));
  ThermoPower3.Water.SinkP sinkP3(h=2.3854, p0=5398.2) annotation (
      Placement(transformation(extent={{-40,-40},{-30,-30}}, rotation=0)));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=10,
    offset=67.6,
    startTime=10,
    height=-6.76) annotation (Placement(transformation(extent={{-110,80},
            {-100,90}})));
equation
  connect(tripleShaft.SensorsBus, sensors) annotation (Line(points={{80,
          -26},{90,-26},{90,45},{75,45}}, color={255,170,213}));
  connect(actuators, tripleShaft.ActuatorsBus) annotation (Line(points=
          {{75,-65},{90,-65},{90,-38},{80,-38}}, color={213,255,170}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftA)
    annotation (Line(points={{41,-88},{60,-88},{60,-65},{75,-65}},
        color={255,0,255}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftB)
    annotation (Line(points={{41,-88},{55,-88},{55,-65},{75,-65}},
        color={255,0,255}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftC)
    annotation (Line(points={{41,-88},{50,-88},{50,-65},{75,-65}},
        color={255,0,255}));
  connect(sourceW1.flange, Turbine1.inlet) annotation (Line(
      points={{-80,45},{-76,45},{-76,66}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP1.flange, Turbine1.outlet) annotation (Line(
      points={{-40,85},{-44,85},{-44,66}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourceW2.flange, Turbine2.inlet) annotation (Line(
      points={{-80,25},{-76,25},{-76,6}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP2.flange, Turbine2.outlet) annotation (Line(
      points={{-40,25},{-44,25},{-44,6}},
      thickness=0.5,
      color={0,0,255}));
  connect(Turbine1.shaft_b, tripleShaft.shaft_A) annotation (Line(
      points={{-47.2,50},{-20,50},{-20,14},{0,14}},
      color={0,0,0},
      thickness=0.5));
  connect(Turbine2.shaft_b, tripleShaft.shaft_B) annotation (Line(
      points={{-47.2,-10},{0,-10}},
      color={0,0,0},
      thickness=1));
  connect(sourceW3.flange, Turbine3.inlet) annotation (Line(
      points={{-80,-35},{-76,-35},{-76,-54}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP3.flange, Turbine3.outlet) annotation (Line(
      points={{-40,-35},{-44,-35},{-44,-54}},
      thickness=0.5,
      color={0,0,255}));
  connect(Turbine3.shaft_b, tripleShaft.shaft_C) annotation (Line(
      points={{-47.2,-70},{-20,-70},{-20,-34},{0,-34}},
      color={0,0,0},
      thickness=0.5));
  connect(ramp.y, sourceW1.in_w0) annotation (Line(
      points={{-99.5,85},{-96,85},{-96,48},{-87,48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-120,-100},{120,100}},
        grid={1,1}), graphics),
    experiment(StopTime=60, NumberOfIntervals=6000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-120,-100},{120,100}},
        grid={1,1})));
end TestTripleShaft;
