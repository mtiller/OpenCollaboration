within ORNL_AdvSMR.Interfaces;
partial model IntermediateHeatExchanger
  "Interface definition to intermediate heat exchanger"

  // Shell Side
  replaceable package shellMedium =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Shell fluid"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Shell Side"));

  // Tube Side
  replaceable package tubeMedium =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Tube fluid"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Tube Side"));

  import Modelica.SIunits.*;
  import Modelica.Constants.*;
  import Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.*;
  import Modelica.Fluid.Pipes.BaseClasses.FlowModels.*;

  // GENERAL DATA TAB
  //   final parameter Boolean useHeatTransfer=true
  //     "Select [true] to use the HeatTransfer 1/2 model"
  //     annotation (Dialog(tab="General", group="General Parameters"));

  // GEOMETRY TAB
  // General Parameters
  parameter Integer noAxialNodes=10 "Number of axial nodes"
    annotation (Dialog(tab="Geometry",group="General"));
  //   parameter Length flowPathLength(min=0) "Length of flow path for both fluids"  annotation (Dialog(tab="Geometry", group="General"));
  // Shell Side
  parameter Length shellDiameter=31.8e-3 "Shell inner diameter"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  parameter Area shellFlowArea=1.9799e-4
    "Cross sectional flow area in the bundle"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  parameter Length shellPerimeter=2.4936e-2 "Flow channel perimeter"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  replaceable model shellHeatTransfer = IdealFlowHeatTransfer constrainedby
    PartialFlowHeatTransfer "Heat transfer model" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(
      tab="Geometry",
      group="Shell Side",
      enable=useHeatTransfer));
  parameter Area shellHeatTrArea "Heat transfer area"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  replaceable model ShellFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Shell Side"));
  parameter Length shellRoughness=2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(tab="Geometry", group="Shell Side"));
  parameter Length shellWallThickness=19.05e-3
    "Shell wall thickness (for parasitic heat loss to the env)"
    annotation (Dialog(tab="Geometry", group="Shell Side"));

  // Tube Side
  parameter Length tubeDiameter=13.9e-3 "Cross sectional flow area in tubes"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  replaceable model tubeHeatTransfer = IdealFlowHeatTransfer constrainedby
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Heat transfer model" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(
      tab="Geometry",
      group="Tube Side",
      enable=useHeatTransfer));
  parameter Area tubeHeatTrArea "Heat transfer area"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  replaceable model TubeFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Tube Side"));
  parameter Length tubeRoughness=2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  parameter Length tubeWallThickness(min=0) = 1.975e-3 "Tube wall thickness"
    annotation (Dialog(tab="Geometry", group="Tube Side"));
  // Tube Wall Material Properties
  parameter Density tubeWallRho=7800 "Density of tube wall material"
    annotation (Dialog(tab="Geometry", group="Tube Wall Material Properties"));
  parameter SpecificHeatCapacity tubeWallCp=513
    "Specific heat capacity of tube wall material"
    annotation (Dialog(tab="Geometry", group="Tube Wall Material Properties"));
  parameter ThermalConductivity tubeWallK=26.22
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

  Interfaces.FlangeA shellInlet(redeclare package Medium = shellMedium)
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}}),
        iconTransformation(extent={{-110,40},{-90,60}})));
  Interfaces.FlangeB shellOutlet(redeclare package Medium = shellMedium)
    annotation (Placement(transformation(extent={{-90,90},{-70,110}}),
        iconTransformation(extent={{85,-45},{105,-25}})));
  Interfaces.FlangeA tubeInlet(redeclare package Medium = tubeMedium)
    annotation (Placement(transformation(extent={{70,90},{90,110}}),
        iconTransformation(extent={{-10,100},{10,120}})));
  Interfaces.FlangeB tubeOutlet(redeclare package Medium = tubeMedium)
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{-10,-120},{10,-100}})));

  ControlBus controlBus annotation (Placement(transformation(extent={{-20,-112},
            {20,-72}}), iconTransformation(extent={{75,-100},{95,-80}})));
  annotation (
    __Dymola_Images(Parameters(
        tab="Geometry",
        group="Shell Side",
        source="modelica:ORNL_AdvSMR/Icons/TriangularPitch.png")),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Bitmap(
          extent={{-102.5,100},{102.5,-100}},
          origin={-1,-1.42109e-014},
          rotation=180,
          fileName="modelica://ORNL_AdvSMR/Icons/HelicalCoilSteamGenerator.png")}));
end IntermediateHeatExchanger;
