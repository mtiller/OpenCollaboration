within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.RankineCycle;
model superCriticalWaterTurbineGenerator

  parameter Boolean SSInit=false "Steady-state initialization";

  ElectricGeneratorGroup.Examples.GeneratorGroup_wBreaker
    generatorGroup_wBreaker(
    eta=0.9,
    J_shaft=15000,
    SSInit=SSInit,
    fn=50,
    d_shaft=250,
    Pmax=125e6,
    delta_start=0.7)
    annotation (Placement(transformation(extent={{30,-20},{70,20}})));

  CondenserGroup.CondPlant_cc controlledCondenser(
    Vtot=10,
    Vlstart=1.5,
    setPoint_ratio=0.85,
    redeclare package FluidMedium = ORNL_SMR.StandardWater,
    SSInit=SSInit,
    p=5398.2) annotation (Placement(transformation(extent={{-6,-85},{34,
            -45}}, rotation=0)));
  Interfaces.Actuators actuators annotation (Placement(transformation(
          extent={{90,-90},{100,-80}}), iconTransformation(extent={{90,
            -90},{100,-80}})));
  Interfaces.Sensors sensors annotation (Placement(transformation(
          extent={{90,-70},{100,-60}}), iconTransformation(extent={{90,
            -70},{100,-60}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=400,
      startValue=true) annotation (Placement(transformation(
        extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=0,
        origin={87.5,5})));
  Interfaces.FlangeA steamIn annotation (Placement(transformation(
          extent={{-95,90},{-75,110}}), iconTransformation(extent={{-95,
            90},{-75,110}})));
  Interfaces.FlangeB waterOut annotation (Placement(transformation(
          extent={{-60,90},{-40,110}}), iconTransformation(extent={{-60,
            90},{-40,110}})));
  Components.TenStageLowPressureTurbine tenStageLowPressureTurbine
    annotation (Placement(transformation(extent={{-40,-30},{20,30}})));
  Components.FourStageTurbine fourStageTurbine
    annotation (Placement(transformation(extent={{-91,-20},{-51,20}})));
equation
  connect(sensors, generatorGroup_wBreaker.SensorsBus) annotation (Line(
      points={{95,-65},{85,-65},{85,-8},{70,-8}},
      color={255,170,213},
      smooth=Smooth.None,
      thickness=1), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(booleanStep.y, generatorGroup_wBreaker.u) annotation (Line(
      points={{79.25,5},{70,5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(generatorGroup_wBreaker.ActuatorsBus, actuators) annotation (
      Line(
      points={{70,-14},{80,-14},{80,-85},{95,-85}},
      color={213,255,170},
      smooth=Smooth.None,
      thickness=1), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(tenStageLowPressureTurbine.shaft_b, generatorGroup_wBreaker.shaft)
    annotation (Line(
      points={{20,0},{30,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fourStageTurbine.shaft_b, tenStageLowPressureTurbine.shaft_a)
    annotation (Line(
      points={{-51,0},{-40,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(tenStageLowPressureTurbine.tap3, controlledCondenser.SteamIn)
    annotation (Line(
      points={{14,-30},{14,-45}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(steamIn, fourStageTurbine.turbineInlet) annotation (Line(
      points={{-85,100},{-85,16}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(fourStageTurbine.turbineOutlet, tenStageLowPressureTurbine.turbineInlet)
    annotation (Line(
      points={{-57,-20},{-57,-30.5},{-45,-30.5},{-45,45},{-34,45},{-34,
          30}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(controlledCondenser.WaterOut, waterOut) annotation (Line(
      points={{14,-85},{14,-95},{75,-95},{75,70},{-50,70},{-50,100}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sensors, controlledCondenser.SensorsBus) annotation (Line(
      points={{95,-65},{40,-65},{40,-73},{33.6,-73}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(actuators, controlledCondenser.ActuatorsBus) annotation (Line(
      points={{95,-85},{40,-85},{40,-79.4},{33.6,-79.4}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Text(
                  extent={{-90,-30},{-50,-40}},
                  lineColor={0,0,127},
                  lineThickness=1,
                  textString="High-Pressure Turbine"),Text(
                  extent={{-30,-20},{10,-30}},
                  lineColor={0,0,127},
                  lineThickness=1,
                  textString="Low-Pressure Turbine"),Text(
                  extent={{33,35},{93,25}},
                  lineColor={0,0,127},
                  lineThickness=1,
                  textString="Generator and Grid Network"),Text(
                  extent={{-70,-60},{-10,-80}},
                  lineColor={0,0,127},
                  lineThickness=1,
                  textString="Condenser with 
Recirculation Ratio Control")}),
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
System"),
 Bitmap(extent={{-95,95},{95,-45}}, fileName=
          "modelica://aSMR/Icons/Steam Turbine.jpg")}),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-007,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end superCriticalWaterTurbineGenerator;
