within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model IntermediateHeatExchanger
  "PRISM sodium-to-sodium intermediate heat exchanger"

  extends ORNL_AdvSMR.Interfaces.IntermediateHeatExchanger(redeclare package
      shellMedium = ORNL_AdvSMR.Media.Fluids.Na, redeclare package tubeMedium
      = ORNL_AdvSMR.Media.Fluids.Na);

  // Number of axial nodes
  parameter Integer noAxialNodes=10 "Number of axial nodes";

  import Modelica.SIunits.*;
  import Modelica.Constants.*;
  import Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.*;
  import Modelica.Fluid.Pipes.BaseClasses.FlowModels.*;

  // GENERAL DATA TAB
  // General Parameters
  parameter Length flowPathLength(min=0) "Length of flow path for both fluids"
    annotation (Dialog(tab="General", group="General Parameters"));
  /*  parameter Boolean useHeatTransfer=false 
    "Select [true] to use the HeatTransfer 1/2 model"
    annotation (Dialog(tab="General", group="General Parameters"));
*/
  // Shell Side
  parameter Length shellDiameter "Shell inner diameter"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  parameter Area shellFlowArea "Cross sectional flow area in shell side"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  parameter Length shellPerimeter "Flow channel perimeter"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  replaceable model shellHeatTransfer = IdealFlowHeatTransfer constrainedby
    PartialFlowHeatTransfer "Heat transfer model" annotation (
      choicesAllMatching, Dialog(
      tab="Geometry",
      group="Shell Side",
      enable=useHeatTransfer));
  parameter Area shellHeatTrArea "Heat transfer area"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  replaceable model ShellFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (choicesAllMatching, Dialog(
        tab="Geometry", group="Shell Side"));
  parameter Length shellRoughness=2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  parameter Length shellWallThickness
    "Shell wall thickness (for parasitic heat loss to the env)"
    annotation (Dialog(tab="Geometry", group="Shell Side"));

  // Tube Side
  replaceable package tubeMedium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Tube fluid"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Tube Side"));

  parameter Area tubeFlowArea "Cross sectional flow area in tubes"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  parameter Length tubePerimeter "Flow channel perimeter"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  replaceable model tubeHeatTransfer = IdealFlowHeatTransfer constrainedby
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Heat transfer model" annotation (choicesAllMatching, Dialog(
      tab="Geometry",
      group="Tube Side",
      enable=useHeatTransfer));
  parameter Area tubeHeatTrArea "Heat transfer area"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  replaceable model TubeFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (choicesAllMatching, Dialog(
        tab="Geometry", group="Tube Side"));
  parameter Length tubeRoughness=2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  parameter Length tubeWallThickness(min=0) "Tube wall thickness"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  // Tube Wall Material Properties
  parameter Density tubeWallRho "Density of tube wall material"
    annotation (Dialog(tab="Geometry", group="Tube Wall Material Properties"));
  parameter SpecificHeatCapacity tubeWallCp
    "Specific heat capacity of tube wall material"
    annotation (Dialog(tab="Geometry", group="Tube Wall Material Properties"));
  parameter ThermalConductivity tubeWallK
    "Thermal conductivity of tube wall material"
    annotation (Dialog(tab="Geometry", group="Tube Wall Material Properties"));

  final parameter Area meanHeatTrArea=(shellHeatTrArea + tubeHeatTrArea)/2
    "Mean Heat transfer area";
  final parameter Mass tubeWallMass=tubeWallRho*meanHeatTrArea*
      tubeWallThickness "Wall mass";

  // ASSUMPTIONS TAB
  parameter Boolean allowFlowReversal
    "allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions", group="System Dynamics"), Evaluate=
        true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics
    "Formulation of energy balance" annotation (Evaluate=true, Dialog(tab=
          "Assumptions",group="System Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics
    "Formulation of mass balance" annotation (Evaluate=true, Dialog(tab=
          "Assumptions", group="System Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics
    "Formulation of momentum balance, if pressureLoss options available"
    annotation (Evaluate=true, Dialog(tab="Assumptions", group=
          "System Dynamics"));

  // INITIALIZATION TAB
  // Shell Side
  parameter Modelica.SIunits.Temperature Twall_start
    "Start value of wall temperature"
    annotation (Dialog(tab="Initialization", group="Wall"));
  parameter Modelica.SIunits.Temperature dT
    "Start value for pipe_1.T - pipe_2.T"
    annotation (Dialog(tab="Initialization", group="Wall"));
  parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
    annotation (Evaluate=true, Dialog(tab="Initialization"));

  Components.PipeFlow tube(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    hstartin=1.08e6,
    hstartout=1.08e6,
    redeclare package Medium = tubeMedium,
    nNodes=noAxialNodes,
    L=5.04,
    A=1.5217e-4,
    omega=4.3728e-2,
    Dhyd=1.3392e-2,
    wnom=1152.9,
    dpnom(displayUnit="kPa") = 131000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    H=5.04,
    Nt=2139,
    pstart=100000) annotation (Placement(transformation(
        extent={{40,-40},{-40,40}},
        rotation=90,
        origin={80,-0.5})));

  Components.PipeFlow shell(
    redeclare package Medium = shellMedium,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    hstartin=8.88e5,
    hstartout=8.88e5,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=noAxialNodes,
    L=5.04,
    H=5.04,
    A=1.9799e-4,
    omega=2.4936e-2,
    Dhyd=3.1758e-2,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    Nt=2139*2,
    pstart=100000) annotation (Placement(transformation(
        extent={{-40,40},{40,-40}},
        rotation=90,
        origin={-80,0})));

  Thermal.MetalTube metalTube(
    N=noAxialNodes,
    L=5.04,
    lambda=18.80,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    rint=13.3919e-3/2,
    rext=13.3919e-3/2 + 0.9779e-3,
    WallRes=true,
    rhomcm=8030*550) annotation (Placement(transformation(
        extent={{-40.25,-10},{40.25,10}},
        rotation=270,
        origin={0,-0.25})));

  Thermal.ConvHT_htc convHT_htc(N=noAxialNodes) annotation (Placement(
        transformation(
        extent={{-40.25,-10},{40.25,10}},
        rotation=90,
        origin={-35,-0.25})));

  Thermal.CounterCurrent counterCurrent(N=noAxialNodes, counterCurrent=true)
    annotation (Placement(transformation(
        extent={{-40.25,-10},{40.25,10}},
        rotation=90,
        origin={20,-0.25})));

  Thermal.ConvHT_htc convHT_htc1(N=noAxialNodes) annotation (Placement(
        transformation(
        extent={{-40.25,10},{40.25,-10}},
        rotation=90,
        origin={40,-0.25})));

equation
  connect(shell.infl, shellInlet) annotation (Line(
      points={{-80,-40},{-80,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(shellOutlet, shell.outfl) annotation (Line(
      points={{-80,100},{-80,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(tubeInlet, tube.infl) annotation (Line(
      points={{80,100},{80,39.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(tube.outfl, tubeOutlet) annotation (Line(
      points={{80,-40.5},{80,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(metalTube.int, counterCurrent.side1) annotation (Line(
      points={{3,-0.25},{17,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc.fluidside, shell.wall) annotation (Line(
      points={{-38,-0.25},{-47,-0.25},{-47,-0.2},{-60,-0.2}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc.otherside, metalTube.ext) annotation (Line(
      points={{-32,-0.25},{-3,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrent.side2, convHT_htc1.otherside) annotation (Line(
      points={{23.1,-0.25},{37,-0.25}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc1.fluidside, tube.wall) annotation (Line(
      points={{43,-0.25},{50.5,-0.25},{50.5,-0.3},{60,-0.3}},
      color={255,127,0},
      smooth=Smooth.None));
  for i in 1:noAxialNodes loop
    shell.wall.gamma[i] = 7.5e4;
    tube.wall.gamma[i] = 7.5e4;
  end for;

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Text(
          extent={{-45.25,7.5},{45.25,-7.5}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          origin={-52.5,-15.25},
          rotation=90,
          textString="PRISM  IHX")}));
end IntermediateHeatExchanger;
