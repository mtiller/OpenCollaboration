within ORNL_AdvSMR.PRISM.PowerConversionSystem.Tests;
model SuperCriticalWaterPlant2
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.Components.TenStageLowPressureTurbine tenStageLowPressureTurbine(
    Kt=0.005,
    wnom=75.74,
    w_tap1=0,
    w_tap2=0,
    w_tap3=0,
    PRstart=20,
    pnom=1000000,
    p_nom2=500000,
    p_nom3=300000,
    p_nom4=200000)
    annotation (Placement(transformation(extent={{-35,-5},{45,75}})));

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
    wnom=1722.47,
    pnom=23500000,
    p_nom2=7000000,
    p_nom3=4500000,
    p_nom4=2300000)
    annotation (Placement(transformation(extent={{-75,20},{-45,50}})));

  inner ORNL_AdvSMR.System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  ORNL_AdvSMR.Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{85,65},{95,75}})));
  ORNL_AdvSMR.Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{84.5,-5},{94.5,5}})));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup.CondPlant_cc
    condPlant_cc(
    setPoint_ratio=0.85,
    SSInit=false,
    p=5000,
    Vtot=1000,
    Vlstart=150)
    annotation (Placement(transformation(extent={{20,-70},{60,-30}})));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
    singleShaft_static(
    Pn=5000e6,
    eta=0.9,
    J_shaft=100,
    omega_nom=314.16/2,
    SSInit=true)
    annotation (Placement(transformation(extent={{55,15},{95,55}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed shaftSpeed(w_fixed=314.16
        /2, useSupport=false) annotation (Placement(transformation(extent={{-115,
            30},{-105,40}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW(
    w0=1722.47,
    h=3167.3e3,
    p0=23500000)
    annotation (Placement(transformation(extent={{-85.25,65},{-75.25,75}})));
  ORNL_AdvSMR.Components.SinkW sinkW(w0=265.4, p0=7000000) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-90,10})));
  ORNL_AdvSMR.Components.SinkW sinkW1(w0=127.38, p0=4500000) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-75,0})));
  ORNL_AdvSMR.Components.SinkW sinkW2(
    h=138.8e3,
    w0=782.74,
    p0=5000) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={25,-80})));
  ORNL_AdvSMR.Components.SinkW sinkW3(w0=75.74, p0=2300000) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-60.5,-10})));
  Modelica.Blocks.Sources.Ramp steamInlet(
    height=-1722.47/2,
    duration=100,
    offset=1722.47,
    startTime=100)
    annotation (Placement(transformation(extent={{-94.5,85},{-84.5,95}})));
  Modelica.Blocks.Sources.BooleanConstant breakerSwitch(k=false)
    annotation (Placement(transformation(extent={{54.5,-5},{64.5,5}})));
  Modelica.Blocks.Sources.Ramp steamTap1(
    duration=100,
    startTime=100,
    height=0,
    offset=0)
    annotation (Placement(transformation(extent={{-100,-10},{-90,0}})));
  Modelica.Blocks.Sources.Ramp steamTap2(
    duration=100,
    startTime=100,
    height=0,
    offset=0)
    annotation (Placement(transformation(extent={{-84.5,-40},{-74.5,-30}})));
  Modelica.Blocks.Sources.Ramp steamTap3(
    duration=100,
    startTime=100,
    height=0,
    offset=0)
    annotation (Placement(transformation(extent={{-69.5,-55},{-59.5,-45}})));
  Modelica.Blocks.Sources.Ramp steamTap4(
    duration=100,
    startTime=100,
    height=0,
    offset=0) annotation (Placement(transformation(extent={{5,-95},{15,-85}})));
equation
  connect(singleShaft_static.ActuatorsBus, actuators) annotation (Line(
      points={{95,21},{104.5,21},{104.5,0},{89.5,0}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(shaftSpeed.flange, fourStageTurbinewithSteamExtraction.shaft_a)
    annotation (Line(
      points={{-105,35},{-75,35}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(sourceW.flange, fourStageTurbinewithSteamExtraction.turbineInlet)
    annotation (Line(
      points={{-75.25,70},{-72,70},{-72,47}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW.flange, fourStageTurbinewithSteamExtraction.tap1) annotation (
      Line(
      points={{-85,10},{-66,10},{-66,23}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW1.flange, fourStageTurbinewithSteamExtraction.tap2) annotation (
      Line(
      points={{-70,0},{-60.75,0},{-60.75,21.5}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW2.flange, condPlant_cc.WaterOut) annotation (Line(
      points={{30,-80},{40,-80},{40,-70}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW3.flange, fourStageTurbinewithSteamExtraction.tap3) annotation (
      Line(
      points={{-55.5,-10},{-55.5,20.75}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamInlet.y, sourceW.in_w0) annotation (Line(
      points={{-84,90},{-82.25,90},{-82.25,73}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(singleShaft_static.SensorsBus, sensors) annotation (Line(
      points={{95,27},{114.5,27},{114.5,70},{90,70}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(condPlant_cc.SensorsBus, singleShaft_static.SensorsBus) annotation (
      Line(
      points={{59.6,-58},{114.5,-58},{114.5,27},{95,27}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None));
  connect(actuators, condPlant_cc.ActuatorsBus) annotation (Line(
      points={{89.5,0},{104.5,0},{104.5,-64.4},{59.6,-64.4}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(breakerSwitch.y, actuators.breakerClosed) annotation (Line(
      points={{65,0},{89.5,0}},
      color={255,0,255},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fourStageTurbinewithSteamExtraction.shaft_b,
    tenStageLowPressureTurbine.shaft_a) annotation (Line(
      points={{-45,35},{-35,35}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(tenStageLowPressureTurbine.shaft_b, singleShaft_static.shaft)
    annotation (Line(
      points={{45,35},{55,35}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(tenStageLowPressureTurbine.tap3, condPlant_cc.SteamIn) annotation (
      Line(
      points={{5,17},{5,-6.5},{40,-6.5},{40,-30}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fourStageTurbinewithSteamExtraction.turbineOutlet,
    tenStageLowPressureTurbine.turbineInlet) annotation (Line(
      points={{-50.25,50},{-50.25,90},{5,90},{5,55}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamTap1.y, sinkW.in_w0) annotation (Line(
      points={{-89.5,-5},{-88,-5},{-88,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(steamTap2.y, sinkW1.in_w0) annotation (Line(
      points={{-74,-35},{-73,-35},{-73,-3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(steamTap3.y, sinkW3.in_w0) annotation (Line(
      points={{-59,-50},{-58.5,-50},{-58.5,-13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(steamTap4.y, sinkW2.in_w0) annotation (Line(
      points={{15.5,-90},{27,-90},{27,-83}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-120,-100},{120,100}},
        grid={0.5,0.5}), graphics={Text(
          extent={{-99.5,60},{-69.5,40}},
          lineColor={0,0,255},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="High-Pressure
Turbine"),Text(
          extent={{-35,75},{-1,65}},
          lineColor={0,0,255},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="Low-Pressure
Turbine"),Text(
          extent={{52.5,67},{95.5,52}},
          lineColor={0,0,255},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="Generator and Grid"),Text(
          extent={{30,-79},{80,-99}},
          lineColor={0,0,255},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="Condensation Plant with 
Condenser Ratio Control"),Text(
          extent={{80,76.5},{100,77.5}},
          lineColor={0,0,0},
          textString="Sensor Bus"),Text(
          extent={{80,-8.5},{100,-7.5}},
          lineColor={0,0,0},
          textString="Actuator Bus")}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-120,-100},{120,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=10000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end SuperCriticalWaterPlant2;
