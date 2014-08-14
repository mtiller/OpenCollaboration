within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model sMR_PrimaryLoop

  sMR8 sMR
    annotation (Placement(transformation(extent={{-50,-50},{50,50}})));
  Modelica.Blocks.Sources.Constant const(k=2.1e6)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T=false,
    p=20000000,
    T=573.15)
    annotation (Placement(transformation(extent={{90,25},{70,45}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=10,
    use_m_flow_in=true,
    T=473.15)
    annotation (Placement(transformation(extent={{75,-45},{55,-25}})));
  Modelica.Blocks.Sources.Step step(
    height=-9,
    offset=10,
    startTime=50)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
equation
  connect(boundary1.ports[1], sMR.port_b) annotation (Line(
      points={{70,35},{58.75,35},{58.75,37.375},{47.5,37.375}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(const.y, sMR.u) annotation (Line(
      points={{-59,0},{-47.5,0}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(boundary2.ports[1], sMR.port_a) annotation (Line(
      points={{55,-35},{51.25,-35},{51.25,-37.5},{47.5,-37.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(step.y, boundary2.m_flow_in) annotation (Line(
      points={{79,-30},{79,-27},{75,-27}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end sMR_PrimaryLoop;
