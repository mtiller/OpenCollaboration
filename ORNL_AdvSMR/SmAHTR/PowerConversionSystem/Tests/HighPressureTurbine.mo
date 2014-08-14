within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.Tests;
model HighPressureTurbine
  import aSMR = ORNL_AdvSMR;

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      w_fixed=314.16/2, useSupport=false) annotation (Placement(
        transformation(extent={{85,-10},{65,10}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceP sourceP(
    h=3167.3e3,
    allowFlowReversal=false,
    p0=23500000)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  ORNL_AdvSMR.Components.SinkP sinkP(
    h=2893e3,
    p0=7000000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{65,-90},{85,-70}})));
  ORNL_AdvSMR.Components.SteamTurbineStodola stage1(
    PRstart=235/70,
    wnom=1722.47,
    Kt=0.005,
    wstart=1722.47,
    allowFlowReversal=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    pnom=23500000)
    annotation (Placement(transformation(extent={{-45,-40},{35,40}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = ThermoPower3.Water.StandardWater,
    length=1,
    diameter=50e-3,
    height_ab=-1,
    use_T_start=false,
    h_start=3167.3e3,
    allowFlowReversal=false,
    p_a_start=23500000,
    p_b_start=23500000,
    m_flow_start=1750) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-65,55.5})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = ThermoPower3.Water.StandardWater,
    length=1,
    diameter=50e-3,
    height_ab=-1,
    use_T_start=false,
    h_start=2893e3,
    p_a_start=7000000,
    p_b_start=7000000,
    m_flow_start=1750) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-60})));
  inner ORNL_AdvSMR.System system
    annotation (Placement(transformation(extent={{75,75},{95,95}})));
equation
  connect(constantSpeed.flange, stage1.shaft_b) annotation (Line(
      points={{65,0},{35,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe.port_b, stage1.inlet) annotation (Line(
      points={{-65,45.5},{-65,40},{-45,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(stage1.outlet, pipe1.port_a) annotation (Line(
      points={{35,-40},{60,-40},{60,-50}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe1.port_b, sinkP.flange) annotation (Line(
      points={{60,-70},{60,-80},{65,-80}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe.port_a, sourceP.flange) annotation (Line(
      points={{-65,65.5},{-65,70},{-70,70}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(StopTime=10, Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end HighPressureTurbine;
