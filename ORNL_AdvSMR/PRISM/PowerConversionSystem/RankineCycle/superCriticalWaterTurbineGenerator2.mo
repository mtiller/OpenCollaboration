within ORNL_AdvSMR.PRISM.PowerConversionSystem.RankineCycle;
model superCriticalWaterTurbineGenerator2

  parameter Boolean SSInit=false "Steady-state initialization";

  SteamTurbines.SteamTurbineStodola steamTurbineStodola(
    PRstart=1,
    redeclare package Medium = ORNL_AdvSMR.StandardWater,
    explicitIsentropicEnthalpy=true,
    wnom=144,
    wstart=150,
    Kt=3.2252e-003,
    pnom=23500000)
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  inner System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ElectricGeneratorGroup.Examples.GeneratorGroup_wBreaker
    generatorGroup_wBreaker(
    eta=0.9,
    J_shaft=15000,
    SSInit=SSInit,
    fn=50,
    d_shaft=250,
    Pmax=125e6,
    delta_start=0.7)
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));

  CondenserGroup.CondPlant_cc controlledCondenser(
    Vtot=10,
    Vlstart=1.5,
    setPoint_ratio=0.85,
    redeclare package FluidMedium = ORNL_AdvSMR.StandardWater,
    SSInit=SSInit,
    p=5398.2) annotation (Placement(transformation(extent={{-30,-90},{30,-30}},
          rotation=0)));
  Interfaces.Actuators actuators annotation (Placement(transformation(extent={{
            90,-90},{100,-80}}), iconTransformation(extent={{90,-90},{100,-80}})));
  Interfaces.Sensors sensors annotation (Placement(transformation(extent={{90,-70},
            {100,-60}}), iconTransformation(extent={{90,-70},{100,-60}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=400, startValue=
        true) annotation (Placement(transformation(extent={{85,-5},{70,10}})));
  Components.SourceP sourceP(
    h=3167.3e3,
    allowFlowReversal=false,
    redeclare package Medium = ORNL_AdvSMR.StandardWater,
    p0=23500000)
    annotation (Placement(transformation(extent={{-95,5},{-75,25}})));
equation
  connect(steamTurbineStodola.shaft_b, generatorGroup_wBreaker.shaft)
    annotation (Line(
      points={{-27.2,0},{20,0}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(steamTurbineStodola.outlet, controlledCondenser.SteamIn) annotation (
      Line(
      points={{-24,16},{0,16},{0,-30}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensors, generatorGroup_wBreaker.SensorsBus) annotation (Line(
      points={{95,-65},{85,-65},{85,-8},{60,-8}},
      color={255,170,213},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(booleanStep.y, generatorGroup_wBreaker.u) annotation (Line(
      points={{69.25,2.5},{65,2.5},{65,5},{60,5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(generatorGroup_wBreaker.ActuatorsBus, actuators) annotation (Line(
      points={{60,-14},{80,-14},{80,-85},{95,-85}},
      color={213,255,170},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sourceP.flange, steamTurbineStodola.inlet) annotation (Line(
      points={{-75,15},{-67,15},{-67,16},{-56,16}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          radius=8),Text(
          extent={{-100,-60},{100,-80}},
          lineColor={175,175,175},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Power Conversion
System"),Bitmap(extent={{-95,95},{95,-45}}, fileName=
          "modelica://aSMR/Icons/Steam Turbine.jpg")}),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-007,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end superCriticalWaterTurbineGenerator2;
