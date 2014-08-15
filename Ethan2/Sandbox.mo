within Ethan2;
model Sandbox

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ThermoPower3.Water.SourceW sourceW(
    w0=10,
    p0=100000,
    h=1e5) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  ThermoPower3.Water.SourceW sourceW1(
    w0=10,
    h=1e6,
    p0=10000000)
    annotation (Placement(transformation(extent={{-64,-84},{-44,-64}})));
  ThermoPower3.Water.SinkP sinkP(h=1e6, p0=10000000)
    annotation (Placement(transformation(extent={{4,-48},{24,-28}})));
  ThermoPower3.Water.SinkP sinkP1(
    p0=100000,
    R=0,
    h=1e5) annotation (Placement(transformation(extent={{-6,48},{14,68}})));
  UTubeSG uTubeSG
    annotation (Placement(transformation(extent={{-68,-32},{20,34}})));
equation

  connect(sourceW.flange, uTubeSG.flangetin) annotation (Line(
      points={{-60,-40},{-50,-40},{-50,-30.02},{-35.44,-30.02}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP.flange, uTubeSG.flangetout) annotation (Line(
      points={{4,-38},{-6,-38},{-6,-30.02},{-14.32,-30.02}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sourceW1.flange, uTubeSG.flangesin) annotation (Line(
      points={{-44,-74},{-24,-74},{-24,-33.32}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP1.flange, uTubeSG.flangesout) annotation (Line(
      points={{-6,58},{-22,58},{-22,35.32},{-24,35.32}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics));
end Sandbox;
