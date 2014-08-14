within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model sMR_PrimaryLoop2

  sMR9 sMR annotation (Placement(transformation(extent={{-60,-50},{39.5,
            50}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T=false,
    p=20000000,
    T=573.15) annotation (Placement(transformation(extent={{70,27.5},{
            50,47.5}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=10,
    use_m_flow_in=true,
    T=473.15)
    annotation (Placement(transformation(extent={{70,-48},{50,-28}})));
  Modelica.Blocks.Sources.Step step(
    height=-9,
    offset=10,
    startTime=50)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Constant const(k=10e6)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(boundary1.ports[1], sMR.port_b) annotation (Line(
      points={{50,37.5},{49.75,37.5},{49.75,37.375},{37.0125,37.375}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(boundary2.ports[1], sMR.port_a) annotation (Line(
      points={{50,-38},{50,-37.5},{37.0125,-37.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(const.y, sMR.u) annotation (Line(
      points={{-69,0},{-57.5125,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary2.m_flow_in, step.y) annotation (Line(
      points={{70,-30},{79,-30}},
      color={0,0,127},
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
end sMR_PrimaryLoop2;
