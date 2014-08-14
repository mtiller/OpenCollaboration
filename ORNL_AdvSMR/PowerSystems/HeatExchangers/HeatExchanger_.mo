within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model HeatExchanger_

  inner Modelica.Fluid.System system "Top-level system properties";

  import Modelica.SIunits.*;
  import Modelica.Constants.*;
  import Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.*;
  import Modelica.Fluid.Pipes.BaseClasses.FlowModels.*;

  // GENERAL DATA TAB
  // General Parameters
  parameter Length flowPathLength(min=0) "Length of flow path for both fluids"
    annotation (Dialog(tab="General", group="General Parameters"));
  parameter Boolean useHeatTransfer=false
    "Select [true] to use the HeatTransfer 1/2 model"
    annotation (Dialog(tab="General", group="General Parameters"));
  // Shell Side
  replaceable package ShellFluid = ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_ph
    constrainedby Modelica.Media.Interfaces.PartialMedium "Shell Working Fluid"
    annotation (choicesAllMatching, Dialog(tab="General", group="Shell Side"));
  parameter Length shellDiameter "Shell inner diameter"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Area shellFlowArea "Cross sectional flow area in shell side"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Length shellPerimeter "Flow channel perimeter"
    annotation (Dialog(tab="General", group="Shell Side"));
  replaceable model shellHeatTransfer = IdealFlowHeatTransfer constrainedby
    PartialFlowHeatTransfer "Heat transfer model" annotation (
      choicesAllMatching, Dialog(
      tab="General",
      group="Shell Side",
      enable=useHeatTransfer));
  parameter Area shellHeatTrArea "Heat transfer area"
    annotation (Dialog(tab="General", group="Shell Side"));
  replaceable model ShellFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (choicesAllMatching, Dialog(
        tab="General", group="Shell Side"));
  parameter Length shellRoughness=2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Length shellWallThickness
    "Shell wall thickness (for parasitic heat loss to the env)"
    annotation (Dialog(tab="General", group="Shell Side"));
  // Tube Side
  replaceable package TubeFluid = ORNL_AdvSMR.Media.Fluids.KFZrF4.KFZrF4_ph
    constrainedby Modelica.Media.Interfaces.PartialMedium "Tube Working Fluid"
    annotation (choicesAllMatching, Dialog(tab="General", group="Tube Side"));
  parameter Area tubeFlowArea "Cross sectional flow area in tubes"
    annotation (Dialog(tab="General", group="Tube Side"));
  parameter Length tubePerimeter "Flow channel perimeter"
    annotation (Dialog(tab="General", group="Tube Side"));
  replaceable model tubeHeatTransfer = IdealFlowHeatTransfer constrainedby
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Heat transfer model" annotation (choicesAllMatching, Dialog(
      tab="General",
      group="Tube Side",
      enable=useHeatTransfer));

  parameter Area tubeHeatTrArea "Heat transfer area"
    annotation (Dialog(tab="General", group="Tube Side"));
  replaceable model TubeFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (choicesAllMatching, Dialog(
        tab="General", group="Tube Side"));
  parameter Length tubeRoughness=2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(tab="General", group="Tube Side"));
  parameter Length tubeWallThickness(min=0) "Tube wall thickness"
    annotation (Dialog(tab="General", group="Tube Side"));
  // Tube Wall Material Properties
  parameter Density tubeWallRho "Density of tube wall material"
    annotation (Dialog(tab="General", group="Tube Wall Material Properties"));
  parameter SpecificHeatCapacity tubeWallCp
    "Specific heat capacity of tube wall material"
    annotation (Dialog(tab="General", group="Tube Wall Material Properties"));
  parameter ThermalConductivity tubeWallK
    "Thermal conductivity of tube wall material"
    annotation (Dialog(group="Tube Wall Material Properties"));

  final parameter Area meanHeatTrArea=(shellHeatTrArea + tubeHeatTrArea)/2
    "Mean Heat transfer area";
  final parameter Mass tubeWallMass=tubeWallRho*meanHeatTrArea*
      tubeWallThickness "Wall mass";

  // ASSUMPTIONS TAB
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions", group="System Dynamics"), Evaluate=
        true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balance" annotation (Evaluate=true, Dialog(tab=
          "Assumptions",group="System Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=system.massDynamics
    "Formulation of mass balance" annotation (Evaluate=true, Dialog(tab=
          "Assumptions", group="System Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balance, if pressureLoss options available"
    annotation (Evaluate=true, Dialog(tab="Assumptions", group=
          "System Dynamics"));

  // INITIALIZATION TAB
  // Shell Side
  parameter Modelica.SIunits.Temperature Twall_start
    "Start value of wall temperature"
    annotation (Dialog(tab="Initialization", group="Wall"));
  //parameter Modelica.SIunits.Temperature dT
  //   "Start value for pipe_1.T - pipe_2.T"           annotation (Dialog(tab="Initialization", group="Wall"));
  parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
    annotation (Evaluate=true, Dialog(tab="Initialization"));
  parameter ShellFluid.AbsolutePressure p_a_start1=ShellFluid.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Initialization", group="Shell Fluid"));
  parameter ShellFluid.AbsolutePressure p_b_start1=ShellFluid.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Initialization", group="Shell Fluid"));
  parameter ShellFluid.Temperature T_start_1=823.15
    "Start value of temperature" annotation (Evaluate=true, Dialog(
      tab="Initialization",
      group="Shell Fluid",
      enable=use_T_start));
  parameter ShellFluid.SpecificEnthalpy h_start_1=if use_T_start then
      ShellFluid.specificEnthalpy_pTX(
      (p_a_start1 + p_b_start1)/2,
      T_start_1,
      X_start_1[1:ShellFluid.nXi]) else ShellFluid.h_default
    "Start value of specific enthalpy" annotation (Evaluate=true, Dialog(
      tab="Initialization",
      group="Shell Fluid",
      enable=not use_T_start));
  parameter ShellFluid.MassFraction X_start_1[ShellFluid.nX]=ShellFluid.X_default
    "Start value of mass fractions m_i/m" annotation (Dialog(
      tab="Initialization",
      group="Shell Fluid",
      enable=(ShellFluid.nXi > 0)));
  parameter ShellFluid.MassFlowRate m_flow_start_1=system.m_flow_start
    "Start value of mass flow rate" annotation (Evaluate=true, Dialog(tab=
          "Initialization",group="Shell Fluid"));
  //Tube Side
  parameter TubeFluid.AbsolutePressure p_a_start2=TubeFluid.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Initialization", group="Tube Fluid"));
  parameter TubeFluid.AbsolutePressure p_b_start2=TubeFluid.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Initialization", group="Tube Fluid"));
  parameter TubeFluid.Temperature T_start_2=873.15 "Start value of temperature"
    annotation (Evaluate=true, Dialog(
      tab="Initialization",
      group="Tube Fluid",
      enable=use_T_start));
  parameter TubeFluid.SpecificEnthalpy h_start_2=if use_T_start then
      TubeFluid.specificEnthalpy_pTX(
      (p_a_start2 + p_b_start2)/2,
      T_start_2,
      X_start_2[1:TubeFluid.nXi]) else TubeFluid.h_default
    "Start value of specific enthalpy" annotation (Evaluate=true, Dialog(
      tab="Initialization",
      group="Tube Fluid",
      enable=not use_T_start));
  parameter TubeFluid.MassFraction X_start_2[TubeFluid.nX]=TubeFluid.X_default
    "Start value of mass fractions m_i/m" annotation (Dialog(
      tab="Initialization",
      group="Tube Fluid",
      enable=TubeFluid.nXi > 0));
  parameter TubeFluid.MassFlowRate m_flow_start_2=system.m_flow_start
    "Start value of mass flow rate" annotation (Evaluate=true, Dialog(tab=
          "Initialization",group="Tube Fluid"));

  Modelica.Fluid.Interfaces.FluidPort_a tubeInlet(redeclare package Medium =
        SMR.Media.Fluids.flibe_ph) annotation (Placement(transformation(extent=
            {{-102.5,37.5},{-77.5,62.5}}), iconTransformation(extent={{-85,80},
            {-65,100}})));
  Modelica.Fluid.Interfaces.FluidPort_a shellInlet(redeclare package Medium =
        SMR.Media.Fluids.KFZrF4_ph) annotation (Placement(transformation(extent
          ={{-102.5,-42.5},{-77.5,-17.5}}), iconTransformation(extent={{-110,-10},
            {-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b tubeOutlet(redeclare package Medium =
        SMR.Media.Fluids.flibe_ph) annotation (Placement(transformation(extent=
            {{77.5,37.5},{102.5,62.5}}), iconTransformation(extent={{65,80},{85,
            100}})));
  Modelica.Fluid.Interfaces.FluidPort_b shellOutlet(redeclare package Medium =
        SMR.Media.Fluids.KFZrF4_ph) annotation (Placement(transformation(extent
          ={{77.5,-42.5},{102.5,-17.5}}), iconTransformation(extent={{90,-10},{
            110,10}})));

  ThermoPower3.Water.Flow1D flow1D(N=4)
    annotation (Placement(transformation(extent={{-65,65},{-35,35}})));
  ThermoPower3.Water.Flow1D flow1D1(N=4)
    annotation (Placement(transformation(extent={{30,65},{60,35}})));
  ThermoPower3.Thermal.MetalTube metalTube(N=8)
    annotation (Placement(transformation(extent={{-100,-10},{100,10}})));
  ThermoPower3.Water.Flow1D flow1D2(N=4)
    annotation (Placement(transformation(extent={{-65,-45},{-35,-15}})));
  ThermoPower3.Water.Flow1D flow1D3(N=4)
    annotation (Placement(transformation(extent={{35,-45},{65,-15}})));
equation

  connect(flow1D.outfl, flow1D1.infl) annotation (Line(
      points={{-35,50},{30,50}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flow1D.wall, metalTube.int) annotation (Line(
      points={{-50,42.5},{-50,20},{0,20},{0,3}},
      color={255,127,0},
      smooth=Smooth.None,
      thickness=1));
  connect(flow1D1.wall, metalTube.int) annotation (Line(
      points={{45,42.5},{45,20},{0,20},{0,3}},
      color={255,127,0},
      smooth=Smooth.None,
      thickness=1));
  connect(flow1D1.outfl, tubeOutlet) annotation (Line(
      points={{60,50},{90,50}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(flow1D.infl, tubeInlet) annotation (Line(
      points={{-65,50},{-90,50}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D2.infl, shellInlet) annotation (Line(
      points={{-65,-30},{-90,-30}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D3.outfl, shellOutlet) annotation (Line(
      points={{65,-30},{90,-30}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D2.outfl, flow1D3.infl) annotation (Line(
      points={{-35,-30},{35,-30}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D2.wall, metalTube.ext) annotation (Line(
      points={{-50,-22.5},{-50,-15},{0,-15},{0,-3.1}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  connect(flow1D3.wall, metalTube.ext) annotation (Line(
      points={{50,-22.5},{50,-15},{0,-15},{0,-3.1}},
      color={255,127,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-115,-100},{115,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-115,-100},{115,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder),Polygon(
          points={{-60,95},{-60,64.5},{-62,72},{-58,72},{-60,64.5},{-60,95}},
          lineColor={95,95,95},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Polygon(
          points={{60,64.5},{60,95},{58,87.5},{62,87.5},{60,95},{60,64.5}},
          lineColor={95,95,95},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Polygon(
          points={{0,15.25},{0,-15.25},{-2,-7.75},{2,-7.75},{0,-15.25},{0,15.25}},
          lineColor={95,95,95},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          origin={-95,14.75},
          rotation=90),Text(
          extent={{-109,25},{-87,19.5}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          fontSize=16,
          horizontalAlignment=TextAlignment.Left,
          textString="Shell Inlet"),Text(
          extent={{87,17.5},{109,12}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          fontSize=16,
          textString="Shell Outlet",
          horizontalAlignment=TextAlignment.Left),Text(
          extent={{-11,2.75},{11,-2.75}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={-52.5,78.75},
          rotation=270,
          horizontalAlignment=TextAlignment.Left,
          textString="Tube Inlet",
          fontSize=16),Text(
          extent={{-12.5,2.75},{12.5,-2.75}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={52.75,82.5},
          rotation=90,
          fontSize=16,
          horizontalAlignment=TextAlignment.Left,
          textString="Tube Outlet"),Polygon(
          points={{-77.5,80},{-77.5,30},{-67.5,-40},{-52.5,-40},{-42.5,30},{-37.5,
            30},{-27.5,-40},{-12.5,-40},{-2.5,30},{2.5,30},{12.5,-40},{27.5,-40},
            {37.5,29.5},{42.5,29.5},{52.5,-40.5},{67.5,-40.5},{77.5,30},{77.5,
            80},{72.5,80},{72.5,30},{62.5,-35},{57.5,-35},{47.5,35},{32.5,35},{
            23,-35},{17.5,-35},{7.5,35},{-7.5,35},{-17,-35},{-22.5,-35},{-32.5,
            35},{-47.5,35},{-57.5,-35},{-62.5,-35},{-72.5,30},{-72.5,80},{-77.5,
            80}},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          smooth=Smooth.None,
          fillColor={255,85,85},
          pattern=LinePattern.None),Text(
          extent={{-100,-60},{100,-75}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          fontSize=24,
          textString="Shell-and-Tube Heat Exchanger")}));
end HeatExchanger_;
