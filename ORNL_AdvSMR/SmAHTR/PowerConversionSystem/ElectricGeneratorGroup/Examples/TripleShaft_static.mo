within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples;
model TripleShaft_static
  "Alternator group in configuration triple-shaft (three generator)"
  extends
    SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.TripleShaft;
  SmAHTR.PowerConversionSystem.ElectricGenerators.Generator
    generator_A(eta=eta_A, initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit) annotation (
      Placement(transformation(extent={{-80,90},{-20,150}}, rotation=
            0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_A annotation (Placement(transformation(extent={{20,
            110},{40,130}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_A annotation (Placement(transformation(extent={{
            20,150},{40,170}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_A(J=
        J_shaft_A, w(start=omega_nom_A)) annotation (Placement(
        transformation(extent={{-140,110},{-120,130}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper_A(d=
        d_shaft_A) annotation (Placement(transformation(extent={{-140,
            70},{-120,90}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Breaker breaker_A
    annotation (Placement(transformation(extent={{60,100},{100,140}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Generator
    generator_B(eta=eta_B, initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit) annotation (
      Placement(transformation(extent={{-80,-30},{-20,30}}, rotation=
            0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_B annotation (Placement(transformation(extent={{20,-10},
            {40,10}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_B annotation (Placement(transformation(extent={{
            20,30},{40,50}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_B(J=
        J_shaft_B, w(start=omega_nom_B)) annotation (Placement(
        transformation(extent={{-140,-10},{-120,10}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper_B(d=
        d_shaft_B) annotation (Placement(transformation(extent={{-140,
            -50},{-120,-30}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
      Placement(transformation(extent={{-110,-186},{-90,-166}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Breaker breaker_B
    annotation (Placement(transformation(extent={{60,-20},{100,20}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Generator
    generator_C(eta=eta_C, initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit) annotation (
      Placement(transformation(extent={{-80,-150},{-20,-90}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_C annotation (Placement(transformation(extent={{20,-130},
            {40,-110}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_C annotation (Placement(transformation(extent={{
            20,-90},{40,-70}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_C(J=
        J_shaft_C, w(start=omega_nom_C)) annotation (Placement(
        transformation(extent={{-140,-130},{-120,-110}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper_C(d=
        d_shaft_C) annotation (Placement(transformation(extent={{-140,
            -170},{-120,-150}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Breaker breaker_C
    annotation (Placement(transformation(extent={{60,-140},{100,-100}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Grid_3in grid_3in(
      Pn=Pn, fn=fn) annotation (Placement(transformation(extent={{140,
            -20},{180,20}}, rotation=0)));
equation
  connect(fixed.flange, damper_B.flange_b) annotation (Line(
      points={{-100,-176},{-100,-40},{-120,-40}},
      color={0,0,0},
      thickness=0.5));
  connect(damper_C.flange_b, fixed.flange) annotation (Line(
      points={{-120,-160},{-100,-160},{-100,-176}},
      color={0,0,0},
      thickness=0.5));
  connect(fixed.flange, damper_A.flange_b) annotation (Line(
      points={{-100,-176},{-100,80},{-120,80}},
      color={0,0,0},
      thickness=0.5));
  connect(inertia_C.flange_b, generator_C.shaft) annotation (Line(
      points={{-120,-120},{-75.8,-120}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_C.powerConnection, powerSensor_C.port_a)
    annotation (Line(
      points={{-24.2,-120},{20,-120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(powerSensor_C.port_b, breaker_C.connection1) annotation (
      Line(
      points={{40,-120.2},{48,-120.2},{48,-120},{62.8,-120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(breaker_B.connection1, powerSensor_B.port_b) annotation (
      Line(
      points={{62.8,3.55271e-016},{53.55,3.55271e-016},{53.55,-0.2},{
          40,-0.2}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(powerSensor_B.port_a, generator_B.powerConnection)
    annotation (Line(
      points={{20,0},{13.6,0},{13.6,5.32907e-016},{-24.2,5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(generator_B.shaft, inertia_B.flange_b) annotation (Line(
      points={{-75.8,5.32907e-016},{-76,5.32907e-016},{-76,0},{-120,0}},
      color={0,0,0},
      thickness=0.5));

  connect(inertia_B.flange_a, shaft_B) annotation (Line(
      points={{-140,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(inertia_C.flange_a, shaft_C) annotation (Line(
      points={{-140,-120},{-200,-120}},
      color={0,0,0},
      thickness=0.5));
  connect(inertia_A.flange_a, shaft_A) annotation (Line(
      points={{-140,120},{-200,120}},
      color={0,0,0},
      thickness=0.5));
  connect(inertia_A.flange_b, generator_A.shaft) annotation (Line(
      points={{-120,120},{-75.8,120}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_A.powerConnection, powerSensor_A.port_a)
    annotation (Line(
      points={{-24.2,120},{20,120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(powerSensor_A.port_b, breaker_A.connection1) annotation (
      Line(
      points={{40,119.8},{48,119.8},{48,120},{62.8,120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_A.port, generator_A.powerConnection)
    annotation (Line(
      points={{20,160},{0,160},{0,120},{-24.2,120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_B.port, generator_B.powerConnection)
    annotation (Line(
      points={{20,40},{0,40},{0,0},{-6,0},{-6,5.32907e-016},{-24.2,
          5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(frequencySensor_C.port, generator_C.powerConnection)
    annotation (Line(
      points={{20,-80},{0,-80},{0,-120},{-24.2,-120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(damper_C.flange_a, shaft_C) annotation (Line(
      points={{-140,-160},{-160,-160},{-160,-120},{-200,-120}},
      color={0,0,0},
      thickness=0.5));
  connect(damper_B.flange_a, shaft_B) annotation (Line(
      points={{-140,-40},{-160,-40},{-160,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(damper_A.flange_a, shaft_A) annotation (Line(
      points={{-140,80},{-160,80},{-160,120},{-200,120}},
      color={0,0,0},
      thickness=0.5));
  connect(ActuatorsBus.breakerClosed_shaftC, breaker_C.closed)
    annotation (Line(points={{200,-140},{110,-140},{110,-80},{80,-80},
          {80,-104}}, color={213,255,170}));
  connect(ActuatorsBus.breakerClosed_shaftB, breaker_B.closed)
    annotation (Line(points={{200,-140},{110,-140},{110,40},{80,40},{
          80,16}}, color={213,255,170}));
  connect(ActuatorsBus.breakerClosed_shaftA, breaker_A.closed)
    annotation (Line(points={{200,-140},{110,-140},{110,150},{80,150},
          {80,136}}, color={213,255,170}));
  connect(SensorsBus.power_shaftC, powerSensor_C.W) annotation (Line(
        points={{200,-80},{160,-80},{160,-60},{54,-60},{54,-100},{30,
          -100},{30,-129.4}}, color={255,170,213}));
  connect(SensorsBus.frequency_shaftC, frequencySensor_C.f)
    annotation (Line(points={{200,-80},{160,-80},{160,-60},{54,-60},{
          54,-80},{40.2,-80}}, color={255,170,213}));
  connect(SensorsBus.power_shaftB, powerSensor_B.W) annotation (Line(
        points={{200,-80},{160,-80},{160,-60},{54,-60},{54,-20},{30,-20},
          {30,-9.4}}, color={255,170,213}));
  connect(SensorsBus.frequency_shaftB, frequencySensor_B.f)
    annotation (Line(points={{200,-80},{160,-80},{160,-60},{54,-60},{
          54,40},{40.2,40}}, color={255,170,213}));
  connect(SensorsBus.power_shaftA, powerSensor_A.W) annotation (Line(
        points={{200,-80},{160,-80},{160,-60},{54,-60},{54,100},{30,
          100},{30,110.6}}, color={255,170,213}));
  connect(SensorsBus.frequency_shaftA, frequencySensor_A.f)
    annotation (Line(points={{200,-80},{160,-80},{160,-60},{54,-60},{
          54,160},{40.2,160}}, color={255,170,213}));
  connect(grid_3in.connection_B, breaker_B.connection2) annotation (
      Line(
      points={{142.8,3.55271e-016},{96,-3.1606e-022},{96,3.55271e-016},
          {97.2,3.55271e-016}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(grid_3in.connection_C, breaker_C.connection2) annotation (
      Line(
      points={{142.8,-16},{120,-16},{120,-120},{97.2,-120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(grid_3in.connection_A, breaker_A.connection2) annotation (
      Line(
      points={{142.8,16},{120,16},{120,120},{97.2,120}},
      pattern=LinePattern.None,
      thickness=0.5));
  annotation (Diagram(graphics));
end TripleShaft_static;
