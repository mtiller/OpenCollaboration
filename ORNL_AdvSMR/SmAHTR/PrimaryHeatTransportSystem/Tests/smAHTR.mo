within ORNL_AdvSMR.SmAHTR.PrimaryHeatTransportSystem.Tests;
model smAHTR
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

  Modelica.Fluid.Interfaces.HeatPorts_b heatPorts_b annotation (
      Placement(transformation(
        extent={{-20,-10},{20,10}},
        rotation=90,
        origin={-100,0}), iconTransformation(
        extent={{-40,-5},{40,5}},
        rotation=90,
        origin={100,0})));
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts_a annotation (
      Placement(transformation(
        extent={{-20,-10},{20,10}},
        rotation=-90,
        origin={100,3.55271e-015}), iconTransformation(
        extent={{-40,-5},{40,5}},
        rotation=-90,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-85,-95})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-60,-95})));
  Modelica.Blocks.Interfaces.RealInput u2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-30,-95})));
  Interfaces.Sensors sensors annotation (Placement(transformation(
          extent={{90,-90},{100,-80}}), iconTransformation(extent={{90,
            -85},{100,-75}})));
  Interfaces.Actuators actuators annotation (Placement(transformation(
          extent={{90,-70},{100,-59.5}}), iconTransformation(extent={{
            90,-65.5},{100,-55}})));
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
                  lineThickness=0.5,
                  fillColor={255,255,237},
                  fillPattern=FillPattern.Solid,
                  radius=8),Bitmap(extent={{-95,95},{85,-85}}, fileName=
           "modelica://aSMR/Icons/SMR.jpg"),Text(
                  extent={{-100,-75},{100,-95}},
                  lineColor={175,175,175},
                  lineThickness=0.5,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
                  textString="S  m  A  H  T  R")}),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end smAHTR;
