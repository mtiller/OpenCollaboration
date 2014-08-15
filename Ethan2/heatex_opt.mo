within Ethan2;
model heatex_opt

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ThermoPower3.Water.HeatEx1D hx(
    hstarttubein=1e5,
    hstarttubeout=1e5,
    hstartshellin=1e6,
    hstartshellout=1e6,
    DynamicMomentum=true,
    L=2,
    Nt=200,
    Nnodes=3,
    pstarttube=100000,
    pstartshell=10000000)
    annotation (Placement(transformation(extent={{-22,-20},{18,20}})));
  ThermoPower3.Water.SourceW sourceW(
    w0=10,
    h=1e5,
    p0=100000)
           annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  ThermoPower3.Water.SourceW sourceW1(
    w0=10,
    p0=10000000,
    h=2.2e6)
    annotation (Placement(transformation(extent={{-26,44},{-6,64}})));
  ThermoPower3.Water.SinkP sinkP(h=1e6, p0=10000000)
    annotation (Placement(transformation(extent={{38,-62},{58,-42}})));
  ThermoPower3.Water.SinkP sinkP1(
    R=0,
    h=1e5,
    p0=100000)
     annotation (Placement(transformation(extent={{44,-10},{64,10}})));
equation

  connect(sourceW.flange, hx.flangetin) annotation (Line(
      points={{-58,0},{-22,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sourceW1.flange, hx.flangesin) annotation (Line(
      points={{-6,54},{10,54},{10,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP.flange, hx.flangesout) annotation (Line(
      points={{38,-52},{-14,-52},{-14,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP1.flange, hx.flangetout) annotation (Line(
      points={{44,0},{18,0}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics));
end heatex_opt;
