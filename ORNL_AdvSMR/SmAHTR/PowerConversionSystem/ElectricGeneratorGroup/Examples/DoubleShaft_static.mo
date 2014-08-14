within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples;
model DoubleShaft_static
  "Alternator group in configuration double-shaft (two generator)"
  extends
    SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.DoubleShaft;
  SmAHTR.PowerConversionSystem.ElectricGenerators.Generator
    generator_A(eta=eta_A, initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit) annotation (
      Placement(transformation(extent={{-80,70},{-20,130}}, rotation=
            0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_A(J=
        J_shaft_A, w(start=omega_nom_A)) annotation (Placement(
        transformation(extent={{-120,90},{-100,110}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper_A(d=
        d_shaft_A) annotation (Placement(transformation(extent={{-120,
            10},{-100,30}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
      Placement(transformation(extent={{-50,-46},{-30,-26}}, rotation=
           0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Breaker breaker_A
    annotation (Placement(transformation(extent={{60,120},{100,80}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Generator
    generator_B(eta=eta_B, initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit) annotation (
      Placement(transformation(extent={{-80,-130},{-20,-70}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_B(J=
        J_shaft_B, w(start=omega_nom_B)) annotation (Placement(
        transformation(extent={{-120,-110},{-100,-90}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper_B(d=
        d_shaft_B) annotation (Placement(transformation(extent={{-120,
            -30},{-100,-10}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Breaker breaker_B
    annotation (Placement(transformation(extent={{60,-120},{100,-80}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_A annotation (Placement(transformation(extent={{10,90},
            {30,110}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_A annotation (Placement(transformation(extent={{
            10,160},{30,180}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_B annotation (Placement(transformation(extent={{10,-110},
            {30,-90}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_B annotation (Placement(transformation(extent={{8,
            -170},{28,-150}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Grid_2in grid(Pn=Pn,
      fn=fn) annotation (Placement(transformation(extent={{140,0},{
            180,40}}, rotation=0)));
equation
  connect(inertia_B.flange_a, shaft_B) annotation (Line(
      points={{-120,-100},{-200,-100}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_B.shaft, inertia_B.flange_b) annotation (Line(
      points={{-75.8,-100},{-100,-100}},
      color={0,0,0},
      thickness=0.5));
  connect(powerSensor_B.port_a, generator_B.powerConnection)
    annotation (Line(
      points={{10,-100},{-24.2,-100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_B.port, generator_B.powerConnection)
    annotation (Line(
      points={{8,-160},{0,-160},{0,-100},{-24.2,-100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(breaker_B.connection1, powerSensor_B.port_b) annotation (
      Line(
      points={{62.8,-100},{35.7,-100},{35.7,-100.2},{30,-100.2}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(breaker_A.connection1, powerSensor_A.port_b) annotation (
      Line(
      points={{62.8,100},{35.7,100},{35.7,99.8},{30,99.8}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(powerSensor_A.port_a, generator_A.powerConnection)
    annotation (Line(
      points={{10,100},{-24.2,100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_A.port, generator_A.powerConnection)
    annotation (Line(
      points={{10,170},{0,170},{0,100},{-24.2,100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(damper_B.flange_a, shaft_B) annotation (Line(
      points={{-120,-20},{-140,-20},{-140,-100},{-200,-100}},
      color={0,0,0},
      thickness=0.5));
  connect(damper_B.flange_b, fixed.flange) annotation (Line(
      points={{-100,-20},{-40,-20},{-40,-36}},
      color={0,0,0},
      thickness=0.5));
  connect(damper_A.flange_b, fixed.flange) annotation (Line(
      points={{-100,20},{-40,20},{-40,-36}},
      color={0,0,0},
      thickness=0.5));
  connect(damper_A.flange_a, shaft_A) annotation (Line(
      points={{-120,20},{-140,20},{-140,100},{-202,100}},
      color={0,0,0},
      thickness=0.5));
  connect(inertia_A.flange_a, shaft_A) annotation (Line(
      points={{-120,100},{-202,100}},
      color={0,0,0},
      thickness=0.5));
  connect(inertia_A.flange_b, generator_A.shaft) annotation (Line(
      points={{-100,100},{-75.8,100}},
      color={0,0,0},
      thickness=0.5));
  connect(ActuatorsBus.breakerClosed_shaftA, breaker_A.closed)
    annotation (Line(points={{200,-140},{110,-140},{110,0},{80,0},{80,
          84}}, color={213,255,170}));
  connect(ActuatorsBus.breakerClosed_shaftB, breaker_B.closed)
    annotation (Line(points={{200,-140},{110,-140},{110,0},{80,0},{80,
          -84}}, color={213,255,170}));
  connect(SensorsBus.power_shaftA, powerSensor_A.W) annotation (Line(
        points={{200,-80},{140,-80},{140,-140},{40,-140},{40,40},{20,
          40},{20,90.6}}, color={255,170,213}));
  connect(SensorsBus.power_shaftB, powerSensor_B.W) annotation (Line(
        points={{200,-80},{140,-80},{140,-140},{20,-140},{20,-109.4}},
        color={255,170,213}));
  connect(SensorsBus.frequency_shaftA, frequencySensor_A.f)
    annotation (Line(points={{200,-80},{140,-80},{140,-140},{40,-140},
          {40,170},{30.2,170}}, color={255,170,213}));
  connect(SensorsBus.frequency_shaftB, frequencySensor_B.f)
    annotation (Line(points={{200,-80},{140,-80},{140,-140},{60,-140},
          {60,-160},{28.2,-160}}, color={255,170,213}));
  connect(grid.connection_B, breaker_B.connection2) annotation (Line(
      points={{142.8,12},{120,12},{120,-100},{97.2,-100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(grid.connection_A, breaker_A.connection2) annotation (Line(
      points={{142.8,28},{120,28},{120,100},{97.2,100}},
      pattern=LinePattern.None,
      thickness=0.5));
  annotation (Diagram(graphics));
end DoubleShaft_static;
