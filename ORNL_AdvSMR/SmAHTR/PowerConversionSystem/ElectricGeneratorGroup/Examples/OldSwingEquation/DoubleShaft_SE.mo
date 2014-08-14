within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples.OldSwingEquation;
model DoubleShaft_SE
  "Alternator group in configuration double-shaft (two generator)"
  extends
    SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Interfaces.DoubleShaft;
  parameter Modelica.SIunits.Power Pmax_A "Outlet maximum power"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Modelica.SIunits.Angle delta_start_A "Loaded angle start value"
    annotation (Dialog(group="Generator-Shaft A"));
  parameter Modelica.SIunits.Power Pmax_B "Outlet maximum power"
    annotation (Dialog(group="Generator-Shaft B"));
  parameter Modelica.SIunits.Angle delta_start_B "Loaded angle start value"
    annotation (Dialog(group="Generator-Shaft B"));

  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_A annotation (Placement(transformation(extent={{20,
            90},{40,110}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_A annotation (Placement(transformation(extent={
            {20,130},{40,150}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.PowerSensor
    powerSensor_B annotation (Placement(transformation(extent={{20,
            -110},{40,-90}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.FrequencySensor
    frequencySensor_B annotation (Placement(transformation(extent={
            {20,-70},{40,-50}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.Grid_2in grid(Pn=
        Pn, fn=fn) annotation (Placement(transformation(extent={{
            140,-20},{178,20}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE_A(
    eta=eta_A,
    Pmax=Pmax_A,
    J=J_shaft_A,
    delta_start=delta_start_A,
    omega_nom=omega_nom_A) annotation (Placement(transformation(
          extent={{-100,70},{-40,130}}, rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGenerators.OldElementsSwingEquation.Generator_SE
    generator_SE_B(
    eta=eta_B,
    Pmax=Pmax_B,
    J=J_shaft_B,
    delta_start=delta_start_B,
    omega_nom=omega_nom_B) annotation (Placement(transformation(
          extent={{-100,-130},{-40,-70}}, rotation=0)));

equation
  connect(SensorsBus.power_shaftA, powerSensor_A.W) annotation (
      Line(points={{200,-80},{140,-80},{140,-60},{80,-60},{80,40},{
          30,40},{30,90.6}}, color={255,170,213}));
  connect(SensorsBus.power_shaftB, powerSensor_B.W) annotation (
      Line(points={{200,-80},{140,-80},{140,-120},{30,-120},{30,-109.4}},
        color={255,170,213}));
  connect(SensorsBus.frequency_shaftA, frequencySensor_A.f)
    annotation (Line(points={{200,-80},{140,-80},{140,-60},{80,-60},
          {80,140},{40.2,140}}, color={255,170,213}));
  connect(SensorsBus.frequency_shaftB, frequencySensor_B.f)
    annotation (Line(points={{200,-80},{140,-80},{140,-60},{40.2,-60}},
        color={255,170,213}));
  connect(powerSensor_B.port_b, grid.connection_B) annotation (Line(
      points={{40,-100.2},{46,-100.2},{46,-100},{100,-100},{100,-8},
          {142.66,-8}},
      pattern=LinePattern.None,
      thickness=0.5));

  connect(grid.connection_A, powerSensor_A.port_b) annotation (Line(
      points={{142.66,8},{100,8},{100,99.8},{40,99.8}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(generator_SE_B.powerConnection, powerSensor_B.port_a)
    annotation (Line(
      points={{-48.4,-100},{20,-100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_B.port, generator_SE_B.powerConnection)
    annotation (Line(
      points={{20,-60},{0,-60},{0,-100},{-48.4,-100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(powerSensor_A.port_a, generator_SE_A.powerConnection)
    annotation (Line(
      points={{20,100},{-48.4,100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(frequencySensor_A.port, generator_SE_A.powerConnection)
    annotation (Line(
      points={{20,140},{0,140},{0,100},{-48.4,100}},
      pattern=LinePattern.None,
      thickness=0.5));
  connect(generator_SE_A.shaft, shaft_A) annotation (Line(
      points={{-97,100},{-202,100}},
      color={0,0,0},
      thickness=0.5));
  connect(generator_SE_B.shaft, shaft_B) annotation (Line(
      points={{-97,-100},{-200,-100}},
      color={0,0,0},
      thickness=0.5));
  annotation (Diagram(graphics));
end DoubleShaft_SE;
