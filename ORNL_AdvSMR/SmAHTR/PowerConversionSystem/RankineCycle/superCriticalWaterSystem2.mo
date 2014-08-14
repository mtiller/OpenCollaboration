within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.RankineCycle;
model superCriticalWaterSystem2

  parameter Boolean SSInit=false "Steady-state initialization";

  SteamTurbines.SteamTurbineStodola steamTurbineStodola(
    wstart=1722.47,
    allowFlowReversal=false,
    wnom=1722.47,
    PRstart=235/0.05,
    Kt=0.0387025,
    explicitIsentropicEnthalpy=false,
    pnom=23500000)
    annotation (Placement(transformation(extent={{-50,35},{-10,75}})));
  inner System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Components.SourceP sourceP(
    redeclare package Medium = ORNL_SMR.StandardWater,
    h=3167.3e3,
    allowFlowReversal=false,
    p0=23500000)
    annotation (Placement(transformation(extent={{-90,61},{-70,81}})));

  Components.SinkP sinkP(
    redeclare package Medium = ORNL_SMR.StandardWater,
    allowFlowReversal=false,
    h=2290.3e3,
    p0=5398.2)
    annotation (Placement(transformation(extent={{55,-65},{75,-45}})));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.CondPlant_cc
    controlledCondeser(
    Vtot=10,
    Vlstart=1.5,
    setPoint_ratio=0.85,
    redeclare package FluidMedium = ORNL_SMR.StandardWater,
    SSInit=SSInit,
    p=5398.2) annotation (Placement(transformation(extent={{-30,-30},{
            30,30}}, rotation=0)));
  ThermoPower3.PowerPlants.HRSG.Components.PrescribedSpeedPump
    totalFeedPump(
    rho0=1000,
    q_nom={0.0898,0,0.1},
    head_nom={72.74,130,0},
    nominalFlow=89.8,
    n0=1500,
    redeclare package WaterMedium = ORNL_SMR.StandardWater,
    nominalOutletPressure=600000,
    nominalInletPressure=5398.2) annotation (Placement(transformation(
        origin={32.5,-55},
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=180)));
  Modelica.Blocks.Sources.Constant const(k=1500)
    annotation (Placement(transformation(extent={{5,-50},{20,-35}})));
  Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{90,-15},{100,-5}})));
  Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{90,5},{100,15}})));
  ElectricGeneratorGroup.Examples.GeneratorGroup_wBreaker
    generatorGroup_wBreaker(
    eta=0.9,
    J_shaft=15000,
    SSInit=SSInit,
    fn=50,
    d_shaft=250,
    Pmax=125e6,
    delta_start=0.7)
    annotation (Placement(transformation(extent={{30,45},{70,85}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=400,
      startValue=true)
    annotation (Placement(transformation(extent={{95,60},{80,75}})));
equation
  connect(steamTurbineStodola.inlet, sourceP.flange) annotation (Line(
      points={{-46,71},{-70,71}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamTurbineStodola.outlet, controlledCondeser.SteamIn)
    annotation (Line(
      points={{-14,71},{0,71},{0,30}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkP.flange, totalFeedPump.outlet) annotation (Line(
      points={{55,-55},{40,-55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(controlledCondeser.WaterOut, totalFeedPump.inlet) annotation (
     Line(
      points={{0,-30},{0,-55},{25,-55}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(const.y, totalFeedPump.pumpSpeed_rpm) annotation (Line(
      points={{20.75,-42.5},{22.5,-42.5},{22.5,-50.5},{27.1,-50.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(controlledCondeser.SensorsBus, sensors) annotation (Line(
      points={{29.4,-12},{70,-12},{70,10},{95,10}},
      color={255,170,213},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(actuators, controlledCondeser.ActuatorsBus) annotation (Line(
      points={{95,-10},{75,-10},{75,-21.6},{29.4,-21.6}},
      color={213,255,170},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(steamTurbineStodola.shaft_b, generatorGroup_wBreaker.shaft)
    annotation (Line(
      points={{-17.2,55},{6.4,55},{6.4,65},{30,65}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(sensors, generatorGroup_wBreaker.SensorsBus) annotation (Line(
      points={{95,10},{95,57},{70,57}},
      color={255,170,213},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(booleanStep.y, generatorGroup_wBreaker.u) annotation (Line(
      points={{79.25,67.5},{75,67.5},{75,70},{70,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(generatorGroup_wBreaker.ActuatorsBus, actuators) annotation (
      Line(
      points={{70,51},{90,51},{90,-10},{95,-10}},
      color={213,255,170},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end superCriticalWaterSystem2;
