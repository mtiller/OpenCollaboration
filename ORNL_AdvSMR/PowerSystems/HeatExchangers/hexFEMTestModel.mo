within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model hexFEMTestModel

  replaceable package shellMedium = ORNL_AdvSMR.Media.Fluids.KFZrF4.KFZrF4_ph
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  replaceable package tubeMedium = ORNL_AdvSMR.Media.Fluids.KFZrF4.KFZrF4_ph
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  HeatExchangers.HeatExchangerFEM heatExchangerFEM(Nnodes=10)
    annotation (Placement(transformation(extent={{-40,-80},{40,0}})));
  Components.SourceW shellMassFlow(
    w0=1,
    redeclare package Medium = shellMedium,
    h=2e5,
    p0=125000)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Components.SinkP sinkP(redeclare package Medium = shellMedium, p0=100000)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Components.SourceW tubeMassFlow(
    redeclare package Medium = tubeMedium,
    w0=2,
    p0=100000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,20})));
  Components.SinkP sinkP1(redeclare package Medium = tubeMedium, h=2e5)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,20})));
  inner System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=0,
    startTime=250,
    offset=5e5,
    height=-1e5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,80})));
  Modelica.Blocks.Math.Add addEnthalpy annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,40})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=0,
    startTime=500,
    offset=5e5,
    height=2e5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,80})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=0,
    startTime=400,
    height=-1,
    offset=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,30})));
  Modelica.Blocks.Math.Add addFlow annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-74,-10})));
  Modelica.Blocks.Sources.Ramp ramp3(
    duration=0,
    offset=1,
    startTime=800,
    height=0.5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,30})));
equation
  connect(shellMassFlow.flange, heatExchangerFEM.shellInlet) annotation (Line(
      points={{-60,-40},{-40,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sinkP.flange, heatExchangerFEM.shellOutlet) annotation (Line(
      points={{60,-40},{40,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(tubeMassFlow.flange, heatExchangerFEM.tubeInlet) annotation (Line(
      points={{30,10},{30,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sinkP1.flange, heatExchangerFEM.tubeOutlet) annotation (Line(
      points={{-30,10},{-30,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ramp1.y, addEnthalpy.u1) annotation (Line(
      points={{20,69},{20,60},{16,60},{16,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, addEnthalpy.u2) annotation (Line(
      points={{-10,69},{-10,60},{4,60},{4,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(addEnthalpy.y, tubeMassFlow.in_h) annotation (Line(
      points={{10,29},{10,16},{24,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp3.y, addFlow.u1) annotation (Line(
      points={{-60,19},{-60,10},{-68,10},{-68,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp2.y, addFlow.u2) annotation (Line(
      points={{-90,19},{-90,10},{-80,10},{-80,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(addFlow.y, shellMassFlow.in_w0) annotation (Line(
      points={{-74,-21},{-74,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end hexFEMTestModel;
