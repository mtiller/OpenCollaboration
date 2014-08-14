within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model PrimaryHeatTransportSystem

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  /* General Parameters*/
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

  /* Reactor kinetics parameters */
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

  /* CORE Coolant Channel Paramters */
  replaceable package PrimaryFluid = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="CORE Coolant Channel", group="Coolant Medium"));
  parameter Boolean isTriangularPitch=true
    "Check: Triangular pitch, Uncheck: Square pitch" annotation (Dialog(
      tab="CORE Coolant Channel",
      group="Flow Geometry",
      __Dymola_compact=true), choices(__Dymola_checkBox=true));
  parameter Length P_bundle=8.8318e-3 "Bundle pitch (m)"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"));
  parameter Length D_fuelPin=5.4102e-3 "Fuel pin diameter (m)"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"));
  parameter Length H_channel=5.04 "Channel height (m)"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"));
  parameter MassFlowRate w_nom=1126.4
    "Nominal total mass flow rate through channels (kg/s)"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"));
  final parameter Area A_flow=if isTriangularPitch then sqrt(3)/4*P_bundle^2 -
      1/2*Modelica.Constants.pi*D_fuelPin^2/4 else P_bundle^2 - Modelica.Constants.pi
      *D_fuelPin^2/4 "Channel flow area"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"));
  final parameter Length P_heated=if isTriangularPitch then 1/2*Modelica.Constants.pi
      *D_fuelPin else Modelica.Constants.pi*D_fuelPin "Heated perimeter"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"),
      enable=false);
  final parameter Length D_hyd=4*A_flow/P_heated "Hydraulic diameter"
    annotation (Dialog(tab="CORE Coolant Channel", group="Flow Geometry"));

  CORE.ReactorKinetics reactorKinetics(
    noAxialNodes=noAxialNodes,
    noFuelAssemblies=1,
    noFuelPins=1,
    Q_nom=Q_nom/(2*noFuelAssemblies*noFuelPinsPerAssembly),
    alpha_f=alpha_f,
    T_f0=T_f0,
    alpha_c=alpha_c,
    T_c0=T_c0)
    annotation (Placement(transformation(extent={{-90,-15},{-60,15}})));

  CORE.FuelPin fuelPin(noAxialNodes=noAxialNodes)
    annotation (Placement(transformation(extent={{-51.5,-28},{-45.5,28}})));
  Thermal.ConvHT_htc convection(N=noAxialNodes) annotation (Placement(
        transformation(
        extent={{-40,-7.5},{40,7.5}},
        rotation=270,
        origin={-37.5,0})));

  Components.PipeFlow core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    rhonom=900,
    hstartin=28.8858e3 + 1.2753e3*(319 + 273),
    hstartout=28.8858e3 + 1.2753e3*(468 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    nNodes=noAxialNodes,
    DynamicMomentum=true,
    L=1.778,
    H=1.778,
    A=6.7263e-6,
    omega=8.4983e-3,
    Dhyd=3.1660e-3,
    Nt=1044*169,
    pstart=100000,
    redeclare Thermal.DHThtc wall) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,0})));
  Components.Thermowell coreTo_thermowell(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,40})));
  Modelica.Fluid.Fittings.Bends.CurvedBend coreOutTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.15)) annotation (
      Placement(transformation(
        extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=270,
        origin={-20,57})));
  Components.PipeFlow core2up(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartout=28.8858e3 + 1.2753e3*(427 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-5,74.5})));

  Components.SodiumExpansionTank upperPlenum(
    redeclare package Medium = Medium,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    A=11.401,
    V0=18.241,
    ystart=2.5,
    pext=100000)
    annotation (Placement(transformation(extent={{10,70},{40,100}})));
  Components.PipeFlow up2ihx(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartout=28.8858e3 + 1.2753e3*(427 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={55,74.5})));

  Modelica.Fluid.Fittings.Bends.CurvedBend upOutTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.15)) annotation (
      Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=270,
        origin={75,59})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={79,31})));
  Interfaces.FlangeB primaryOut(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
          extent={{90,5},{110,25}}), iconTransformation(extent={{90,65},{110,85}})));
  Interfaces.FlangeA primaryReturn(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na) annotation (Placement(transformation(
          extent={{90,-30},{110,-10}}), iconTransformation(extent={{90,40},{110,
            60}})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={94,-40})));
  Modelica.Fluid.Fittings.Bends.CurvedBend ihxOutTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.5)) annotation (Placement(
        transformation(
        extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=90,
        origin={90,-67.5})));
  Components.PipeFlow ihx2pump(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,-85})));

  Components.Pump primaryPump(
    redeclare package Medium = Medium,
    rho0=950,
    usePowerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    n0=1400,
    w0=1152.9,
    hstart=28.8858e3 + 1.2753e3*(282 + 273),
    wstart=1152.9,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    V=11.45,
    dp0(displayUnit="kPa") = 250000,
    Np0=1,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1.2618,
            2.5236}, head_nom={37.45,30}/1.9)) annotation (Placement(
        transformation(extent={{55,-97},{35,-77}}, rotation=0)));

  Components.PipeFlow pump2core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    wnom=1152.9,
    rhonom=950,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    Nt=1,
    A=2139*Modelica.Constants.pi*13.3919e-3^2/4,
    omega=2139*Modelica.Constants.pi*13.3919e-3,
    H=0,
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    nNodes=3,
    L=1,
    pstart=100000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={20,-80})));

  Modelica.Fluid.Fittings.Bends.CurvedBend coreInTurn(redeclare package Medium
      = Medium, geometry(d_hyd=2139*13.3919e-3, R_0=0.15)) annotation (
      Placement(transformation(
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=180,
        origin={-7.5,-80})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-25,-60})));

  Modelica.Blocks.Interfaces.RealInput rho_CR annotation (Placement(
        transformation(extent={{-115,-10},{-95,10}}), iconTransformation(extent
          ={{-110,65},{-90,85}})));

  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,21.5})));

equation
  connect(pump2core.infl, primaryPump.outfl) annotation (Line(
      points={{30,-80},{39,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihx2pump.outfl, primaryPump.infl) annotation (Line(
      points={{60,-85},{53,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(dcTo.outlet, ihxOutTurn.port_a) annotation (Line(
      points={{90,-46},{90,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihxOutTurn.port_b, ihx2pump.infl) annotation (Line(
      points={{90,-75},{90,-85},{80,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coreTi.inlet, coreInTurn.port_b) annotation (Line(
      points={{-21,-66},{-21,-80},{-15,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core2up.outfl, upperPlenum.inlet) annotation (Line(
      points={{5,74.5},{14.5,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coreOutTurn.port_b, core2up.infl) annotation (Line(
      points={{-20,64.5},{-20,74.5},{-15,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(up2ihx.infl, upperPlenum.outlet) annotation (Line(
      points={{45,74.5},{35.5,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(up2ihx.outfl, upOutTurn.port_a) annotation (Line(
      points={{65,74.5},{75,74.5},{75,66.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upOutTurn.port_b, dcTi.inlet) annotation (Line(
      points={{75,51.5},{75,37}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coreOutTurn.port_a, coreTo_thermowell.outlet) annotation (Line(
      points={{-20,49.5},{-20,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(core.infl, coreTi.outlet) annotation (Line(
      points={{-20,-10},{-20,-54},{-21,-54}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(dcTi.outlet, primaryOut) annotation (Line(
      points={{75,25},{75,15},{100,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(dcTo.inlet, primaryReturn) annotation (Line(
      points={{90,-34},{90,-20},{100,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(primaryOut, primaryOut) annotation (Line(
      points={{100,15},{100,15.5},{99.5,15.5},{99.5,15},{100,15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fuelPin.wall, convection.otherside) annotation (Line(
      points={{-44.75,-3.55271e-015},{-42,-3.55271e-015},{-42,3.88578e-016},{-39.75,
          3.88578e-016}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(coreInTurn.port_a, pump2core.outfl) annotation (Line(
      points={{0,-80},{10,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(convection.fluidside, core.wall) annotation (Line(
      points={{-35.25,0},{-30,0},{-30,-0.05},{-25,-0.05}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPin.powerIn) annotation (Line(
      points={{-60,0},{-56.5,0},{-56.5,-3.55271e-015},{-53,-3.55271e-015}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reactorKinetics.rho_CR, rho_CR) annotation (Line(
      points={{-90,0},{-105,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(core.outfl, coreTo.inlet) annotation (Line(
      points={{-20,10},{-20,15.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coreTo.outlet, coreTo_thermowell.inlet) annotation (Line(
      points={{-20,27.5},{-20,34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  for i in 1:noAxialNodes loop
    fuelPin.fp[i].T_cool = convection.fluidside.T[i];
    fuelPin.fp[i].h = 1e4;
  end for;
  convection.fluidside.gamma = 1e4*ones(noAxialNodes);
  reactorKinetics.T_ce = sum(core.T)/noAxialNodes;
  reactorKinetics.T_fe = 500;

  annotation (
    __Dymola_Images(Parameters(
        tab="CORE Coolant Channel",
        group="Flow Geometry",
        source="modelica://ORNL_AdvSMR/Icons/TriangularPitch.png")),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-105,-100},{105,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-105,-100},{105,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-105,100},{105,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),Rectangle(
          extent={{-90,90},{90,-60}},
          lineColor={64,64,64},
          fillColor={223,220,216},
          fillPattern=FillPattern.Solid,
          radius=1),Text(
          extent={{-100,-75},{100,-85}},
          lineColor={64,64,64},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="PRIMARY
HEAT  TRANSPORT  SYSTEM"),Bitmap(extent={{-35,89.5},{44,-59.5}}, fileName=
          "modelica://ORNL_AdvSMR/Icons/PRISM reactor cutaway 660x450.png"),
          Bitmap(
          extent={{-73.75,46.25},{73.75,-46.25}},
          origin={-61.75,15.25},
          rotation=90,
          fileName="modelica://ORNL_AdvSMR/../Icons/PRISM.png")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end PrimaryHeatTransportSystem;
