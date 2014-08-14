within ORNL_AdvSMR.Sensors;
model Test_SensT_1p
  Components.SourceW sourceW(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=100,
    h=1e6) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.SinkP sinkP(redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=4e6) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Components.Flow1D pipe(
    L=1,
    A=0.125,
    omega=1,
    Dhyd=0.5,
    wnom=10,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Kfnom,
    Kfnom=10,
    N=10,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    hstartin=1e6,
    hstartout=1e6,
    dpnom=100000)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  inner System system
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  SensT1 sensT_1p(redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na)
    annotation (Placement(transformation(extent={{-30,16},{-10,36}})));
  SensT1 sensT_1p1(redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na)
    annotation (Placement(transformation(extent={{10,14},{30,34}})));
  Thermal.HeatSource1D heatSource1D(
    N=10,
    L=1,
    omega=1) annotation (Placement(transformation(extent={{-10,-20},{10,-40}})));
  Modelica.Blocks.Sources.Step step(
    startTime=500,
    offset=1e6,
    height=1e6)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
equation
  connect(pipe.infl, sourceW.flange) annotation (Line(
      points={{-10,0},{-40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pipe.outfl, sinkP.flange) annotation (Line(
      points={{10,0},{40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensT_1p1.flange, sinkP.flange) annotation (Line(
      points={{20,20},{20,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatSource1D.wall, pipe.wall) annotation (Line(
      points={{0,-27},{0,-5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(step.y, heatSource1D.power) annotation (Line(
      points={{-19,-50},{0,-50},{0,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensT_1p.flange, sourceW.flange) annotation (Line(
      points={{-20,22},{-20,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end Test_SensT_1p;
