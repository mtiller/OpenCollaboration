within ORNL_AdvSMR.PRISM.CORE.old;
model testHTC

  Thermal.ConvHT_htc convHT_htc(N=4) annotation (Placement(transformation(
        extent={{-60,-20},{60,20}},
        rotation=270,
        origin={1.06581e-014,7.10543e-015})));
  Thermal.TempSource1D tempSource1D(N=4) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=100,
    duration=1,
    offset=400,
    startTime=1000)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  Thermal.TempSource1D tempSource1D1(redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
      N=4) annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={40,0})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    offset=400,
    startTime=1000,
    height=0) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(tempSource1D.wall, convHT_htc.otherside) annotation (Line(
      points={{-34,0},{-20,0},{-20,8.21565e-015},{-6,8.21565e-015}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(ramp.y, tempSource1D.temperature) annotation (Line(
      points={{-59,0},{-48,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, tempSource1D1.temperature) annotation (Line(
      points={{59,0},{48,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempSource1D1.wall, convHT_htc.fluidside) annotation (Line(
      points={{34,0},{20,0},{20,5.9952e-015},{6,5.9952e-015}},
      color={255,127,0},
      smooth=Smooth.None));
  convHT_htc.fluidside.gamma = 1e4*ones(4);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end testHTC;
