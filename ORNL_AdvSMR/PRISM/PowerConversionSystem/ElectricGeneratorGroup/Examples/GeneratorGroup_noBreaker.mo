within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples;
model GeneratorGroup_noBreaker
  "Alternator group in configuration single-shaft (one generator)"
  extends Interfaces.SingleShaft(final Pn=0, final omega_nom=0);
  parameter Modelica.SIunits.Power Pmax "Outlet maximum power";
  parameter Real r_electrical=0.2
    "Electrical damping of generator/shaft system";
  parameter Modelica.SIunits.Angle delta_start=0 "Loaded angle start value";

  ElectricGenerators.PowerSensor powerSensor annotation (Placement(
        transformation(extent={{20,-10},{40,10}}, rotation=0)));
  ElectricGenerators.FrequencySensor frequencySensor annotation (Placement(
        transformation(extent={{20,40},{40,60}}, rotation=0)));
  ElectricGenerators.Generator generator(
    eta=eta,
    J=J_shaft,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit) annotation (Placement(
        transformation(extent={{-100,-30},{-40,30}}, rotation=0)));
  ElectricGenerators.NetworkGrid_Pmax network(
    Pmax=Pmax,
    J=J_shaft,
    deltaStart=delta_start,
    fnom=fn,
    r=r_electrical,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    hasBreaker=false) annotation (Placement(transformation(extent={{80,-20},{
            120,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=d_shaft) annotation
    (Placement(transformation(extent={{-100,-60},{-80,-40}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
        transformation(extent={{-50,-86},{-30,-66}}, rotation=0)));
equation
  connect(SensorsBus.power, powerSensor.W) annotation (Line(points={{200,-80},{
          30,-80},{30,-9.4}}, color={255,170,213}));
  connect(SensorsBus.frequency, frequencySensor.f) annotation (Line(points={{
          200,-80},{60,-80},{60,50},{40.2,50}}, color={255,170,213}));
  connect(generator.shaft, shaft) annotation (Line(
      points={{-95.8,5.32907e-016},{-100,5.32907e-016},{-100,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));

  connect(generator.powerConnection, powerSensor.port_a) annotation (Line(
      points={{-44.2,5.32907e-016},{20,5.32907e-016},{20,0}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor.port, generator.powerConnection) annotation (Line(
      points={{20,50},{-20,50},{-20,5.32907e-016},{-44.2,5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(network.powerConnection, powerSensor.port_b) annotation (Line(
      points={{80,3.55271e-016},{40,3.55271e-016},{40,-0.2}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(damper.flange_a, shaft) annotation (Line(
      points={{-100,-50},{-140,-50},{-140,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(fixed.flange, damper.flange_b) annotation (Line(
      points={{-40,-76},{-40,-50},{-80,-50}},
      color={0,0,0},
      thickness=0.5));
  connect(SensorsBus.loadedAngle, network.delta_out) annotation (Line(points={{
          200,-80},{100,-80},{100,-18}}, color={255,170,213}));
  annotation (Diagram(graphics));
end GeneratorGroup_noBreaker;
