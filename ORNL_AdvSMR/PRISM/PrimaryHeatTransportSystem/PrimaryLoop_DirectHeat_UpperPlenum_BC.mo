within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model PrimaryLoop_DirectHeat_UpperPlenum_BC

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));
  Components.ChannelFlow2 core(
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
    nNodes=nNodes,
    DynamicMomentum=true,
    L=1.778,
    H=1.778,
    A=6.7263e-6,
    omega=8.4983e-3,
    Dhyd=3.1660e-3,
    Nt=1044*169,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-45,0})));
  Components.Pump primaryPump(
    redeclare package Medium = Medium,
    rho0=950,
    Np0=1,
    usePowerCharacteristic=false,
    n0=1400,
    wstart=1126.4,
    hstart=28.8858e3 + 1.2753e3*(319 + 273),
    w0=1126.4,
    dp0(displayUnit="kPa") = 40000,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1.2618,
            2.5236}, head_nom={135,100}),
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    V=11.45,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit) annotation (Placement(
        transformation(extent={{9,-95},{-11,-75}}, rotation=0)));
  Components.Plenum upperPlenum(
    redeclare package Medium = Medium,
    A=11.401,
    V0=18.241,
    ystart=2.5,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    pext=100000)
    annotation (Placement(transformation(extent={{-20,60},{20,85}})));
  Components.SensT coreTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-49,-40})));
  Components.SensT coreTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-49,40.5})));
  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,40.5})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-40})));
  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1000,
    height=0,
    duration=1,
    startTime=0)
    annotation (Placement(transformation(extent={{14,-70},{4,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[nNodes] fixedHeatFlow(
    each T_ref=(468 + 319)/2,
    each alpha=0,
    each Q_flow=212.5e6/(1044*169*nNodes))
    annotation (Placement(transformation(extent={{-90,-7.5},{-75,7.5}})));

  Components.PipeFlow downcomer(
    Cfnom=0.005,
    redeclare package Medium = Medium,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    nNodes=nNodes,
    L=5.04,
    H=-5.04,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    Nt=2139*2,
    A=1.9799e-4,
    omega=2.4936e-2,
    Dhyd=3.1758e-2,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    rhonom=900,
    pstart=100000,
    hstartin=28.8858e3 + 1.2753e3*(468 + 273),
    hstartout=28.8858e3 + 1.2753e3*(319 + 273)) annotation (Placement(
        transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={40,0})));
  Components.CounterCurrentConvection counterFlowConvection(nNodes=nNodes)
    annotation (Placement(transformation(extent={{50,-15},{80,15}})));
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
    nNodes=nNodes,
    L=5.04,
    A=1.5217e-4,
    omega=4.3728e-2,
    Dhyd=1.3392e-2,
    wnom=1152.9,
    dpnom(displayUnit="kPa") = 131000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    H=5.04,
    Nt=2139,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    pstart=100000) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={95,0})));
  Components.SourceW sourceW(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    w0=1152.9,
    p0=100000,
    h=28.8858e3 + 1.2753e3*(282 + 273)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={95,-55})));
  Components.SinkP sinkP(redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
      h=28.8858e3 + 1.2753e3*(426.7 + 273)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={95,55})));
equation
  connect(coreTi.outlet, core.infl) annotation (Line(
      points={{-45,-34},{-45,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTi.inlet, primaryPump.outfl) annotation (Line(
      points={{-45,-46},{-45,-78},{-7,-78}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(coreTo.inlet, core.outfl) annotation (Line(
      points={{-45,34.5},{-45,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, primaryPump.infl) annotation (Line(
      points={{40,-46},{40,-83},{7,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(upperPlenum.inlet, coreTo.outlet) annotation (Line(
      points={{-15,64},{-15,55},{-45,55},{-45,46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum.outlet, dcTi.inlet) annotation (Line(
      points={{15,64},{15,55},{40,55},{40,46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ramp1.y, primaryPump.in_n) annotation (Line(
      points={{3.5,-65},{1.6,-65},{1.6,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcTi.outlet, downcomer.infl) annotation (Line(
      points={{40,34.5},{40,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(downcomer.outfl, dcTo.inlet) annotation (Line(
      points={{40,-15},{40,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sourceW.flange, tube.infl) annotation (Line(
      points={{95,-45},{95,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tube.outfl, sinkP.flange) annotation (Line(
      points={{95,20},{95,45}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedHeatFlow.port, core.wall) annotation (Line(
      points={{-75,0},{-63.5,0},{-63.5,3.33067e-016},{-51,3.33067e-016}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(downcomer.wall, counterFlowConvection.shellSide) annotation (Line(
      points={{47.5,0.075},{55.75,0.075},{55.75,0},{65,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterFlowConvection.tubeSide, tube.wall) annotation (Line(
      points={{72.5,0},{79,0},{79,-0.1},{85,-0.1}},
      color={255,127,0},
      smooth=Smooth.None));
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
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end PrimaryLoop_DirectHeat_UpperPlenum_BC;
