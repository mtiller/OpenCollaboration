within Ethan2;
model PumpSystem "Simple Pump System Test"
  constant Real pi=3.14159265;
  parameter Integer Nnodes=50;
  ThermoPower3.Water.SourceW sourceW(
    w0=1,
    p0=6800000,
    h=2e6)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SinkP sinkP(
    h=1e5,
    R=1,
    p0=6800000)
    annotation (Placement(transformation(extent={{58,6},{78,26}})));
  ThermoPower3.Water.SensW sensW
    annotation (Placement(transformation(extent={{2,10},{22,30}})));
  ThermoPower3.Water.SinkP sinkP1(
    h=1e5,
    R=1,
    p0=6800000)
    annotation (Placement(transformation(extent={{58,-6},{78,-26}})));
  ThermoPower3.Water.SensW sensW1
    annotation (Placement(transformation(extent={{2,-10},{22,-30}})));
  UserInteraction.Outputs.NumericValue numericValue(hideConnector=false)
    annotation (Placement(transformation(extent={{42,44},{62,64}})));
  UserInteraction.Outputs.NumericValue numericValue1(hideConnector=false)
    annotation (Placement(transformation(extent={{44,-64},{64,-44}})));
  SteamDrumSeperator
              ms(
    pstart=6800000,
    Mlstart=200,
    Mvstart=20,
    Vnom=1)
    annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
  UserInteraction.Outputs.NumericValue numericValue2(hideConnector=true, input_Value=
       ms.x)
    annotation (Placement(transformation(extent={{-42,48},{-22,68}})));
equation
  connect(sensW.outlet, sinkP.flange) annotation (Line(
      points={{18,16},{58,16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensW1.outlet, sinkP1.flange) annotation (Line(
      points={{18,-16},{58,-16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue.Value, sensW.w) annotation (Line(
      points={{41,54},{32,54},{32,26},{20,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue1.Value, sensW1.w) annotation (Line(
      points={{43,-54},{32,-54},{32,-26},{20,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW.flange, ms.feed) annotation (Line(
      points={{-80,0},{-54,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.steam, sensW.inlet) annotation (Line(
      points={{-34.2,0},{-14,0},{-14,16},{6,16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.cond, sensW1.inlet) annotation (Line(
      points={{-44,-10},{-18,-10},{-18,-16},{6,-16}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),            graphics),
    experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end PumpSystem;
