within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples.OldSwingEquation;
model TripleShaft_SE
  "Alternator group in configuration triple-shaft (three generator)"
  extends
    SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.TripleShaft;
  parameter Modelica.SIunits.Power Pmax_A "Outlet maximum power"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Modelica.SIunits.Angle delta_start_A "Loaded angle start value"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Modelica.SIunits.Power Pmax_B "Outlet maximum power"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Modelica.SIunits.Angle delta_start_B "Loaded angle start value"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Modelica.SIunits.Power Pmax_C "Outlet maximum power"
    annotation (Dialog(group="Generator-Shaft C"));
  parameter Modelica.SIunits.Angle delta_start_C "Loaded angle start value"
    annotation (Dialog(group="Generator-Shaft C"));

  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_A annotation (Placement(transformation(extent={{10,
            110},{30,130}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_A annotation (Placement(transformation(extent={
            {10,150},{30,170}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_B annotation (Placement(transformation(extent={{10,
            -10},{30,10}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_B annotation (Placement(transformation(extent={
            {10,30},{30,50}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_C annotation (Placement(transformation(extent={{10,
            -130},{30,-110}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_C annotation (Placement(transformation(extent={
            {10,-90},{30,-70}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Grid_3in grid_3in(
      Pn=Pn, fn=fn) annotation (Placement(transformation(extent={{
            140,-20},{180,20}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE_A(
    eta=eta_A,
    Pmax=Pmax_A,
    J=J_shaft_A,
    delta_start=delta_start_A,
    omega_nom=omega_nom_A) annotation (Placement(transformation(
          extent={{-120,90},{-60,150}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE_B(
    eta=eta_B,
    Pmax=Pmax_B,
    J=J_shaft_B,
    delta_start=delta_start_B,
    omega_nom=omega_nom_B) annotation (Placement(transformation(
          extent={{-120,-30},{-60,30}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE_B1(
    eta=eta_C,
    Pmax=Pmax_C,
    J=J_shaft_C,
    delta_start=delta_start_C,
    omega_nom=omega_nom_C) annotation (Placement(transformation(
          extent={{-120,-150},{-60,-90}}, rotation=0)));
equation
  connect(SensorsBus.power_shaftC, powerSensor_C.W) annotation (
      Line(points={{200,-80},{120,-80},{120,-140},{20,-140},{20,-129.4}},
        color={255,170,213}));
  connect(SensorsBus.frequency_shaftC, frequencySensor_C.f)
    annotation (Line(points={{200,-80},{60,-80},{60,-80},{30.2,-80}},
        color={255,170,213}));
  connect(SensorsBus.power_shaftB, powerSensor_B.W) annotation (
      Line(points={{200,-80},{60,-80},{60,-20},{20,-20},{20,-9.4}},
        color={255,170,213}));
  connect(SensorsBus.frequency_shaftB, frequencySensor_B.f)
    annotation (Line(points={{200,-80},{60,-80},{60,40},{30.2,40}},
        color={255,170,213}));
  connect(SensorsBus.power_shaftA, powerSensor_A.W) annotation (
      Line(points={{200,-80},{60,-80},{60,100},{20,100},{20,110.6}},
        color={255,170,213}));
  connect(SensorsBus.frequency_shaftA, frequencySensor_A.f)
    annotation (Line(points={{200,-80},{60,-80},{60,160},{30.2,160}},
        color={255,170,213}));
  connect(generator_SE_B1.powerConnection, powerSensor_C.port_a)
    annotation (Line(
      points={{-68.4,-120},{10,-120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_C.port, generator_SE_B1.powerConnection)
    annotation (Line(
      points={{10,-80},{-20,-80},{-20,-120},{-68.4,-120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(powerSensor_B.port_a, generator_SE_B.powerConnection)
    annotation (Line(
      points={{10,0},{-6.8,0},{-6.8,5.32907e-016},{-68.4,
          5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(frequencySensor_B.port, generator_SE_B.powerConnection)
    annotation (Line(
      points={{10,40},{-20,40},{-20,5.32907e-016},{-68.4,
          5.32907e-016}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(powerSensor_A.port_a, generator_SE_A.powerConnection)
    annotation (Line(
      points={{10,120},{-68.4,120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_A.port, generator_SE_A.powerConnection)
    annotation (Line(
      points={{10,160},{-20,160},{-20,120},{-68.4,120}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(generator_SE_A.shaft, shaft_A) annotation (Line(
      points={{-117,120},{-200,120}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_SE_B.shaft, shaft_B) annotation (Line(
      points={{-117,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_SE_B1.shaft, shaft_C) annotation (Line(
      points={{-117,-120},{-200,-120}},
      color={0,0,0},
      thickness=0.5));
  connect(grid_3in.connection_A, powerSensor_A.port_b) annotation (
      Line(
      points={{142.8,16},{100,16},{100,119.8},{30,119.8}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(grid_3in.connection_B, powerSensor_B.port_b) annotation (
      Line(
      points={{142.8,3.55271e-016},{51.7,3.55271e-016},{51.7,-0.2},
          {30,-0.2}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(grid_3in.connection_C, powerSensor_C.port_b) annotation (
      Line(
      points={{142.8,-16},{100,-16},{100,-120.2},{30,-120.2}},
      pattern=LinePattern.None,
      thickness=0.5));
  annotation (Diagram(graphics));
end TripleShaft_SE;
