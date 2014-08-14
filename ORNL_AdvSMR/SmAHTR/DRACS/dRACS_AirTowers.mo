within ORNL_AdvSMR.SmAHTR.DRACS;
model dRACS_AirTowers

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    m_flow_start=10,
    T_start=293.15,
    length=20,
    height_ab=20,
    diameter=20,
    roughness=2.5e-4,
    redeclare package Medium = ORNL_SMR.Media.Fluids.Air,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,0})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    m_flow_start=10,
    T_start=373.15,
    length=20,
    height_ab=-20,
    diameter=20,
    roughness=2.5e-4,
    redeclare package Medium = ORNL_SMR.Media.Fluids.Air,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,0})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    T_start=773.15,
    m_flow_start=10,
    diameter=20,
    redeclare package Medium = ORNL_SMR.Media.Fluids.Air,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={0,-60})));

  Interfaces.FlangeA airIn(redeclare package Medium =
        ORNL_SMR.Media.Fluids.Air)
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Interfaces.FlangeB airOut(redeclare package Medium =
        ORNL_SMR.Media.Fluids.Air)
    annotation (Placement(transformation(extent={{-110,45},{-90,65}})));
  Modelica.Fluid.Interfaces.HeatPorts_a airToSaltInterface annotation (
      Placement(transformation(
        extent={{-20,-5},{20,5}},
        rotation=90,
        origin={100,0}), iconTransformation(
        extent={{-40,-5},{40,5}},
        rotation=90,
        origin={100,0})));
  Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{90,-90},{100,-80}})));
  Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{90,-70},{100,-59.5}})));
equation
  connect(pipe2.port_b, pipe3.port_a) annotation (Line(
      points={{60,-20},{60,-60},{20,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe3.port_b, pipe.port_a) annotation (Line(
      points={{-20,-60},{-60,-60},{-60,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe.port_b, airOut) annotation (Line(
      points={{-60,20},{-60,55},{-100,55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(airIn, pipe2.port_a) annotation (Line(
      points={{-100,80},{60,80},{60,20}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe3.heatPorts[1], airToSaltInterface) annotation (Line(
      points={{2.9,-68.8},{3,-85},{80,-85},{80,0},{100,0}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe3.heatPorts[2], airToSaltInterface) annotation (Line(
      points={{-3.3,-68.8},{-3.5,-85},{80,-85},{80,0},{100,0}},
      color={127,0,0},
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
        grid={0.5,0.5}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={175,175,175},
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                radius=8),Bitmap(extent={{-90,95},{90,-85}}, fileName=
          "modelica://aSMR/Icons/DRACS Tower.png"),Text(
                extent={{-100,-80},{100,-100}},
                lineColor={175,175,175},
                lineThickness=0.5,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="DRACS Cooling Towers",
                textStyle={TextStyle.Bold})}),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput(equdistant=false));
end dRACS_AirTowers;
