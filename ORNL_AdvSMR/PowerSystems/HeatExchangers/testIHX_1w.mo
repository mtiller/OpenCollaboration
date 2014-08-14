within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model testIHX_1w

  IntermediateHeatExchanger intermediateHeatExchanger(
    flowPathLength=1,
    shellDiameter=1,
    shellFlowArea=1,
    shellPerimeter=1,
    shellHeatTrArea=1,
    shellWallThickness=1,
    tubeFlowArea=1,
    tubePerimeter=1,
    tubeHeatTrArea=1,
    tubeWallThickness=1,
    tubeWallRho=1,
    tubeWallCp=11,
    tubeWallK=1)
    annotation (Placement(transformation(extent={{-60,-60},{60,60}})));
  Components.SourceW shellIn(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1126.4,
    h=28.8858e3 + 1.2753e3*(468 + 273),
    p0=100000)
    annotation (Placement(transformation(extent={{-85,19.5},{-70,34.5}})));
  Components.SourceW tubeIn(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1152.9,
    h=28.8858e3 + 1.2753e3*(282 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=270,
        origin={0,87.5})));
  Components.SinkP shellOut(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    h=28.8858e3 + 1.2753e3*(319 + 273),
    p0=100000)
    annotation (Placement(transformation(extent={{70,-31.5},{85,-16.5}})));
  Components.SinkP tubeOut(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=270,
        origin={0,-92.5})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    startTime=5000,
    offset=28.8858e3 + 1.2753e3*(468 + 273),
    height=1.2753e3*10) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=270,
        origin={-74.5,62.5})));

equation
  connect(shellIn.flange, intermediateHeatExchanger.shellInlet) annotation (
      Line(
      points={{-70,27},{-65,27},{-65,30},{-60,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.flange, intermediateHeatExchanger.tubeInlet) annotation (Line(
      points={{-1.33227e-015,80},{0,80},{0,66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(shellOut.flange, intermediateHeatExchanger.shellOutlet) annotation (
      Line(
      points={{70,-24},{63.5,-24},{63.5,-21},{57,-21}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, intermediateHeatExchanger.tubeOutlet) annotation (
      Line(
      points={{1.33227e-015,-85},{0,-85},{0,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ramp2.y, shellIn.in_h) annotation (Line(
      points={{-74.5,54.25},{-74.5,31.5}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end testIHX_1w;
