within ORNL_AdvSMR.PRISM.CORE.old;
model FuelPinSim_with_Coolant

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  FuelPin fuelPin(noAxialNodes=nNodes)
    annotation (Placement(transformation(extent={{-20,-75},{-4.5,75}})));
  Modelica.Blocks.Sources.Step[nNodes] step(
    each startTime=500,
    each height=5e3,
    each offset=0)
    annotation (Placement(transformation(extent={{-50,-7.5},{-35,7.5}})));
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

equation
  connect(step.y, fuelPin.powerIn) annotation (Line(
      points={{-34.25,0},{-23.875,0}},
      color={0,0,127},
      smooth=Smooth.None));
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
end FuelPinSim_with_Coolant;
