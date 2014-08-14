within ORNL_AdvSMR.SmAHTR.CORE;
model End2End

  inner ORNL_AdvSMR.System system;
  replaceable package Medium = ThermoPower3.Media.FlueGas annotation (
      __Dymola_choicesAllMatching=true);

  ReactorCoreBlock reactorCoreBlock(redeclare final replaceable package Medium
      =        Medium)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Fluid.Sources.FixedBoundary sinkP(
    h=2728.2e3,
    nPorts=1,
    redeclare package Medium = ThermoPower3.Media.FlueGas,
    p=12000000,
    T=623.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  Modelica.Fluid.Sources.MassFlowSource_T sourceW(
    nPorts=1,
    m_flow=10,
    redeclare package Medium = ThermoPower3.Media.FlueGas,
    T=593.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));

  Modelica.Blocks.Sources.Ramp ramp(
    duration=50,
    offset=0,
    startTime=500,
    height=1e-1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

equation
  connect(sinkP.ports[1], reactorCoreBlock.flangeB) annotation (Line(
      points={{0,60},{0,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sourceW.ports[1], reactorCoreBlock.flangeA) annotation (Line(
      points={{0,-60},{0,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ramp.y, reactorCoreBlock.rho_CR) annotation (Line(
      points={{-39,0},{-20,0}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
            {{-100,-100},{100,100}}), graphics));
end End2End;
