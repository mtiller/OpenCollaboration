within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model sMR_PrimaryLoop3

  sMR10 sMR(Q_th=10000e6)
    annotation (Placement(transformation(extent={{-50,-50},{50,50}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T=false,
    p=20000000,
    T=573.15) annotation (Placement(transformation(extent={{90,27.5},{
            70,47.5}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=10,
    use_m_flow_in=true,
    T=673.15) annotation (Placement(transformation(extent={{75,-47.5},{
            55,-27.5}})));
  Modelica.Blocks.Sources.Step step(
    offset=10,
    startTime=500,
    height=0) annotation (Placement(transformation(extent={{95,-34.5},{
            85,-24.5}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary3(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=10,
    use_m_flow_in=true,
    T=673.15) annotation (Placement(transformation(extent={{-75,-52.5},
            {-55,-32.5}})));
  Modelica.Blocks.Sources.Step step1(
    height=0,
    startTime=0,
    offset=2) annotation (Placement(transformation(extent={{-95,-39.5},
            {-85,-29.5}})));
  Modelica.Fluid.Sources.FixedBoundary boundary4(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_T=false,
    p=20000000,
    T=573.15)
    annotation (Placement(transformation(extent={{-90,35},{-70,55}})));
equation
  connect(boundary2.m_flow_in, step.y) annotation (Line(
      points={{75,-29.5},{84.5,-29.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary2.ports[1], sMR.sec_in) annotation (Line(
      points={{55,-37.5},{50,-37.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sMR.sec_out, boundary1.ports[1]) annotation (Line(
      points={{50,37.5},{70,37.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary3.ports[1], sMR.dracs_in) annotation (Line(
      points={{-55,-42.5},{-50,-42.5}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(step1.y, boundary3.m_flow_in) annotation (Line(
      points={{-84.5,-34.5},{-75,-34.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary4.ports[1], sMR.dracs_out) annotation (Line(
      points={{-70,45},{-60,45},{-60,42.375},{-50,42.375}},
      color={0,127,255},
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
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end sMR_PrimaryLoop3;
