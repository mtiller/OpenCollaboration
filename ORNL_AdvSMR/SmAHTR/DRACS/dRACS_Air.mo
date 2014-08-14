within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_Air

  Modelica.Fluid.Pipes.DynamicPipe airUp(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nNodes=2,
    length=25,
    diameter=4.37,
    height_ab=25,
    m_flow_start=25,
    p_a_start=100000,
    p_b_start=100000,
    T_start=773.15,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60.5,-40})));

  Modelica.Fluid.Pipes.DynamicPipe airDown(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nNodes=2,
    m_flow_start=25,
    length=25,
    diameter=4.37,
    height_ab=-25,
    p_a_start=100000,
    p_b_start=100000,
    T_start=373.15,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60.5,-40})));
  Modelica.Fluid.Pipes.DynamicPipe airHX(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nNodes=8,
    diameter=4.37,
    m_flow_start=25,
    p_a_start=100000,
    p_b_start=100000,
    T_start=673.15,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-0.5,-100})));

  inner Modelica.Fluid.System system annotation (Placement(transformation(
          extent={{-180.5,159.5},{-160.5,179.5}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    use_p_in=false,
    p=100000,
    T=773.15,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60.5,30.5})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    use_p_in=false,
    p=100000,
    T=373.15,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60.5,30})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(
    alpha=0,
    Q_flow=3e6,
    T_ref=273.15) annotation (Placement(transformation(extent={{-30,-160},
            {-10,-140}})));
equation
  connect(airDown.port_b, airHX.port_a) annotation (Line(
      points={{60.5,-60},{60.5,-100},{19.5,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(airHX.port_b, airUp.port_a) annotation (Line(
      points={{-20.5,-100},{-60.5,-100},{-60.5,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.ports[1], airUp.port_b) annotation (Line(
      points={{-60.5,20.5},{-60.5,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary1.ports[1], airDown.port_a) annotation (Line(
      points={{60.5,20},{60.5,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fixedHeatFlow1.port, airHX.heatPorts[1]) annotation (Line(
      points={{-10,-150},{4.725,-150},{4.725,-108.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, airHX.heatPorts[8]) annotation (Line(
      points={{-10,-150},{-6,-150},{-6,-108.8},{-6.125,-108.8}},
      color={191,0,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        grid={1,1}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        grid={1,1})),
    experiment(
      StopTime=200,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput(equdistant=false));
end dRACS_Air;
