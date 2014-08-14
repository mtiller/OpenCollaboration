within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model sMR10
  "This model represents the primary heat transport system of a single reactor module."

  import Modelica.Math.*;
  import Modelica.SIunits.*;

  /* PARAMETERS */
  /* General Parameters */
  parameter Power Q_th=250e6 "Nominal Reactor Power (W)"
    annotation (Dialog(tab="General"));
  parameter Integer n_radial=4 "Number of Radial Zones"
    annotation (Dialog(tab="General"));
  parameter Integer n_axial=9 "Number of Axial Zones"
    annotation (Dialog(tab="General"));

  Modelica.Fluid.Pipes.DynamicPipe zone1(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    height_ab=10,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    nNodes=10,
    p_a_start=200000,
    p_b_start=100000,
    T_start=823.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-45,0})));

  Modelica.Fluid.Pipes.DynamicPipe downcomer(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    height_ab=-10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    nNodes=10,
    p_a_start=150000,
    p_b_start=100000,
    T_start=773.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));

  Modelica.Fluid.Vessels.OpenTank upperPlenum(
    level_start=0.5,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=100e-3),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        100e-3)},
    nPorts=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    height=4,
    crossArea=2,
    p_ambient=100000,
    T_ambient=873.15,
    T_start=823.15)
    annotation (Placement(transformation(extent={{20,65},{40,85}})));

  Modelica.Fluid.Machines.PrescribedPump saltPump(
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
    allowFlowReversal=false,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    use_N_in=false,
    m_flow_start=30,
    p_a_start=101325,
    p_b_start=101325,
    N_nominal=1000,
    V=0.5^3,
    T_start=773.15,
    show_NPSHa=true,
    N_const=100)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  Modelica.Fluid.Pipes.DynamicPipe xOver(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    redeclare package Medium = SMR.Media.Fluids.flibe_ph,
    diameter=100e-3,
    length=1,
    height_ab=0,
    nNodes=1,
    p_a_start=200000,
    p_b_start=100000,
    T_start=823.15,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,60})));
  Modelica.Fluid.Pipes.DynamicPipe downcomer1(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    nNodes=10,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height_ab=10,
    p_a_start=10000000,
    p_b_start=10000000,
    T_start=473.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={60,0})));

  Modelica.Fluid.Interfaces.FluidPort_a sec_in(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{85,-90},{105,-70}}), iconTransformation(
          extent={{95,-80},{105,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b sec_out(redeclare package Medium =
               Modelica.Media.Water.StandardWater) annotation (
      Placement(transformation(extent={{85,60},{105,80}}),
        iconTransformation(extent={{95,70},{105,80}})));
  Modelica.Fluid.Pipes.DynamicPipe downcomer2(
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_T_start=true,
    m_flow_start=1,
    length=10,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=100e-3,
    nNodes=10,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height_ab=10,
    p_a_start=10000000,
    p_b_start=10000000,
    T_start=473.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-65,0})));

  Modelica.Fluid.Interfaces.FluidPort_a dracs_in(redeclare package Medium =
               Modelica.Media.Water.StandardWater) annotation (
      Placement(transformation(extent={{-110,-100},{-90,-80}}),
        iconTransformation(extent={{-105,-90},{-95,-80}})));
  Modelica.Fluid.Interfaces.FluidPort_b dracs_out(redeclare package Medium =
               Modelica.Media.Water.StandardWater) annotation (
      Placement(transformation(extent={{-110,80},{-90,100}}),
        iconTransformation(extent={{-105,79.5},{-95,90}})));
equation

  connect(downcomer.port_b, saltPump.port_a) annotation (Line(
      points={{40,-10},{40,-60},{10,-60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(saltPump.port_b, zone1.port_a) annotation (Line(
      points={{-10,-60},{-45,-60},{-45,-10}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(xOver.port_b, upperPlenum.ports[1]) annotation (Line(
      points={{10,60},{28,60},{28,65}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.port_a, upperPlenum.ports[2]) annotation (Line(
      points={{40,10},{40,60},{32,60},{32,65}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(zone1.port_b, xOver.port_a) annotation (Line(
      points={{-45,10},{-45,60},{-10,60}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[1], downcomer.heatPorts[10]) annotation (
     Line(
      points={{55.6,-2.69},{49.55,-2.69},{49.55,-2.89},{44.4,-2.89}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[2], downcomer.heatPorts[9]) annotation (
      Line(
      points={{55.6,-2.07},{49.8,-2.07},{49.8,-2.27},{44.4,-2.27}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[3], downcomer.heatPorts[8]) annotation (
      Line(
      points={{55.6,-1.45},{50.3,-1.45},{50.3,-1.65},{44.4,-1.65}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[4], downcomer.heatPorts[7]) annotation (
      Line(
      points={{55.6,-0.83},{49.8,-0.83},{49.8,-1.03},{44.4,-1.03}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[5], downcomer.heatPorts[6]) annotation (
      Line(
      points={{55.6,-0.21},{50.3,-0.21},{50.3,-0.41},{44.4,-0.41}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[6], downcomer.heatPorts[5]) annotation (
      Line(
      points={{55.6,0.41},{50.3,0.41},{50.3,0.21},{44.4,0.21}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[7], downcomer.heatPorts[4]) annotation (
      Line(
      points={{55.6,1.03},{49.8,1.03},{49.8,0.83},{44.4,0.83}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[8], downcomer.heatPorts[3]) annotation (
      Line(
      points={{55.6,1.65},{50.05,1.65},{50.05,1.45},{44.4,1.45}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[9], downcomer.heatPorts[2]) annotation (
      Line(
      points={{55.6,2.27},{49.55,2.27},{49.55,2.07},{44.4,2.07}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.heatPorts[10], downcomer.heatPorts[1]) annotation (
     Line(
      points={{55.6,2.89},{50.05,2.89},{50.05,2.69},{44.4,2.69}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer1.port_a, sec_in) annotation (Line(
      points={{60,-10},{60,-80},{95,-80}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(sec_out, downcomer1.port_b) annotation (Line(
      points={{95,70},{60,70},{60,10}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer2.port_a, dracs_in) annotation (Line(
      points={{-65,-10},{-65,-90},{-100,-90}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dracs_out, downcomer2.port_b) annotation (Line(
      points={{-100,90},{-65,90},{-65,10}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer2.heatPorts[1], zone1.heatPorts[1]) annotation (Line(
      points={{-60.6,-2.69},{-54.55,-2.69},{-54.55,-2.69},{-49.4,-2.69}},
      color={127,0,0},
      smooth=Smooth.None));

  connect(downcomer2.heatPorts[2], zone1.heatPorts[2]) annotation (Line(
      points={{-60.6,-2.07},{-54.55,-2.07},{-54.55,-2.07},{-49.4,-2.07}},
      color={127,0,0},
      smooth=Smooth.None));

  connect(downcomer2.heatPorts[3], zone1.heatPorts[3]) annotation (Line(
      points={{-60.6,-1.45},{-54.8,-1.45},{-54.8,-1.45},{-49.4,-1.45}},
      color={127,0,0},
      smooth=Smooth.None));

  connect(downcomer2.heatPorts[4], zone1.heatPorts[4]) annotation (Line(
      points={{-60.6,-0.83},{-54.8,-0.83},{-54.8,-0.83},{-49.4,-0.83}},
      color={127,0,0},
      smooth=Smooth.None));

  connect(downcomer2.heatPorts[5], zone1.heatPorts[5]) annotation (Line(
      points={{-60.6,-0.21},{-54.8,-0.21},{-54.8,-0.21},{-49.4,-0.21}},
      color={127,0,0},
      smooth=Smooth.None));

  connect(downcomer2.heatPorts[6], zone1.heatPorts[6]) annotation (Line(
      points={{-60.6,0.41},{-54.8,0.41},{-54.8,0.41},{-49.4,0.41}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer2.heatPorts[7], zone1.heatPorts[7]) annotation (Line(
      points={{-60.6,1.03},{-54.8,1.03},{-54.8,1.03},{-49.4,1.03}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer2.heatPorts[8], zone1.heatPorts[8]) annotation (Line(
      points={{-60.6,1.65},{-55.05,1.65},{-55.05,1.65},{-49.4,1.65}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer2.heatPorts[9], zone1.heatPorts[9]) annotation (Line(
      points={{-60.6,2.27},{-55.05,2.27},{-55.05,2.27},{-49.4,2.27}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(downcomer2.heatPorts[10], zone1.heatPorts[10]) annotation (
      Line(
      points={{-60.6,2.89},{-54.55,2.89},{-54.55,2.89},{-49.4,2.89}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(dracs_in, dracs_in) annotation (Line(
      points={{-100,-90},{-100,-90}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={191,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,237},
                  fillPattern=FillPattern.Solid,
                  radius=8),Bitmap(extent={{-90,95.5},{90,-84.5}},
          fileName="modelica://aSMR/Icons/SMR.jpg"),Text(
                  extent={{-80,-80},{80,-100}},
                  lineColor={191,0,0},
                  lineThickness=0.5,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="S  M  R")}),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end sMR10;
