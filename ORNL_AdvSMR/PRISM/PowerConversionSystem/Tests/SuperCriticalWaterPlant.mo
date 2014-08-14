within ORNL_AdvSMR.PRISM.PowerConversionSystem.Tests;
model SuperCriticalWaterPlant
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.Components.FourStageTurbinewithSteamExtraction
    fourStageTurbinewithSteamExtraction(
    PRstart=20,
    Kt=0.005,
    wstart=1722.47,
    explicitIsentropicEnthalpy=true,
    allowFlowReversal=false,
    w_tap1=265.4,
    w_tap2=127.38,
    w_tap3=75.74,
    pnom=23500000,
    wnom=1722.47,
    p_nom2=7000000,
    p_nom3=4500000,
    p_nom4=2300000)
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));

  inner ORNL_AdvSMR.System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{100,80},{121,100}})));
  ORNL_AdvSMR.Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{80,30},{90,40}})));
  ORNL_AdvSMR.Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{80,-40},{90,-30}})));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup.CondPlant_cc
    condPlant_cc(
    setPoint_ratio=0.85,
    SSInit=false,
    p=5000,
    Vtot=1000,
    Vlstart=150)
    annotation (Placement(transformation(extent={{-20,-70},{20,-30}})));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.SingleShaft_static
    singleShaft_static(
    Pn=5000e6,
    eta=0.9,
    J_shaft=100,
    omega_nom=314.16/2,
    SSInit=true)
    annotation (Placement(transformation(extent={{50,-20},{90,20}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed shaftSpeed(w_fixed=314.16
        /2, useSupport=false) annotation (Placement(transformation(extent={{-110,
            -5},{-100,5}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW(
    w0=1722.47,
    h=3167.3e3,
    p0=23500000)
    annotation (Placement(transformation(extent={{-70,30},{-60,40}})));
  ORNL_AdvSMR.Components.SinkW sinkW(w0=265.4, p0=7000000) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-65,-25})));
  ORNL_AdvSMR.Components.SinkW sinkW1(w0=127.38, p0=4500000) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-55,-35})));
  ORNL_AdvSMR.Components.SinkW sinkW2(
    h=138.8e3,
    w0=782.74,
    p0=5000) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-15,-85})));
  ORNL_AdvSMR.Components.SinkW sinkW3(w0=75.74, p0=2300000) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-45,-45})));
  Modelica.Blocks.Sources.Ramp steamInlet(
    height=-1722.47/2,
    duration=100,
    offset=1722.47,
    startTime=100)
    annotation (Placement(transformation(extent={{-90,50},{-80,60}})));
  Modelica.Blocks.Sources.BooleanConstant breakerSwitch(k=false)
    annotation (Placement(transformation(extent={{50,-40},{60,-30}})));
equation
  connect(singleShaft_static.shaft, fourStageTurbinewithSteamExtraction.shaft_b)
    annotation (Line(
      points={{50,0},{-20,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(singleShaft_static.ActuatorsBus, actuators) annotation (Line(
      points={{90,-14},{100,-14},{100,-35},{85,-35}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(shaftSpeed.flange, fourStageTurbinewithSteamExtraction.shaft_a)
    annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(sourceW.flange, fourStageTurbinewithSteamExtraction.turbineInlet)
    annotation (Line(
      points={{-60,35},{-56,35},{-56,16}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW.flange, fourStageTurbinewithSteamExtraction.tap1) annotation (
      Line(
      points={{-60,-25},{-48,-25},{-48,-16}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW1.flange, fourStageTurbinewithSteamExtraction.tap2) annotation (
      Line(
      points={{-50,-35},{-41,-35},{-41,-18}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW2.flange, condPlant_cc.WaterOut) annotation (Line(
      points={{-10,-85},{0,-85},{0,-70}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW3.flange, fourStageTurbinewithSteamExtraction.tap3) annotation (
      Line(
      points={{-40,-45},{-34,-45},{-34,-19}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fourStageTurbinewithSteamExtraction.turbineOutlet, condPlant_cc.SteamIn)
    annotation (Line(
      points={{-27,20},{-27,35},{0,35},{0,-30}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamInlet.y, sourceW.in_w0) annotation (Line(
      points={{-79.5,55},{-67,55},{-67,38}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(singleShaft_static.SensorsBus, sensors) annotation (Line(
      points={{90,-8},{110,-8},{110,35},{85,35}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(condPlant_cc.SensorsBus, singleShaft_static.SensorsBus) annotation (
      Line(
      points={{19.6,-58},{110,-58},{110,-8},{90,-8}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None));
  connect(actuators, condPlant_cc.ActuatorsBus) annotation (Line(
      points={{85,-35},{100,-35},{100,-64.4},{19.6,-64.4}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(breakerSwitch.y, actuators.breakerClosed) annotation (Line(
      points={{60.5,-35},{85,-35}},
      color={255,0,255},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-120,-100},{120,100}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-120,-100},{120,100}},
        grid={1,1})),
    experiment(StopTime=1000, NumberOfIntervals=10000),
    __Dymola_experimentSetupOutput);
end SuperCriticalWaterPlant;
