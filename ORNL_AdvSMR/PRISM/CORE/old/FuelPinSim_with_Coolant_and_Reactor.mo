within ORNL_AdvSMR.PRISM.CORE.old;
model FuelPinSim_with_Coolant_and_Reactor

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  FuelPinModel fuelPinModel(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{9.5,-75},{25,75}})));
  inner System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Components.SinkP pressureBoundary1(redeclare package Medium = Medium, p0=
        100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={75,65})));
  Components.SourceW massFlowBoundary(
    w0=4,
    redeclare package Medium = Medium,
    p0=100000,
    h=28.8858e3 + 1.2753e3*(400 + 273)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={75,-65})));
  Components.ChannelFlow2 core(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    L=0.80,
    H=0.80,
    A=0.623/(19*19),
    omega=Modelica.Constants.pi*6.5e-2,
    Dhyd=4*0.623/(19*19)/(Modelica.Constants.pi*6.5e-2),
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    hstartin=28.8858e3 + 1.2753e3*(400 + 273),
    hstartout=28.8858e3 + 1.2753e3*(400 + 273),
    nNodes=nNodes,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.OpPoint,
    DynamicMomentum=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    wnom=4,
    rhonom=900,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={75,0})));
  ReactorKinetics reactorKinetics(
    noAxialNodes=9,
    alpha_f=-3.80e-2,
    T_c0=623.15,
    Q_nom=5e3,
    T_f0=1073.15)
    annotation (Placement(transformation(extent={{-65.5,-25},{-15.5,25}})));
  Modelica.Blocks.Sources.Trapezoid rho_CR(
    falling=50,
    nperiod=1,
    period=1000,
    rising=1,
    offset=0,
    width=1000,
    startTime=500,
    amplitude=0)
    annotation (Placement(transformation(extent={{-95,-7.5},{-80,7.5}})));

equation
  connect(massFlowBoundary.flange, core.infl) annotation (Line(
      points={{75,-55},{75,-15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pressureBoundary1.flange, core.outfl) annotation (Line(
      points={{75,55},{75,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fuelPinModel.heatOut, core.wall) annotation (Line(
      points={{26.9375,0},{69,0}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(rho_CR.y, reactorKinetics.rho_CR) annotation (Line(
      points={{-79.25,0},{-65.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reactorKinetics.axialProfile, fuelPinModel.powerIn) annotation (Line(
      points={{-15.5,0},{5.625,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fuelPinModel.T_fe, reactorKinetics.T_fe) annotation (Line(
      points={{17.25,-75},{17.25,-95},{-25.5,-95},{-25.5,-25}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  reactorKinetics.T_ce = sum(core.T)/nNodes;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end FuelPinSim_with_Coolant_and_Reactor;
