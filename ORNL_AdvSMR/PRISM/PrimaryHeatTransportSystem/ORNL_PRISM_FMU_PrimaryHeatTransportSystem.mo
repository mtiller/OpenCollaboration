within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model ORNL_PRISM_FMU_PrimaryHeatTransportSystem

  import Modelica.SIunits.*;

  /* General Parameters */
  parameter Power Q_nom=250e6 "Reactor nominal heat rating (W)"
    annotation (Dialog(tab="General"));
  parameter Integer noRadialNodes_f=8 "Number of radial nodes for fuel"
    annotation (Dialog(tab="General"));
  parameter Integer noRadialNodes_c=4 "Number of radial nodes for cladding"
    annotation (Dialog(tab="General"));
  parameter Integer noAxialNodes=8 "Number of axial nodes"
    annotation (Dialog(tab="General"));
  parameter Integer noFuelAssemblies=169 "Number of fuel assemblies"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Integer noFuelPinsPerAssembly=271
    "Number of fuel pins in an assembly"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  final parameter Integer noFlowChannels=integer(noFuelAssemblies*
      noFuelPinsPerAssembly/(2*1.0419)) "Total number of fuel pins in the core"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Length H_fuelPin=5.04 "Active height of a fuel pin"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Boolean usePowerProfile=true "Use power profile output"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));

  /* Neutron kinetic parameters */
  parameter Real[6] beta={0.000215,0.001424,0.001274,0.002568,0.000748,0.000273}
    "Delayed neutron precursor fractions" annotation (Dialog(tab=
          "Reactor Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real[6] lambda(unit="1/s") = {0.0124,0.0305,0.111,0.301,1.14,3.01}
    "Decay constants for each precursor group" annotation (Dialog(tab=
          "Reactor Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real Lambda(unit="s") = 0.03 "Mean neutron generation time"
    annotation (Dialog(tab="Reactor Kinetics", group=
          "Neutron Kinetics Parameters"));
  /* Reactivity feedback parameters */
  parameter Real alpha_f=0.00 "Fuel Doppler feedback coefficient" annotation (
      Dialog(tab="Reactor Kinetics", group="Reactivity Feedback Parameters"));
  parameter Temperature T_f0=773.15 "Fuel reference temperature" annotation (
      Dialog(tab="Reactor Kinetics", group="Reactivity Feedback Parameters"));
  parameter Real alpha_c=0.00 "Coolant density feedback coefficient"
    annotation (Dialog(tab="Reactor Kinetics", group=
          "Reactivity Feedback Parameters"));
  parameter Temperature T_c0=673.15 "Coolant reference temperature" annotation
    (Dialog(tab="Reactor Kinetics", group="Reactivity Feedback Parameters"));
  /* Fuel Cycle Parameters */
  parameter Time T_op=360*24*3600 "Time since reactor startup"
    annotation (Dialog(tab="Reactor Kinetics", group="Fuel Cycle Parameters"));

  /* Reactor Core Channel */
  parameter Boolean isTriangularPitch=true
    "Check: Triangular pitch, Uncheck: Square pitch" annotation (Dialog(
      tab="Reactor Core Channel",
      group="Flow Geometry",
      __Dymola_compact=true), choices(__Dymola_checkBox=true));
  parameter Length P_bundle=8.8318e-3 "Bundle pitch (m)"
    annotation (Dialog(tab="Reactor Core Channel", group="Flow Geometry"));
  parameter Length D_fuelPin=5.4102e-3 "Fuel pin diameter (m)"
    annotation (Dialog(tab="Reactor Core Channel", group="Flow Geometry"));
  parameter Length H_channel=5.04 "Channel height (m)"
    annotation (Dialog(tab="Reactor Core Channel", group="Flow Geometry"));
  final parameter Area A_core_flow=if isTriangularPitch then sqrt(3)/4*P_bundle
      ^2 - 1/2*Modelica.Constants.pi*D_fuelPin^2/4 else P_bundle^2 - Modelica.Constants.pi
      *D_fuelPin^2/4 "Channel flow area"
    annotation (Dialog(tab="Reactor Core Channel", group="Flow Geometry"));
  final parameter Length P_core_heated=if isTriangularPitch then 1/2*Modelica.Constants.pi
      *D_fuelPin else Modelica.Constants.pi*D_fuelPin "Heated perimeter"
    annotation (Dialog(tab="Reactor Core Channel", group="Flow Geometry"),
      enable=false);
  final parameter Length D_core_hyd=4*A_core_flow/P_core_heated
    "Hydraulic diameter"
    annotation (Dialog(tab="Reactor Core Channel", group="Flow Geometry"));

  /* Intermediate Heat Exchanger (IHX) - Primary Side (Shell side) */
  replaceable package PrimaryFluid = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="IHX Primary Side (Shell)", group="Coolant Medium"));
  parameter Boolean isIHXTriangularPitch=true
    "Check: Triangular pitch, Uncheck: Square pitch" annotation (Dialog(
      tab="IHX Primary Side (Shell)",
      group="Flow Geometry",
      __Dymola_compact=true), choices(__Dymola_checkBox=true));
  parameter Length P_ihxBundle=8.8318e-3 "IHX tube bundle pitch (m)"
    annotation (Dialog(tab="IHX Primary Side (Shell)", group="Flow Geometry"));
  parameter Length D_ihxTubeOuter=5.4102e-3 "IHX tube outer diameter (m)"
    annotation (Dialog(tab="IHX Primary Side (Shell)", group="Flow Geometry"));
  parameter Length L_ihxTube=5.04 "IHX single tube length (m)"
    annotation (Dialog(tab="IHX Primary Side (Shell)", group="Flow Geometry"));
  parameter MassFlowRate w_ihxp_nom=1126.4
    "Primary coolant nominal total mass flow rate (kg/s)"
    annotation (Dialog(tab="IHX Primary Side (Shell)", group="Flow Geometry"));
  final parameter Area A_ihxp_flow=if isTriangularPitch then sqrt(3)/4*
      P_ihxBundle^2 - 1/2*Modelica.Constants.pi*D_ihxTubeOuter^2/4 else
      P_ihxBundle^2 - Modelica.Constants.pi*D_ihxTubeOuter^2/4
    "Channel flow area"
    annotation (Dialog(tab="IHX Primary Side (Shell)", group="Flow Geometry"));
  final parameter Length P_ihxp_heated=if isTriangularPitch then 1/2*Modelica.Constants.pi
      *D_ihxTubeOuter else Modelica.Constants.pi*D_ihxTubeOuter
    "Heated perimeter" annotation (Dialog(tab="IHX Primary Side (Shell)",group=
          "Flow Geometry"), enable=false);

  final parameter Length D_ihxp_hyd=4*A_ihxp_flow/P_ihxp_heated
    "Hydraulic diameter"
    annotation (Dialog(tab="IHX Primary Side (Shell)", group="Flow Geometry"));

  /* Intermediate Heat Exchanger (IHX) - Secondary Side (Tube side) */
  replaceable package IntermediateFluid = ORNL_AdvSMR.Media.Fluids.Na
    constrainedby ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium
    "Intermediate coolant" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="IHX Secondary Side (Tube)", group="Coolant Medium"));
  parameter Length D_ihxTubeInner=5.4102e-3 "Tube inner diameter (m)"
    annotation (Dialog(tab="IHX Secondary Side (Tube)", group="Flow Geometry"));
  parameter MassFlowRate w_ihxs_nom=1126.4
    "Secondary coolant nominal total mass flow rate (kg/s)"
    annotation (Dialog(tab="IHX Secondary Side (Tube)", group="Flow Geometry"));
  final parameter Area A_ihxs_flow=Modelica.Constants.pi*D_ihxTubeInner^2/4
    "Secondary side tube flow area"
    annotation (Dialog(tab="IHX Secondary Side (Tube)", group="Flow Geometry"));
  final parameter Length P_ihxs_heated=Modelica.Constants.pi*D_ihxTubeInner
    "Secondary side heated perimeter" annotation (Dialog(tab=
          "IHX Secondary Side (Tube)", group="Flow Geometry"), enable=false);
  final parameter Length D_ihxs_hyd=D_ihxTubeInner
    "Secondary side hydraulic diameter"
    annotation (Dialog(tab="IHX Secondary Side (Tube)", group="Flow Geometry"));

  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  PrimaryHeatTransportSystem primaryHeatTransportSystem(noAxialNodes=
        noAxialNodes, Q_nom=5000e6)
    annotation (Placement(transformation(extent={{-80,-40},{0,40}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    nperiod=1,
    period=1000,
    offset=0,
    width=100,
    startTime=2000,
    amplitude=1e-4,
    rising=100,
    falling=100) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-95,30})));
  Components.SourceW tubelIn(
    p0(displayUnit="bar") = 100000,
    redeclare package Medium = IntermediateFluid,
    w0=1126.4,
    h=28.8858e3 + 1.2753e3) annotation (Placement(transformation(
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=90,
        origin={50,77.5})));
  Components.SinkP tubeOut(
    h=28.8858e3 + 1.2753e3*741.15,
    redeclare package Medium = IntermediateFluid,
    p0=100000) annotation (Placement(transformation(
        extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=90,
        origin={49.5,-67.5})));
  Modelica.Blocks.Sources.Trapezoid w(
    nperiod=1,
    period=1000,
    width=100,
    rising=100,
    falling=100,
    startTime=500,
    amplitude=0,
    offset=1126.4)
    annotation (Placement(transformation(extent={{80,73},{65,88}})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger(
    redeclare package shellMedium = PrimaryFluid,
    redeclare package tubeMedium = IntermediateFluid,
    noAxialNodes=noAxialNodes,
    allowFlowReversal=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    shellDiameter=D_ihxp_hyd,
    shellFlowArea=A_ihxp_flow,
    shellPerimeter=P_ihxp_heated,
    shellHeatTrArea=1,
    shellWallThickness=1,
    tubeFlowArea=1,
    tubePerimeter=1,
    tubeHeatTrArea=1,
    tubeWallThickness=1,
    tubeWallRho=1,
    tubeWallCp=1,
    tubeWallK=1,
    flowPathLength=1,
    tubeDiameter=1,
    Twall_start=278.15)
    annotation (Placement(transformation(extent={{10,-30},{90,50}})));

equation
  connect(rho_CR.y, primaryHeatTransportSystem.rho_CR) annotation (Line(
      points={{-89.5,30},{-78.0952,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(primaryHeatTransportSystem.primaryOut, intermediateHeatExchanger.shellInlet)
    annotation (Line(
      points={{-1.90476,30},{10,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.shellOutlet, primaryHeatTransportSystem.primaryReturn)
    annotation (Line(
      points={{88,-4},{95,-4},{95,-45},{10,-45},{10,20},{-1.90476,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeOutlet, tubeOut.flange) annotation (
      Line(
      points={{50,-34},{50,-60},{49.5,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.tubeInlet, tubelIn.flange) annotation (Line(
      points={{50,54},{50,70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubelIn.in_w0, w.y) annotation (Line(
      points={{54.5,80.5},{64.25,80.5}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (
    __Dymola_Images(Parameters(
        tab="Reactor Core Channel",
        group="Flow Geometry",
        source="C:/Users/mfc/SkyDrive/Documents/Icons/TriangularPitch.png")),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=20000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput);
end ORNL_PRISM_FMU_PrimaryHeatTransportSystem;
