within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples;
model SingleShaft_static
  "Alternator group in configuration single-shaft (one generator)"
  import ORNL_AdvSMR;
  extends
    ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.SingleShaft;

  ElectricGenerators.Grid grid(fn=fn, Pn=Pn) annotation (Placement(
        transformation(extent={{100,-20},{140,20}}, rotation=0)));
  ElectricGenerators.Generator generator(eta=eta, initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState)
    annotation (Placement(transformation(extent={{-78,-30},{-18,30}}, rotation=
            0)));
  ElectricGenerators.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{12,-8},{28,8}}, rotation=0)));
  ElectricGenerators.FrequencySensor frequencySensor annotation (Placement(
        transformation(extent={{10,-68},{26,-52}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=J_shaft,
    phi(fixed=if ((ORNL_AdvSMR.Choices.Init.Options.steadyState) == 3 or (
          ORNL_AdvSMR.Choices.Init.Options.steadyState) == 4 or (ORNL_AdvSMR.Choices.Init.Options.steadyState)
           == 7 or (ORNL_AdvSMR.Choices.Init.Options.steadyState) == 9) then
          true else false),
    stateSelect=StateSelect.avoid) annotation (Placement(transformation(extent=
            {{-120,-10},{-100,10}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=d_shaft) annotation
    (Placement(transformation(extent={{-118,-70},{-98,-50}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
        transformation(extent={{-80,-80},{-60,-60}}, rotation=0)));
  ElectricGenerators.Breaker breaker annotation (Placement(transformation(
          extent={{48,20},{88,-20}}, rotation=0)));

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
  connect(generator.powerConnection, powerSensor.port_a) annotation (Line(
      points={{-22.2,5.32907e-016},{0.6,5.32907e-016},{0.6,0},{12,0}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(frequencySensor.port, generator.powerConnection) annotation (Line(
      points={{10,-60},{0,-60},{0,5.32907e-016},{-22.2,5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(powerSensor.port_b, breaker.connection1) annotation (Line(
      points={{28,-0.16},{34,-0.16},{34,-3.55271e-016},{50.8,-3.55271e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(breaker.connection2, grid.connection) annotation (Line(
      points={{85.2,-3.55271e-016},{86,-3.1606e-022},{86,0},{94,0},{94,
          3.55271e-016},{102.8,3.55271e-016}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(generator.shaft, inertia.flange_b) annotation (Line(
      points={{-73.8,5.32907e-016},{-85.9,5.32907e-016},{-85.9,0},{-100,0}},
      color={0,0,0},
      thickness=0.5));

  connect(controlBus.EG_FREQSEN_FREQ, frequencySensor.f) annotation (Line(
      points={{0,-190},{0,-100},{40,-100},{40,-60},{26.16,-60}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(controlBus.EG_POWERSEN_POWER, powerSensor.W) annotation (Line(
      points={{0,-190},{0,-100},{40,-100},{40,-20},{20,-20},{20,-7.52}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(controlBus.EG_BREAKER_SWITCH, breaker.closed) annotation (Line(
      points={{0,-190},{0,-100},{68,-100},{68,-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics));
end SingleShaft_static;
