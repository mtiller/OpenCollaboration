within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
model HelicalCoilSteamGenerator
  "Models the dynamics of a helical-coil steam generator using the moving-boundary approach"
  import aSMR = ORNL_AdvSMR;

  inner Modelica.Fluid.System system "Top-level system properties";

  import Modelica.SIunits.*;
  import Modelica.Constants.*;
  import Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.*;
  import Modelica.Fluid.Pipes.BaseClasses.FlowModels.*;

  // GENERAL DATA TAB
  // Shell-Side Parameters
  replaceable package shellFluid = ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_ph
    constrainedby ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium
    "Shell side working fluid" annotation (choicesAllMatching, Dialog(tab=
          "General", group="Shell Side"));
  parameter Length shellDiameter "Shell inner diameter"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Area shellFlowArea "Shell flow area"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Length shellWettedPerimeter "Shell wetted perimeter"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Area sheelHeatTrArea "Shell heat transfer area"
    annotation (Dialog(tab="General", group="Shell Side"));
  replaceable model shellHeatTrModel = IdealFlowHeatTransfer constrainedby
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Heat transfer model" annotation (choicesAllMatching, Dialog(tab="General",
        group="Shell Side"));
  replaceable model shellFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (choicesAllMatching, Dialog(
        tab="General", group="Shell Side"));
  parameter Length shellRoughness=2.5e-5
    "Absolute roughness (default: smooth steel)"
    annotation (Dialog(tab="General", group="Shell Side"));
  parameter Length shellWallThickness
    "Shell wall thickness (parasitic heat loss)"
    annotation (Dialog(tab="General", group="Shell Side"));

  // Tube-Side Parameters
  replaceable package tubeFluid = ORNL_AdvSMR.Media.Fluids.KFZrF4.KFZrF4_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Tube side working fluid" annotation (choicesAllMatching, Dialog(tab=
          "General", group="Tube Side"));
  parameter Length tubeDiameter "Tube inner diameter"
    annotation (Dialog(tab="General", group="Tube Side"));
  parameter Area tubeFlowArea "Tube flow area"
    annotation (Dialog(tab="General", group="Tube Side"));
  parameter Length tubeWettedPerimeter "Tube wetted perimeter"
    annotation (Dialog(tab="General", group="Tube Side"));
  replaceable model tubeHeatTrModel = IdealFlowHeatTransfer constrainedby
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Heat transfer model" annotation (choicesAllMatching, Dialog(tab="General",
        group="Tube Side"));
  replaceable model tubeFlowModel = DetailedPipeFlow constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Characteristic of wall friction" annotation (choicesAllMatching, Dialog(
        tab="General", group="Tube Side"));
  parameter Length tubeRoughness=2.5e-5
    "Absolute roughness of (default: smooth steel)"
    annotation (Dialog(tab="General", group="Tube Side"));
  parameter Length tubeWallThickness "Tube wall thickness"
    annotation (Dialog(tab="General", group="Tube Side"));

  ORNL_AdvSMR.Interfaces.FlangeA shellIn annotation (Placement(transformation(
          extent={{-90,30},{-70,50}}), iconTransformation(extent={{-90,25},{-60,
            55}})));
  ORNL_AdvSMR.Interfaces.FlangeA tubeIn annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100})));

  ORNL_AdvSMR.Interfaces.FlangeB tubeOut annotation (Placement(transformation(
          extent={{-10,90},{10,110}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));
  ORNL_AdvSMR.Interfaces.FlangeB shellOut annotation (Placement(transformation(
          extent={{70,-50},{90,-30}}), iconTransformation(extent={{60,-50},{90,
            -20}})));

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Bitmap(extent={{-91.5,91},{89.5,-91}},
          fileName="modelica://SMR/Icons/HelicalCoilSteamGenerator.png")}),
      Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Bitmap(extent={{-91.5,91},{89.5,-91}},
          fileName="modelica://aSMR/Icons/HelicalCoilSteamGenerator.png")}));

end HelicalCoilSteamGenerator;
