within ORNL_AdvSMR.PRISM.PrimaryHeatTransportSystem;
model PrimaryLoop_DirectHeat_UpperPlenum_IHX_BC

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
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    L=5.04,
    H=5.04,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    Nt=2139*2,
    A=1.9799e-4,
    omega=2.4936e-2,
    Dhyd=3.1758e-2,
    wnom=1126.4,
    dpnom(displayUnit="kPa") = 27500,
    rhonom=900,
    hstartin=28.8858e3 + 1.2753e3*(319 + 273),
    hstartout=28.8858e3 + 1.2753e3*(468 + 273),
    nNodes=4,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-45,0})));
  Components.Pump primaryPump(
    redeclare package Medium = Medium,
    rho0=950,
    Np0=1,
    usePowerCharacteristic=false,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.steadyState,
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
    V=11.45) annotation (Placement(transformation(extent={{9,-95},{-11,-75}},
          rotation=0)));
  Components.Plenum upperPlenum(
    redeclare package Medium = Medium,
    A=11.401,
    V0=18.241,
    ystart=2.5,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    pext=100000,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit)
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
        origin={39,40.5})));
  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={29,-61})));
  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1000,
    duration=6000,
    height=-500,
    startTime=10000)
    annotation (Placement(transformation(extent={{14,-70},{4,-60}})));
  PowerSystems.HeatExchangers.IntermediateHeatExchanger
    intermediateHeatExchanger
    annotation (Placement(transformation(extent={{45,-4.5},{86.5,37}})));
  Components.SourceW tubeIn(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    h=28.8858e3 + 1.2753e3*(282 + 273),
    p0(displayUnit="bar") = 100000,
    w0=1152.9/200) annotation (Placement(transformation(
        extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=90,
        origin={66,57.5})));
  Components.SinkP tubeOut(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    h=28.8858e3 + 1.2753e3*(426.7 + 273),
    p0=100000) annotation (Placement(transformation(
        extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=90,
        origin={66,-27.5})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(
    T_ref=(468 + 319)/2,
    alpha=0,
    Q_flow=212e6/2000)
    annotation (Placement(transformation(extent={{-90,-30},{-75,-15}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(
    T_ref=(468 + 319)/2,
    alpha=0,
    Q_flow=212e6/2000)
    annotation (Placement(transformation(extent={{-90,-15},{-75,0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow3(
    T_ref=(468 + 319)/2,
    alpha=0,
    Q_flow=212e6/2000)
    annotation (Placement(transformation(extent={{-90,0},{-75,15}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow4(
    T_ref=(468 + 319)/2,
    alpha=0,
    Q_flow=212e6/2000)
    annotation (Placement(transformation(extent={{-90,15},{-75,30}})));

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
      points={{25,-67},{25,-83},{7,-83}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(upperPlenum.inlet, coreTo.outlet) annotation (Line(
      points={{-15,64},{-15,55},{-45,55},{-45,46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(upperPlenum.outlet, dcTi.inlet) annotation (Line(
      points={{15,64},{15,55},{35,55},{35,46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ramp1.y, primaryPump.in_n) annotation (Line(
      points={{3.5,-65},{1.6,-65},{1.6,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcTi.outlet, intermediateHeatExchanger.shellInlet) annotation (Line(
      points={{35,34.5},{35,26.625},{45,26.625}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intermediateHeatExchanger.shellOutlet, dcTo.inlet) annotation (Line(
      points={{85.4625,8.9875},{90,8.9875},{90,-45},{25,-45},{25,-55}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeOut.flange, intermediateHeatExchanger.tubeOutlet) annotation (
      Line(
      points={{66,-20},{66,-6.575},{65.75,-6.575}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(tubeIn.flange, intermediateHeatExchanger.tubeInlet) annotation (Line(
      points={{66,50},{66,39.075},{65.75,39.075}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedHeatFlow1.port, core.wall[1]) annotation (Line(
      points={{-75,-22.5},{-60,-22.5},{-60,-3.375},{-51,-3.375}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedHeatFlow2.port, core.wall[2]) annotation (Line(
      points={{-75,-7.5},{-65,-7.5},{-65,-1.125},{-51,-1.125}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedHeatFlow3.port, core.wall[3]) annotation (Line(
      points={{-75,7.5},{-65,7.5},{-65,1.125},{-51,1.125}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedHeatFlow4.port, core.wall[4]) annotation (Line(
      points={{-75,22.5},{-60,22.5},{-60,3.375},{-51,3.375}},
      color={191,0,0},
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
end PrimaryLoop_DirectHeat_UpperPlenum_IHX_BC;
