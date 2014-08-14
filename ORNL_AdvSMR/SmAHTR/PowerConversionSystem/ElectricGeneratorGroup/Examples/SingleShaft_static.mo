within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples;
model SingleShaft_static
  "Alternator group in configuration single-shaft (one generator)"
  extends
    SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.SingleShaft;

  SmAHTR.PowerConversionSystem.ElectricGenerators.Grid grid(fn=fn, Pn=
       Pn) annotation (Placement(transformation(extent={{100,-20},{
            140,20}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Generator generator(
      eta=eta, initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit) annotation (
      Placement(transformation(extent={{-78,-30},{-18,30}}, rotation=
            0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor annotation (Placement(transformation(extent={{12,-8},
            {28,8}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor annotation (Placement(transformation(extent={{10,
            -68},{26,-52}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=J_shaft,
    phi(fixed=if ((ThermoPower3.Choices.Init.Options.steadyState) ==
          3 or (ThermoPower3.Choices.Init.Options.steadyState) == 4
           or (ThermoPower3.Choices.Init.Options.steadyState) == 7
           or (ThermoPower3.Choices.Init.Options.steadyState) == 9)
           then true else false),
    stateSelect=StateSelect.avoid) annotation (Placement(
        transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
  /*    a(fixed=if ((ThermoPower3.Choices.Init.Options.steadyState) == 2 or (ThermoPower3.Choices.Init.Options.steadyState) == 6
           or (ThermoPower3.Choices.Init.Options.steadyState) == 7 or (ThermoPower3.Choices.Init.Options.steadyState) == 8
           or (ThermoPower3.Choices.Init.Options.steadyState) == 9) then true else false),
    w(fixed=if ((ThermoPower3.Choices.Init.Options.steadyState) == 2 or (ThermoPower3.Choices.Init.Options.steadyState) == 3
           or (ThermoPower3.Choices.Init.Options.steadyState) == 5 or (ThermoPower3.Choices.Init.Options.steadyState) == 8
           or (ThermoPower3.Choices.Init.Options.steadyState) == 9) then true else false, start=omega_nom),*/

  Modelica.Mechanics.Rotational.Components.Damper damper(d=d_shaft)
    annotation (Placement(transformation(extent={{-118,-70},{-98,-50}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
      Placement(transformation(extent={{-80,-80},{-60,-60}}, rotation=
           0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Breaker breaker
    annotation (Placement(transformation(extent={{48,20},{88,-20}},
          rotation=0)));
equation
  connect(inertia.flange_a, shaft) annotation (Line(
      points={{-120,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(damper.flange_a, shaft) annotation (Line(
      points={{-118,-60},{-140,-60},{-140,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(damper.flange_b, fixed.flange) annotation (Line(
      points={{-98,-60},{-70,-60},{-70,-70}},
      color={0,0,0},
      thickness=0.5));
  connect(generator.powerConnection, powerSensor.port_a) annotation (
      Line(
      points={{-22.2,5.32907e-016},{0.6,5.32907e-016},{0.6,0},{12,0}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(frequencySensor.port, generator.powerConnection)
    annotation (Line(
      points={{10,-60},{0,-60},{0,5.32907e-016},{-22.2,5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(powerSensor.port_b, breaker.connection1) annotation (Line(
      points={{28,-0.16},{34,-0.16},{34,-3.55271e-016},{50.8,-3.55271e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(breaker.connection2, grid.connection) annotation (Line(
      points={{85.2,-3.55271e-016},{86,-3.1606e-022},{86,0},{94,0},{
          94,3.55271e-016},{102.8,3.55271e-016}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(ActuatorsBus.breakerClosed, breaker.closed) annotation (
      Line(points={{200,-140},{68,-140},{68,-16}}, color={213,255,170}));
  connect(SensorsBus.power, powerSensor.W) annotation (Line(points={{
          200,-80},{100,-80},{100,-40},{20,-40},{20,-7.52}}, color={
          255,170,213}));
  connect(SensorsBus.frequency, frequencySensor.f) annotation (Line(
        points={{200,-80},{100,-80},{100,-60},{26.16,-60}}, color={
          255,170,213}));
  connect(generator.shaft, inertia.flange_b) annotation (Line(
      points={{-73.8,5.32907e-016},{-85.9,5.32907e-016},{-85.9,0},{-100,
          0}},
      color={0,0,0},
      thickness=0.5));

  annotation (Diagram(graphics));
end SingleShaft_static;
