within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.Tests;
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
    annotation (Placement(transformation(extent={{-55,-30},{45,70}})));

  ORNL_AdvSMR.Components.FourStageTurbinewithSteamExtraction fourStageTurbinewithSteamExtraction(
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
    annotation (Placement(transformation(extent={{-95,5},{-65,35}})));

  inner ORNL_AdvSMR.System system(allowFlowReversal=false, Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  ORNL_AdvSMR.Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{85,50},{95,60}})));
  ORNL_AdvSMR.Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{85,-20},{95,-10}})));
  SmAHTR.PowerConversionSystem.CondenserGroup.CondPlant_cc condPlant_cc(
    setPoint_ratio=0.85,
    SSInit=false,
    p=5000,
    Vtot=1000,
    Vlstart=150)
    annotation (Placement(transformation(extent={{15,-70},{55,-30}})));
  SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
    singleShaft_static(
    Pn=5000e6,
    eta=0.9,
    J_shaft=100,
    omega_nom=314.16/2,
    SSInit=true)
    annotation (Placement(transformation(extent={{55,0},{95,40}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed shaftSpeed(
      w_fixed=314.16/2, useSupport=false) annotation (Placement(
        transformation(extent={{-115,15},{-105,25}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW(
    w0=1722.47,
    h=3167.3e3,
    p0=23500000) annotation (Placement(transformation(extent={{-105.25,
            50},{-95.25,60}})));
  ORNL_AdvSMR.Components.SinkW sinkW(w0=265.4, p0=7000000)
                                                        annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-110,-5})));
  ORNL_AdvSMR.Components.SinkW sinkW1(w0=127.38, p0=4500000)
                                                          annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-95,-15})));
  ORNL_AdvSMR.Components.SinkW sinkW2(
    h=138.8e3,
    w0=782.74,
    p0=5000) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={20,-80})));
  ORNL_AdvSMR.Components.SinkW sinkW3(w0=75.74, p0=2300000)
                                                         annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-80.5,-25})));
  Modelica.Blocks.Sources.Ramp steamInlet(
    height=-1722.47/2,
    duration=100,
    offset=1722.47,
    startTime=100) annotation (Placement(transformation(extent={{-114.5,
            70},{-104.5,80}})));
  Modelica.Blocks.Sources.BooleanConstant breakerSwitch(k=false)
    annotation (Placement(transformation(extent={{55,-20},{65,-10}})));
  Modelica.Blocks.Sources.Ramp steamTap1(
    duration=100,
    startTime=100,
    height=0,
    offset=0) annotation (Placement(transformation(extent={{-120,-25},{
            -110,-15}})));
  Modelica.Blocks.Sources.Ramp steamTap2(
    duration=100,
    startTime=100,
    height=0,
    offset=0) annotation (Placement(transformation(extent={{-105,-40},{
            -95,-30}})));
  Modelica.Blocks.Sources.Ramp steamTap3(
    duration=100,
    startTime=100,
    height=0,
    offset=0) annotation (Placement(transformation(extent={{-90,-55},{-80,
            -45}})));
  Modelica.Blocks.Sources.Ramp steamTap4(
    duration=100,
    startTime=100,
    height=0,
    offset=0)
    annotation (Placement(transformation(extent={{0,-95},{10,-85}})));
equation
  connect(singleShaft_static.ActuatorsBus, actuators) annotation (Line(
      points={{95,6},{105,6},{105,-15},{90,-15}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(shaftSpeed.flange, fourStageTurbinewithSteamExtraction.shaft_a)
    annotation (Line(
      points={{-105,20},{-95,20}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(sourceW.flange, fourStageTurbinewithSteamExtraction.turbineInlet)
    annotation (Line(
      points={{-95.25,55},{-89,55},{-89,32}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW.flange, fourStageTurbinewithSteamExtraction.tap1)
    annotation (Line(
      points={{-105,-5},{-86,-5},{-86,8}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW1.flange, fourStageTurbinewithSteamExtraction.tap2)
    annotation (Line(
      points={{-90,-15},{-80.75,-15},{-80.75,6.5}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW2.flange, condPlant_cc.WaterOut) annotation (Line(
      points={{25,-80},{35,-80},{35,-70}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sinkW3.flange, fourStageTurbinewithSteamExtraction.tap3)
    annotation (Line(
      points={{-75.5,-25},{-75.5,5.75}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamInlet.y, sourceW.in_w0) annotation (Line(
      points={{-104,75},{-102.25,75},{-102.25,58}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(singleShaft_static.SensorsBus, sensors) annotation (Line(
      points={{95,12},{115,12},{115,55},{90,55}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(condPlant_cc.SensorsBus, singleShaft_static.SensorsBus)
    annotation (Line(
      points={{54.6,-58},{115,-58},{115,12},{95,12}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None));
  connect(actuators, condPlant_cc.ActuatorsBus) annotation (Line(
      points={{90,-15},{105,-15},{105,-64.4},{54.6,-64.4}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(breakerSwitch.y, actuators.breakerClosed) annotation (Line(
      points={{65.5,-15},{90,-15}},
      color={255,0,255},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fourStageTurbinewithSteamExtraction.shaft_b,
    tenStageLowPressureTurbine.shaft_a) annotation (Line(
      points={{-65,20},{-55,20}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(tenStageLowPressureTurbine.shaft_b, singleShaft_static.shaft)
    annotation (Line(
      points={{45,20},{55,20}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(tenStageLowPressureTurbine.tap3, condPlant_cc.SteamIn)
    annotation (Line(
      points={{35,-10},{35,-30}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fourStageTurbinewithSteamExtraction.turbineOutlet,
    tenStageLowPressureTurbine.turbineInlet) annotation (Line(
      points={{-71.75,34.25},{-71.75,60},{-45,60},{-45,50}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamTap1.y, sinkW.in_w0) annotation (Line(
      points={{-109.5,-20},{-108,-20},{-108,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(steamTap2.y, sinkW1.in_w0) annotation (Line(
      points={{-94.5,-35},{-93,-35},{-93,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(steamTap3.y, sinkW3.in_w0) annotation (Line(
      points={{-79.5,-50},{-78.5,-50},{-78.5,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(steamTap4.y, sinkW2.in_w0) annotation (Line(
      points={{10.5,-90},{22,-90},{22,-83}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-120,-100},{120,100}},
        grid={0.5,0.5}), graphics={Text(
                  extent={{-95,80},{-65,60}},
                  lineColor={0,0,255},
                  lineThickness=1,
                  textStyle={TextStyle.Bold},
                  textString="High-Pressure
Turbine"),
  Text(           extent={{-26,60},{8,50}},
                  lineColor={0,0,255},
                  lineThickness=1,
                  textStyle={TextStyle.Bold},
                  textString="Low-Pressure
Turbine"),
  Text(           extent={{53,52},{96,37}},
                  lineColor={0,0,255},
                  lineThickness=1,
                  textStyle={TextStyle.Bold},
                  textString="Generator and Grid"),Text(
                  extent={{25,-79},{75,-99}},
                  lineColor={0,0,255},
                  lineThickness=1,
                  textStyle={TextStyle.Bold},
                  textString="Condensation Plant with 
Condenser Ratio Control")}),
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
