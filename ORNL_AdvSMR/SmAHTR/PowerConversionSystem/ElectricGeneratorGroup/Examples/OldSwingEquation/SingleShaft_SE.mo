within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples.OldSwingEquation;
model SingleShaft_SE
  "Alternator group in configuration single-shaft (one generator)"
  extends
    SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.SingleShaft;
  parameter Modelica.SIunits.Power Pmax "Outlet maximum power";
  parameter Modelica.SIunits.Angle delta_start "Loaded angle start value";

  SmAHTR.PowerConversionSystem.ElectricGenerators.Grid grid(fn=fn,
      Pn=Pn) annotation (Placement(transformation(extent={{60,-20},
            {100,20}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor annotation (Placement(transformation(extent={{0,-10},
            {20,10}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor annotation (Placement(transformation(extent={{0,
            20},{20,40}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE(
    eta=eta,
    Pmax=Pmax,
    J=J_shaft,
    delta_start=delta_start,
    omega_nom=omega_nom) annotation (Placement(transformation(
          extent={{-120,-30},{-60,30}}, rotation=0)));
equation
  connect(SensorsBus.power, powerSensor.W) annotation (Line(points=
          {{200,-80},{10,-80},{10,-9.4}}, color={255,170,213}));
  connect(SensorsBus.frequency, frequencySensor.f) annotation (Line(
        points={{200,-80},{34,-80},{34,30},{20.2,30}}, color={255,
          170,213}));
  connect(generator_SE.shaft, shaft) annotation (Line(
      points={{-117,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_SE.powerConnection, powerSensor.port_a)
    annotation (Line(
      points={{-68.4,5.32907e-016},{-8.8,5.32907e-016},{-8.8,0},{0,
          0}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(powerSensor.port_b, grid.connection) annotation (Line(
      points={{20,-0.2},{48,-0.2},{48,3.55271e-016},{62.8,
          3.55271e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(frequencySensor.port, generator_SE.powerConnection)
    annotation (Line(
      points={{0,30},{-20,30},{-20,5.32907e-016},{-68.4,
          5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  annotation (Diagram(graphics));
end SingleShaft_SE;
