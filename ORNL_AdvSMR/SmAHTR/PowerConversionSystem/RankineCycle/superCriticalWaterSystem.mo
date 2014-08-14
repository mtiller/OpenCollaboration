within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.RankineCycle;
model superCriticalWaterSystem

  parameter Boolean SSInit=false "Steady-state initialization";

  SteamTurbines.SteamTurbineStodola steamTurbineStodola(
    PRstart=1,
    redeclare package Medium = ORNL_SMR.StandardWater,
    explicitIsentropicEnthalpy=true,
    wnom=144,
    wstart=150,
    Kt=3.2252e-003,
    pnom=23500000)
    annotation (Placement(transformation(extent={{-60,40},{-20,80}})));
  inner System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Components.SourceP sourceP(
    h=3167.3e3,
    allowFlowReversal=false,
    redeclare package Medium = ORNL_SMR.StandardWater,
    p0=23500000)
    annotation (Placement(transformation(extent={{-90,66},{-70,86}})));
  ElectricGeneratorGroup.Examples.GeneratorGroup_wBreaker
    generatorGroup_wBreaker(
    eta=0.9,
    J_shaft=15000,
    SSInit=SSInit,
    fn=50,
    d_shaft=250,
    Pmax=125e6,
    delta_start=0.7)
    annotation (Placement(transformation(extent={{20,40},{60,80}})));

  Components.SinkP sinkP(
    allowFlowReversal=false,
    redeclare package Medium = ORNL_SMR.StandardWater,
    h=2290.3e3,
    p0=600000)
    annotation (Placement(transformation(extent={{55,-65},{75,-45}})));
  CondenserGroup.CondPlant_cc controlledCondenser(
    Vtot=10,
    Vlstart=1.5,
    setPoint_ratio=0.85,
    redeclare package FluidMedium = ORNL_SMR.StandardWater,
    SSInit=SSInit,
    p=5398.2) annotation (Placement(transformation(extent={{-30,-30},{
            30,30}}, rotation=0)));
  ThermoPower3.PowerPlants.HRSG.Components.PrescribedSpeedPump
    totalFeedPump(
    q_nom={0.0898,0,0.1},
    head_nom={72.74,130,0},
    redeclare package WaterMedium = ORNL_SMR.StandardWater,
    SSInit=SSInit,
    rho0=1000,
    nominalFlow=144,
    n0=1000,
    Np0=1,
    V=1.5,
    nominalOutletPressure=600000,
    nominalInletPressure=5398.2) annotation (Placement(transformation(
        origin={32.5,-55},
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=180)));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{5,-50},{20,-35}})));
  Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{90,-15},{100,-5}})));
  Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{90,5},{100,15}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=400,
      startValue=true)
    annotation (Placement(transformation(extent={{85,55},{70,70}})));
equation
  connect(steamTurbineStodola.shaft_b, generatorGroup_wBreaker.shaft)
    annotation (Line(
      points={{-27.2,60},{20,60}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(steamTurbineStodola.inlet, sourceP.flange) annotation (Line(
      points={{-56,76},{-70,76}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamTurbineStodola.outlet, controlledCondenser.SteamIn)
    annotation (Line(
      points={{-24,76},{0,76},{0,30}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkP.flange, totalFeedPump.outlet) annotation (Line(
      points={{55,-55},{40,-55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(controlledCondenser.WaterOut, totalFeedPump.inlet)
    annotation (Line(
      points={{0,-30},{0,-55},{25,-55}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(const.y, totalFeedPump.pumpSpeed_rpm) annotation (Line(
      points={{20.75,-42.5},{22.5,-42.5},{22.5,-50.5},{27.1,-50.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensors, generatorGroup_wBreaker.SensorsBus) annotation (Line(
      points={{95,10},{85,10},{85,52},{60,52}},
      color={255,170,213},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(booleanStep.y, generatorGroup_wBreaker.u) annotation (Line(
      points={{69.25,62.5},{65,62.5},{65,65},{60,65}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(generatorGroup_wBreaker.ActuatorsBus, actuators) annotation (
      Line(
      points={{60,46},{80,46},{80,-10},{95,-10}},
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
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-007,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end superCriticalWaterSystem;
