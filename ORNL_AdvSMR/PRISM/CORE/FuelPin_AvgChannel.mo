within ORNL_AdvSMR.PRISM.CORE;
model FuelPin_AvgChannel "Average channel simulation with fuel pin only"

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // Reactor kinetics parameters
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
  parameter Integer noFlowChannels=integer(noFuelAssemblies*
      noFuelPinsPerAssembly) "Total number of flow channels in the core"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Length H_fuelPin=5.04 "Active height of a fuel pin"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  parameter Boolean usePowerProfile=true "Use power profile output"
    annotation (Dialog(tab="General", group="Core Loading Parameters"));
  /* Neutron kinetic parameters */
  parameter Real[6] beta={0.000215,0.001424,0.001274,0.002568,0.000748,0.000273}
    "Delayed neutron precursor fractions"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real[6] lambda(unit="1/s") = {0.0124,0.0305,0.111,0.301,1.14,3.01}
    "Decay constants for each precursor group"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter Real Lambda(unit="s") = 0.03 "Mean neutron generation time"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  /* Reactivity feedback parameters */
  parameter Real alpha_f=0.00 "Fuel Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter Temperature T_f0=773.15 "Fuel reference temperature"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter Real alpha_c=0.00 "Coolant density feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter Temperature T_c0=673.15 "Coolant reference temperature"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  /* Fuel Cycle Parameters */
  parameter Time T_op=360*24*3600 "Time since reactor startup"
    annotation (Dialog(tab="Kinetics", group="Fuel Cycle Parameters"));
  /* Coolant channel parameters */
  replaceable package PrimaryFluid = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Coolant Channel", group="Coolant Medium"));
  parameter Temperature T_coolIn=592.15 "Coolant inlet temperature"
    annotation (Dialog(tab="Coolant Channel", group="Coolant Medium"));
  parameter Boolean isTriangularPitch=true
    "Check: Triangular pitch, Uncheck: Square pitch" annotation (Dialog(
      tab="Coolant Channel",
      group="Flow Geometry",
      __Dymola_compact=true), choices(__Dymola_checkBox=true));
  parameter Length P_bundle=8.8318e-3 "Bundle pitch (m)"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"));
  parameter Length D_fuelPin=5.4102e-3 "Fuel pin diameter (m)"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"));
  parameter Length H_channel=5.04 "Channel height (m)"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"));
  parameter MassFlowRate w_nom=1126.4
    "Nominal total mass flow rate through channels (kg/s)"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"));
  final parameter Area A_flow=if isTriangularPitch then sqrt(3)/4*P_bundle^2 -
      1/2*Modelica.Constants.pi*D_fuelPin^2/4 else P_bundle^2 - Modelica.Constants.pi
      *D_fuelPin^2/4 "Channel flow area"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"));
  final parameter Length P_heated=if isTriangularPitch then 1/2*Modelica.Constants.pi
      *D_fuelPin else Modelica.Constants.pi*D_fuelPin "Heated perimeter"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"), enable=
        false);
  final parameter Length D_hyd=4*A_flow/P_heated "Hydraulic diameter"
    annotation (Dialog(tab="Coolant Channel", group="Flow Geometry"));

  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  FuelPin fuelPin(
    noRadialNodes_f=noRadialNodes_f,
    noRadialNodes_c=noRadialNodes_c,
    noAxialNodes=noAxialNodes)
    annotation (Placement(transformation(extent={{0,-50},{11,50}})));

  Thermal.ConvHT_htc convec(N=noAxialNodes) annotation (Placement(
        transformation(
        extent={{-40,-7.5},{40,7.5}},
        rotation=270,
        origin={37.5,0})));

  Components.PipeFlow channel(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.PartialBundleHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=noAxialNodes,
    L=H_channel,
    H=H_channel,
    A=A_flow,
    omega=P_heated,
    Dhyd=D_hyd,
    wnom=w_nom,
    dpnom(displayUnit="kPa") = 27500,
    redeclare package Medium = PrimaryFluid,
    DynamicMomentum=false,
    hstartin=28.8858e3 + 1.2753e3*T_coolIn,
    hstartout=28.8858e3 + 1.2753e3*T_coolIn,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    Nt=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={80,0})));

  Components.SourceW channelIn(
    h=28.8858e3 + 1.2753e3*T_coolIn,
    p0(displayUnit="bar") = 100000,
    redeclare package Medium = PrimaryFluid,
    w0=1126.4/noFlowChannels) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=90,
        origin={80,-82.5})));

  Components.SinkP channelOut(
    h=28.8858e3 + 1.2753e3*741.15,
    redeclare package Medium = PrimaryFluid,
    p0=100000) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=90,
        origin={80,87.5})));

  Components.PipeFlow bottomPlenum(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.PartialBundleHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    L=H_channel,
    H=H_channel,
    A=A_flow,
    omega=P_heated,
    Dhyd=D_hyd,
    wnom=w_nom,
    dpnom(displayUnit="kPa") = 27500,
    redeclare package Medium = PrimaryFluid,
    DynamicMomentum=false,
    hstartin=28.8858e3 + 1.2753e3*T_coolIn,
    hstartout=28.8858e3 + 1.2753e3*T_coolIn,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    use_HeatTransfer=false,
    Nt=1,
    nNodes=4,
    pstart=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,-50})));
  Components.PipeFlow topPlenum(
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    rhonom=900,
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.PartialBundleHeatTransfer,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    L=H_channel,
    H=H_channel,
    A=A_flow,
    omega=P_heated,
    Dhyd=D_hyd,
    wnom=w_nom,
    dpnom(displayUnit="kPa") = 27500,
    redeclare package Medium = PrimaryFluid,
    DynamicMomentum=false,
    hstartin=28.8858e3 + 1.2753e3*T_coolIn,
    hstartout=28.8858e3 + 1.2753e3*T_coolIn,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    use_HeatTransfer=false,
    nNodes=4,
    Nt=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,50})));
  Components.StepVector stepVector(
    noAxialNodes=noAxialNodes,
    height=0,
    startTime=0,
    offset=425e6/noFlowChannels)
    annotation (Placement(transformation(extent={{-45,-10},{-25,10}})));
equation
  connect(fuelPin.wall, convec.otherside) annotation (Line(
      points={{12.375,0},{35.25,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convec.fluidside, channel.wall) annotation (Line(
      points={{39.75,-4.44089e-016},{48,-4.44089e-016},{48,-0.075},{72.5,-0.075}},

      color={255,127,0},
      smooth=Smooth.None));

  convec.fluidside.gamma = 5e3*ones(noAxialNodes);
  // Coupling of heat transfer to interface nodes
  for i in 1:noAxialNodes loop
    fuelPin.fp[i].T_cool = convec.fluidside.T[i];
    fuelPin.fp[i].h = convec.fluidside.gamma[i];
  end for;
  connect(topPlenum.outfl, channelOut.flange) annotation (Line(
      points={{80,60},{80,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(channelIn.flange, bottomPlenum.infl) annotation (Line(
      points={{80,-75},{80,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bottomPlenum.outfl, channel.infl) annotation (Line(
      points={{80,-40},{80,-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(channel.outfl, topPlenum.infl) annotation (Line(
      points={{80,15},{80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(stepVector.y, fuelPin.powerIn) annotation (Line(
      points={{-24,0},{-2.75,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    __Dymola_Images(Parameters(
        tab="Coolant Channel",
        group="Flow Geometry",
        source=
            "file:/Users/Sacit/SkyDrive/Documents/ORNL_AdvSMR/Icons/TriangularPitch.png")),

    Documentation(info="<HTML>
Stand-alone block that includes neutron dynamics, fuel pin thermal model and an average sodium channel model.
</HTML>
", revisions="<html>
<ul>
<li><i>30 Aug 2013</i>
    by <a href=\"mailto:cetinerms@ornl.gov\">Sacit M. Cetiner, Ph.D.</a>:<br>
       Includes sodium inlet temperature as the fluid boundary condition.</li>
</ul>
</html>"),
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
      Tolerance=1e-006,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput);
end FuelPin_AvgChannel;
