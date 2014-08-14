within ORNL_AdvSMR.SmAHTR.IntermediateHeatTransportSystem;
model secondaryHeatTrLoop

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    isCircular=true,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=923.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,0})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    use_HeatTransfer=true,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    height_ab=0,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=823.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,60})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    nNodes=2,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=673.15,
    diameter=100e-3,
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
    m_flow_start=1,
    nNodes=2,
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    T_start=923.15,
    diameter=100e-3,
    p_a_start=100000,
    p_b_start=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={0,-60})));

  Modelica.Fluid.Vessels.OpenTank tank(
    nPorts=2,
    crossArea=10,
    height=1,
    level_start=0.5,
    use_T_start=true,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    p_ambient=100000,
    T_ambient=673.15,
    T_start=773.15,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3)}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={75,58})));
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts_a annotation (Placement(
        transformation(
        extent={{-20,-10},{20,10}},
        rotation=90,
        origin={-100,0}), iconTransformation(
        extent={{-40,-5},{40,5}},
        rotation=90,
        origin={-100,0})));
  Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{90,-90},{100,-80}})));
  Interfaces.Actuators actuators annotation (Placement(transformation(
          extent={{90,-70.5},{100,-60}}), iconTransformation(extent={{90,
            -70.5},{100,-60}})));
  Interfaces.FlangeB flangeB annotation (Placement(transformation(extent=
            {{40,-110},{60,-90}}), iconTransformation(extent={{40,-110},{
            60,-90}})));
  Interfaces.FlangeA flangeA annotation (Placement(transformation(extent=
            {{70,-110},{90,-90}}), iconTransformation(extent={{70,-110},{
            90,-90}})));
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
  connect(pipe.port_b, pipe1.port_a) annotation (Line(
      points={{-60,20},{-60,60},{-20,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe1.port_b, tank.ports[1]) annotation (Line(
      points={{20,60},{65,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe2.port_a, tank.ports[2]) annotation (Line(
      points={{60,20},{60,56},{65,56}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pipe3.heatPorts[1], heatPorts_b) annotation (Line(
      points={{2.9,-68.8},{2.9,-80.5},{80,-80.5},{80,4.5},{100,4.5},{100,
          0}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe3.heatPorts[2], heatPorts_b) annotation (Line(
      points={{-3.3,-68.8},{-3.3,-80.5},{80,-80.5},{80,0},{100,0}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe1.heatPorts[1], heatPorts_a) annotation (Line(
      points={{-2.9,68.8},{-2.9,80},{-85,80},{-85,0},{-100,0}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pipe1.heatPorts[2], heatPorts_a) annotation (Line(
      points={{3.3,68.8},{3,80},{-85,80},{-85,0},{-100,0}},
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
                radius=8),Text(
                extent={{-100,-60},{100,-80}},
                lineColor={175,175,175},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textStyle={TextStyle.Bold},
                textString="Intermediate Heat
Transport System")}),
    experiment(
      StopTime=100,
      NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput(equdistant=false));
end secondaryHeatTrLoop;
