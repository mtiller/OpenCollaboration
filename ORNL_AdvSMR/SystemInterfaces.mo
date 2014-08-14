within ORNL_AdvSMR;
package SystemInterfaces
  "This package contains partial models for system interfaces"

  extends Modelica.Icons.InterfacesPackage;

  partial model PassiveHeatRejectionSystems
    "Interface description for passive heat rejection systems"

    /* CORE Coolant Channel Paramters */
    replaceable package DRACSFluid =
        ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "DRACS coolant"
      annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="DRACS", group="Coolant Media"));
    replaceable package Air =
        Modelica.Media.Interfaces.PartialSimpleIdealGasMedium constrainedby
      Modelica.Media.Interfaces.PartialSimpleIdealGasMedium "Air" annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="DRACS", group="Coolant Media"));

    ORNL_AdvSMR.Interfaces.FlangeB toPHTS(redeclare package Medium = DRACSFluid)
      annotation (Placement(transformation(extent={{90,31},{110,51}}),
          iconTransformation(extent={{95,50},{115,70}})));
    ORNL_AdvSMR.Interfaces.FlangeA fromPHTS(redeclare package Medium =
          DRACSFluid) annotation (Placement(transformation(extent={{90,-30},{
              110,-50}}), iconTransformation(extent={{95,-70},{115,-50}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(
          extent={{-20,20},{20,-20}},
          rotation=180,
          origin={0,-86})));

    Thermal.DHThtc dHT annotation (Placement(transformation(extent={{92,-20},{
              112,20}}), iconTransformation(extent={{96,-20},{112,20}})));
    annotation (
      __Dymola_Images(Parameters(
          tab="CORE Coolant Channel",
          group="Flow Geometry",
          source="C:/Users/mfc/SkyDrive/Documents/Icons/TriangularPitch.png")),

      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-105,100},{105,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Rectangle(
              extent={{-90,90},{90,-60}},
              lineColor={175,175,175},
              fillColor={223,220,216},
              fillPattern=FillPattern.Solid,
              radius=1),Text(
              extent={{-100,-65.5},{100,-75.5}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="PASSIVE HEAT REJECTION SYSTEMS",
              textStyle={TextStyle.Bold})}),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);

  end PassiveHeatRejectionSystems;

  partial model RVACS
    "Interface description for reactor vessel auxiliary cooling system (RVACS)"

    /* CORE Coolant Channel Paramters */
    replaceable package DRACSFluid =
        ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "DRACS coolant"
      annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="DRACS", group="Coolant Media"));
    replaceable package Air =
        Modelica.Media.Interfaces.PartialSimpleIdealGasMedium constrainedby
      Modelica.Media.Interfaces.PartialSimpleIdealGasMedium "Air" annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="DRACS", group="Coolant Media"));

    ORNL_AdvSMR.Interfaces.FlangeB toPHTS(redeclare package Medium = DRACSFluid)
      annotation (Placement(transformation(extent={{90,31},{110,51}}),
          iconTransformation(extent={{95,40},{115,60}})));
    ORNL_AdvSMR.Interfaces.FlangeA fromPHTS(redeclare package Medium =
          DRACSFluid) annotation (Placement(transformation(extent={{90,-50},{
              110,-30}}), iconTransformation(extent={{95,-60},{115,-40}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(
          extent={{-20,20},{20,-20}},
          rotation=180,
          origin={0,-95})));

    annotation (
      __Dymola_Images(Parameters(
          tab="CORE Coolant Channel",
          group="Flow Geometry",
          source="C:/Users/mfc/SkyDrive/Documents/Icons/TriangularPitch.png")),

      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-105,100},{105,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Rectangle(
              extent={{-90,90},{90,-60}},
              lineColor={175,175,175},
              fillColor={223,220,216},
              fillPattern=FillPattern.Solid,
              radius=1),Text(
              extent={{-100,-65.5},{100,-75.5}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="DRACS")}),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);

  end RVACS;

  partial model RxPrimaryHeatTransportSystem
    "Interface description for reactor and primary heat transport system"

    /* CORE Coolant Channel Paramters */
    replaceable package PrimaryFluid =
        ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
      annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="Coolant Channel", group="Coolant Medium"));

    ORNL_AdvSMR.Interfaces.FlangeB toIHX(redeclare package Medium =
          PrimaryFluid) "Primary coolant exiting the reactor" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={100,40}), iconTransformation(extent={{90,50},{110,70}})));
    ORNL_AdvSMR.Interfaces.FlangeA fromIHX(redeclare package Medium =
          PrimaryFluid) "Primary coolant entering the reactor" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={100,-40}), iconTransformation(extent={{90,-70},{110,-50}})));
    ORNL_AdvSMR.Interfaces.FlangeA fromDRACS(redeclare package Medium =
          PrimaryFluid) "DRACS coolant entering the reactor" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-100,60}), iconTransformation(extent={{-110,50},{-90,70}})));
    ORNL_AdvSMR.Interfaces.FlangeB toDRACS(redeclare package Medium =
          PrimaryFluid) "DRACS coolant exiting the reactor" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-100,-60}), iconTransformation(extent={{-110,-70},{-90,-50}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus
      "Local PHTS bus for sensor and actuator communications" annotation (
        Placement(transformation(extent={{-110,-110},{-70,-70}}),
          iconTransformation(extent={{-20,-106},{20,-66}})));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={175,175,175},
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            radius=2),
          Rectangle(
            extent={{-80,80},{80,-60}},
            lineColor={175,175,175},
            fillColor={223,220,216},
            fillPattern=FillPattern.Solid,
            radius=1),
          Text(
            extent={{-100,-66},{100,-74}},
            lineColor={135,135,135},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="PRIMARY HEAT TRANSPORT SYSTEM",
            textStyle={TextStyle.Bold})}),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end RxPrimaryHeatTransportSystem;

  partial model IntermediateHeatExchanger
    "Interface definition to intermediate heat exchanger"

    import Modelica.SIunits.*;
    import Modelica.Constants.*;
    import Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.*;
    import Modelica.Fluid.Pipes.BaseClasses.FlowModels.*;

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

    // GENERAL DATA TAB
    //   final parameter Boolean useHeatTransfer=true
    //     "Select [true] to use the HeatTransfer 1/2 model"
    //     annotation (Dialog(tab="General", group="General Parameters"));

    //   // GEOMETRY TAB
    //   // General Parameters
    //   parameter Integer noAxialNodes=10 "Number of axial nodes"
    //     annotation(Dialog(tab="Geometry", group="General"));
    //     //   parameter Length flowPathLength(min=0) "Length of flow path for both fluids"  annotation (Dialog(tab="Geometry", group="General"));
    //   // Shell Side
    //   parameter Length shellDiameter=31.8e-3 "Shell inner diameter"
    //     annotation (Dialog(tab="Geometry", group="Shell Side"));
    //   parameter Area shellFlowArea=1.9799e-4
    //     "Cross sectional flow area in the bundle"
    //     annotation (Dialog(tab="Geometry", group="Shell Side"));
    //   parameter Length shellPerimeter=2.4936e-2 "Flow channel perimeter"
    //     annotation (Dialog(tab="Geometry", group="Shell Side"));
    //   replaceable model shellHeatTransfer = IdealFlowHeatTransfer
    //     constrainedby PartialFlowHeatTransfer "Heat transfer model"
    //     annotation (Evaluate=true, choicesAllMatching=true,
    //     Dialog(
    //       tab="Geometry",
    //       group="Shell Side",
    //       enable=useHeatTransfer));
    //   parameter Area shellHeatTrArea "Heat transfer area"  annotation (Dialog(tab="Geometry", group="Shell Side"));
    //   replaceable model ShellFlowModel = DetailedPipeFlow constrainedby
    //     Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    //     "Characteristic of wall friction" annotation (Evaluate=true,
    //     choicesAllMatching=true,
    //       Dialog(tab="Geometry", group="Shell Side"));
    //   parameter Length shellRoughness=2.5e-5
    //     "Absolute roughness of pipe (default = smooth steel pipe)"
    //     annotation (Dialog(tab="Geometry", group="Shell Side"));
    //   parameter Length shellWallThickness=19.05e-3
    //     "Shell wall thickness (for parasitic heat loss to the env)"
    //     annotation (Dialog(tab="Geometry", group="Shell Side"));
    //
    //   // Tube Side
    //   parameter Length tubeDiameter=13.9e-3 "Cross sectional flow area in tubes"
    //     annotation (Dialog(tab="Geometry", group="Tube Side"));
    //   replaceable model tubeHeatTransfer = IdealFlowHeatTransfer
    //     constrainedby
    //     Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    //     "Heat transfer model" annotation (Evaluate=true,
    //     choicesAllMatching=true, Dialog(
    //       tab="Geometry",
    //       group="Tube Side",
    //       enable=useHeatTransfer));
    //   parameter Area tubeHeatTrArea "Heat transfer area"  annotation (Dialog(tab="Geometry", group="Tube Side"));
    //   replaceable model TubeFlowModel = DetailedPipeFlow constrainedby
    //     Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    //     "Characteristic of wall friction" annotation (Evaluate=true,
    //     choicesAllMatching=true,
    //       Dialog(tab="Geometry", group="Tube Side"));
    //   parameter Length tubeRoughness=2.5e-5
    //     "Absolute roughness of pipe (default = smooth steel pipe)"
    //     annotation (Dialog(tab="Geometry", group="Tube Side"));
    //   parameter Length tubeWallThickness(min=0)=1.975e-3 "Tube wall thickness"
    //     annotation (Dialog(tab="Geometry", group="Tube Side"));
    //   // Tube Wall Material Properties
    //   parameter Density tubeWallRho=7800 "Density of tube wall material"
    //     annotation (Dialog(tab="Geometry", group=
    //           "Tube Wall Material Properties"));
    //   parameter SpecificHeatCapacity tubeWallCp=513
    //     "Specific heat capacity of tube wall material" annotation (Dialog(tab=
    //          "Geometry", group="Tube Wall Material Properties"));
    //   parameter ThermalConductivity tubeWallK=26.22
    //     "Thermal conductivity of tube wall material" annotation (Dialog(tab=
    //           "Geometry", group="Tube Wall Material Properties"));
    //
    //   final parameter Area meanHeatTrArea=(shellHeatTrArea + tubeHeatTrArea)/2
    //     "Mean Heat transfer area";
    //   final parameter Mass tubeWallMass=tubeWallRho*meanHeatTrArea*
    //       tubeWallThickness "Wall mass";
    //
    //   // ASSUMPTIONS TAB
    //   parameter Boolean allowFlowReversal
    //     "allow flow reversal, false restricts to design direction (port_a -> port_b)"
    //     annotation (Dialog(tab="Assumptions", group="System Dynamics"),
    //       Evaluate=true);
    //   parameter Modelica.Fluid.Types.Dynamics energyDynamics
    //     "Formulation of energy balance" annotation (Evaluate=true, Dialog(tab=
    //          "Assumptions", group="System Dynamics"));
    //   parameter Modelica.Fluid.Types.Dynamics massDynamics
    //     "Formulation of mass balance" annotation (Evaluate=true, Dialog(tab=
    //           "Assumptions", group="System Dynamics"));
    //   parameter Modelica.Fluid.Types.Dynamics momentumDynamics
    //     "Formulation of momentum balance, if pressureLoss options available"
    //     annotation (Evaluate=true, Dialog(tab="Assumptions", group=
    //           "System Dynamics"));
    //
    //   // INITIALIZATION TAB
    //   // Shell Side
    //   parameter Modelica.SIunits.Temperature Twall_start
    //     "Start value of wall temperature"
    //     annotation (Dialog(tab="Initialization", group="Wall"));
    //   parameter Modelica.SIunits.Temperature dT
    //     "Start value for pipe_1.T - pipe_2.T"
    //     annotation (Dialog(tab="Initialization", group="Wall"));
    //   parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
    //     annotation (Evaluate=true, Dialog(tab="Initialization"));

    ORNL_AdvSMR.Interfaces.FlangeA shellInlet(redeclare package Medium =
          shellMedium) annotation (Placement(transformation(extent={{-90,-110},
              {-70,-90}}), iconTransformation(extent={{-110,50},{-90,70}})));
    ORNL_AdvSMR.Interfaces.FlangeB shellOutlet(redeclare package Medium =
          shellMedium) annotation (Placement(transformation(extent={{-90,90},{-70,
              110}}), iconTransformation(extent={{90,-50},{110,-30}})));
    ORNL_AdvSMR.Interfaces.FlangeA tubeInlet(redeclare package Medium =
          tubeMedium) annotation (Placement(transformation(extent={{70,90},{90,
              110}}), iconTransformation(extent={{-10,90},{10,110}})));
    ORNL_AdvSMR.Interfaces.FlangeB tubeOutlet(redeclare package Medium =
          tubeMedium) annotation (Placement(transformation(extent={{70,-110},{
              90,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(extent={{-20,-112},{20,-72}}), iconTransformation(
            extent={{-80,-106},{-40,-66}})));

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
          grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Rectangle(
              extent={{-85,85},{85,-55}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,-64},{100,-74}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              textString="INTERMEDIATE HEAT EXCHANGER")}));

  end IntermediateHeatExchanger;

  partial model IntermediateHeatTransportSystem

    replaceable package IntermediateFluid =
        ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium
      "Intermediate fluid" annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="Geometry"));

    ORNL_AdvSMR.Interfaces.FlangeA fromIHX(redeclare package Medium =
          IntermediateFluid) annotation (Placement(transformation(extent={{-110,
              20},{-90,40}}), iconTransformation(extent={{-105,25},{-90,40}})));
    ORNL_AdvSMR.Interfaces.FlangeB toIHX(redeclare package Medium =
          IntermediateFluid) annotation (Placement(transformation(extent={{-110,
              -40},{-90,-20}}), iconTransformation(extent={{-105,-35},{-90,-20}})));
    ORNL_AdvSMR.Interfaces.FlangeA fromSG(redeclare package Medium =
          IntermediateFluid) annotation (Placement(transformation(extent={{90,-40},
              {110,-20}}), iconTransformation(extent={{95,-35},{110,-20}})));
    ORNL_AdvSMR.Interfaces.FlangeB toSG(redeclare package Medium =
          IntermediateFluid) annotation (Placement(transformation(extent={{90,
              20},{110,40}}), iconTransformation(extent={{90,45},{105,60}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(extent={{-10,-100},{10,-80}}), iconTransformation(
            extent={{-20,-106},{20,-66}})));

    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Rectangle(
              extent={{-85,85},{85,-55}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,-64},{100,-74}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="INTERMEDIATE HEAT TRANSPORT SYSTEM",
              textStyle={TextStyle.Bold})}),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end IntermediateHeatTransportSystem;

  partial model SteamGenerator "Interface definition for steam generator"

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
        ORNL_AdvSMR.Media.Interfaces.PartialTwoPhaseMedium constrainedby
      ORNL_AdvSMR.Media.Interfaces.PartialTwoPhaseMedium "Tube fluid"
      annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="Geometry", group="Tube Side"));

    ORNL_AdvSMR.Interfaces.FlangeA shellInlet(redeclare package Medium =
          shellMedium) annotation (Placement(transformation(extent={{-90,-110},
              {-70,-90}}), iconTransformation(extent={{-100,35},{-80,55}})));
    ORNL_AdvSMR.Interfaces.FlangeB shellOutlet(redeclare package Medium =
          shellMedium) annotation (Placement(transformation(extent={{-90,90},{-70,
              110}}), iconTransformation(extent={{80,-50},{100,-30}})));
    ORNL_AdvSMR.Interfaces.FlangeA tubeInlet(redeclare package Medium =
          tubeMedium) annotation (Placement(transformation(extent={{70,90},{90,
              110}}), iconTransformation(extent={{-10,100},{10,120}})));
    ORNL_AdvSMR.Interfaces.FlangeB tubeOutlet(redeclare package Medium =
          tubeMedium) annotation (Placement(transformation(extent={{70,-110},{
              90,-90}}), iconTransformation(extent={{-10,-120},{10,-100}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(extent={{-59,-40},{-39,-20}}),iconTransformation(
            extent={{-80,-108},{-40,-68}})));

    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Rectangle(
              extent={{-80,80},{80,-60}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,-63.5},{100,-73.5}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              textString="STEAM GENERATOR")}));
  end SteamGenerator;

  partial model PowerConversionSystem
    "Interface description for power conversion system"

    replaceable package powerFluid =
        Modelica.Media.Interfaces.PartialTwoPhaseMedium constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Power conversion system working fluid" annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="Geometry", group="Shell Side"));

    ORNL_AdvSMR.Interfaces.FlangeA steamInlet(redeclare package Medium =
          powerFluid) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-100,60}), iconTransformation(extent={{-110,50},{-90,70}})));
    ORNL_AdvSMR.Interfaces.FlangeB condensateReturn(redeclare package Medium =
          powerFluid) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-100,-60}), iconTransformation(extent={{-110,-70},{-90,-50}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b rotorShaft annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={100,0}), iconTransformation(extent={{90,-10},{110,10}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(extent={{-10,-108},{10,-88}}), iconTransformation(
            extent={{-10,-104},{10,-84}})));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Text(
              extent={{-140,-50},{140,-62}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Power Conversion System"),Bitmap(extent={{-80,136},{
            80,-92}}, fileName="modelica://ORNL_AdvSMR/Icons/Steam Turbine.jpg"),
            Text(
              extent={{-13,4},{13,-4}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={-86,61},
              rotation=90,
              textString="Steam Inlet",
              fontSize=12),Text(
              extent={{-20,5},{20,-5}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={-85,-60},
              rotation=90,
              textString="Condensate Return",
              fontSize=12),Text(
              extent={{-20,3},{20,-3}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={87,0},
              rotation=270,
              textString="Rotor Shaft",
              fontSize=12)}),
      experiment(
        StopTime=1000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-007,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end PowerConversionSystem;

  partial model HydrogenPlant
    "Interface description for hydrogen production plant"

    replaceable package powerFluid =
        Modelica.Media.Interfaces.PartialTwoPhaseMedium constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Power conversion system working fluid" annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="Geometry", group="Shell Side"));

    ORNL_AdvSMR.Interfaces.FlangeA steamInlet(redeclare package Medium =
          powerFluid) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-100,60}), iconTransformation(extent={{-110,50},{-90,70}})));
    ORNL_AdvSMR.Interfaces.FlangeB condensateReturn(redeclare package Medium =
          powerFluid) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-100,-60}), iconTransformation(extent={{-110,-70},{-90,-50}})));
    ORNL_AdvSMR.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(extent={{-10,-108},{10,-88}}), iconTransformation(
            extent={{-20,-108},{20,-68}})));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Text(
              extent={{-140,-64},{140,-76}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="HYDROGEN PRODUCTION PLANT",
              textStyle={TextStyle.Bold}),Rectangle(
              extent={{-83,81},{87,-59}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid)}),
      experiment(
        StopTime=1000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-007,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end HydrogenPlant;

  partial model ModularPowerConversionSystem
    "Interface description for power conversion system"

    parameter Integer noSteamLines=3
      "Number of steam lines from intermediate heat transport system";

    replaceable package powerMedium =
        Modelica.Media.Interfaces.PartialTwoPhaseMedium constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Power conversion system working fluid" annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="Geometry", group="Shell Side"));

    FlangeA[noSteamLines] steamInlet(redeclare package Medium = powerMedium)
      annotation (Placement(transformation(extent={{-210,70},{-190,90}}),
          iconTransformation(extent={{-220,80},{-180,120}})));
    FlangeB condensateReturn(redeclare package Medium = powerMedium)
      annotation (Placement(transformation(extent={{-210,-90},{-190,-70}}),
          iconTransformation(extent={{-220,-120},{-180,-80}})));
    ControlBus controlBus annotation (Placement(transformation(extent={{-40,-190},
              {40,-110}}), iconTransformation(extent={{-30.5,-175},{30,-115}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b rotorShaft annotation (
        Placement(transformation(extent={{180,-20},{220,20}}),
          iconTransformation(extent={{180,-20},{220,20}})));

    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-160},{200,160}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-160},{200,160}},
          grid={2,2}), graphics={Rectangle(
              extent={{-200,160},{200,-160}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Text(
              extent={{-140,-104},{140,-116}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Power Conversion System"),Bitmap(extent={{-180,206},{
            180,-148}}, fileName=
            "modelica://ORNL_AdvSMR/Icons/Steam Turbine.jpg"),Text(
              extent={{-13,4},{13,-4}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={-196,63},
              rotation=90,
              textString="Steam Inlet"),Text(
              extent={{-20,5},{20,-5}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={-195,-56},
              rotation=90,
              textString="Condensate Return"),Text(
              extent={{-20,3},{20,-3}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={189,-32},
              rotation=270,
              textString="Rotor Shaft")}),
      experiment(
        StopTime=1000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-007,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);
  end ModularPowerConversionSystem;

  partial model SingleShaftGenerator
    "Interface description for electrical generator with single-shaft configuration"

    Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (
        Placement(transformation(extent={{-240,-40},{-160,40}},rotation=0)));
    Interfaces.ControlBus controlBus annotation (Placement(transformation(
            extent={{-40,-220},{40,-140}}), iconTransformation(extent={{-40,-220},
              {40,-140}})));

    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-200},{200,200}},
          initialScale=0.1), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-200},{200,200}},
          initialScale=0.1), graphics={Rectangle(
              extent={{-200,200},{200,-200}},
              lineColor={170,170,255},
              fillColor={230,230,230},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-202,14},{-122,-14}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={135,135,135}),Line(
              points={{140,160},{140,-160}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{120,160},{120,-160}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{100,160},{100,-160}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{50,20},{100,20}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{50,0},{120,0}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{50,-20},{140,-20}},
              color={0,0,0},
              thickness=0.5),Ellipse(
              extent={{96,24},{104,16}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{116,4},{124,-4}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{136,-16},{144,-24}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Line(
              points={{-34,20},{20,20},{44,34}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{-30,0},{20,0},{44,14}},
              color={0,0,0},
              thickness=0.5),Line(
              points={{-44,-20},{20,-20},{44,-6}},
              color={0,0,0},
              thickness=0.5),Ellipse(
              extent={{-140,60},{-20,-60}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-120,40},{-40,-40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="G")}));
  end SingleShaftGenerator;

  partial model ControlSystem "Interface for plant control system"

    Interfaces.ControlBus controlBus
      annotation (Placement(transformation(extent={{-20,70},{20,110}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Text(
              extent={{-96,14},{98,-10}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control System",
              lineColor={0,0,0})}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end ControlSystem;

  partial model SupervisoryControlSystem
    "Interface for supervisory control system"

    Interfaces.ControlBus controlBus
      annotation (Placement(transformation(extent={{-20,70},{20,110}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Text(
              extent={{-98,12},{96,-10}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="Supervisory
Control System")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent=
              {{-100,-100},{100,100}}), graphics));
  end SupervisoryControlSystem;

  partial model ReactorProtectionSystem
    "Interface for reactor protection system (RPS)"

    Interfaces.ControlBus controlBus
      annotation (Placement(transformation(extent={{-20,70},{20,110}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Text(
              extent={{-98,20},{98,-14}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="Reactor
Protection System")}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics));
  end ReactorProtectionSystem;

  partial model EventDriver
    "Interface for plant operations and fault injection"

    Interfaces.ControlBus controlBus annotation (Placement(transformation(
            extent={{-20,76},{20,116}}), iconTransformation(extent={{-20,70},{
              20,110}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Text(
              extent={{-78,16},{78,-8}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="Event Driver")}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end EventDriver;

  partial model ProcessPlant "Interface description for a process heat plant"

    /* CORE Coolant Channel Paramters */
    replaceable package PrimaryFluid =
        ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
      annotation (
      Evaluate=true,
      choicesAllMatching=true,
      Dialog(tab="CORE Coolant Channel", group="Coolant Medium"));

    FlangeA toPHP(redeclare package Medium = PrimaryFluid) annotation (
        Placement(transformation(extent={{-110,30},{-90,50}}),
          iconTransformation(extent={{-110,40},{-90,60}})));
    FlangeB fromPHP(redeclare package Medium = PrimaryFluid) annotation (
        Placement(transformation(extent={{-110,-49},{-90,-29}}),
          iconTransformation(extent={{-110,-60},{-90,-40}})));
    ControlBus controlBus annotation (Placement(transformation(
          extent={{30,30},{-30,-30}},
          rotation=180,
          origin={-60,-90}), iconTransformation(
          extent={{-20,20},{20,-20}},
          rotation=180,
          origin={0,-90})));

    annotation (
      __Dymola_Images(Parameters(
          tab="CORE Coolant Channel",
          group="Flow Geometry",
          source="C:/Users/mfc/SkyDrive/Documents/Icons/TriangularPitch.png")),

      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              radius=2),Rectangle(
              extent={{-80,80},{80,-60}},
              lineColor={175,175,175},
              fillColor={223,220,216},
              fillPattern=FillPattern.Solid,
              radius=1),Text(
              extent={{-100,-66},{100,-74}},
              lineColor={135,135,135},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Process Heat Plant")}),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=1000,
        Tolerance=1e-006,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput);

  end ProcessPlant;

  package EventDriver_package
    partial model PHTS "Interface class for PHTS transient definitions"
      ControlBus controlBus annotation (Placement(transformation(extent={{-10,
                86},{10,106}}), iconTransformation(extent={{-20,70},{20,110}})));
      replaceable Transient1 transient1_1
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      replaceable Transient2 transient2_1
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    equation
      connect(transient1_1.controlBus, controlBus) annotation (Line(
          points={{-70,39},{-70,60},{0,60},{0,96}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(transient2_1.controlBus, controlBus) annotation (Line(
          points={{-30,39},{-30,60},{0,60},{0,96}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={128,128,128},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-78,20},{82,-20}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  textString="PHTS")}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics));
    end PHTS;

    partial model IHX "Interface class for IHX transient definitions"
      ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
                {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={128,128,128},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-78,20},{82,-20}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  textString="IHX")}));
    end IHX;

    partial model IHTS "Interface class for IHTS transient definitions"
      ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
                {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={128,128,128},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-78,20},{82,-20}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  textString="IHTS")}));
    end IHTS;

    partial model Transient1 "Interface class for transient #1"
      ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
                {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={128,128,128},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-78,20},{82,-20}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  textString="Transient #1")}));
    end Transient1;

    partial model Transient2 "Interface class for transient #2"
      ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
                {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={128,128,128},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-78,20},{82,-20}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  textString="Transient #2")}));
    end Transient2;
  end EventDriver_package;
end SystemInterfaces;
