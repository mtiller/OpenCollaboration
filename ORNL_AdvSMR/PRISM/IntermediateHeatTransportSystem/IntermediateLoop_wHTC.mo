within ORNL_AdvSMR.PRISM.IntermediateHeatTransportSystem;
model IntermediateLoop_wHTC

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-95,75},{-75,95}})));

  Components.PipeFlow intermediateRiser(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    hstartin=28.8858e3 + 1.2753e3*(282 + 273),
    hstartout=28.8858e3 + 1.2753e3*(427 + 273),
    L=5.04,
    H=5.04,
    wnom=1152.9,
    rhonom=950,
    A=Modelica.Constants.pi*13.3919e-3^2/4,
    omega=Modelica.Constants.pi*13.3919e-3,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    hstart=linspace(
        28.8858e3 + 1.2753e3*(282 + 273),
        28.8858e3 + 1.2753e3*(427 + 273),
        nNodes),
    pstart=100000,
    Nt=2139) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-40,0})));

  Components.Pump intermediatePump(
    redeclare package Medium = Medium,
    rho0=950,
    usePowerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
            0.95),
    n0=1400,
    w0=1152.9,
    dp0(displayUnit="kPa") = 150000,
    hstart=28.8858e3 + 1.2753e3*(282 + 273),
    wstart=1152.9,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    V=11.45,
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1.2618,
            2.5236}, head_nom={135,100}),
    Np0=1) annotation (Placement(transformation(extent={{10,-90},{-10,-70}},
          rotation=0)));
  Thermal.HeatSource1D heatSource1D1(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={77,0})));

  Components.SodiumExpansionTank sodiumExpansionTank(
    redeclare package Medium = Medium,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    A=11.401,
    V0=18.241,
    pext=100000,
    ystart=2.5)
    annotation (Placement(transformation(extent={{-15,65},{15,95}})));

  Components.SensT riserTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-44,-40})));

  Components.SensT riserTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-44,40})));

  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,40})));

  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-40})));

  Modelica.Blocks.Sources.Ramp ramp(
    duration=2500,
    height=-212.5e6 - 3.11565e4*2139,
    offset=-3.086e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{95,-5},{85,5}})));

  Modelica.Blocks.Sources.Ramp ramp1(
    offset=1400,
    height=0,
    duration=1,
    startTime=0)
    annotation (Placement(transformation(extent={{15,-65},{5,-55}})));

  Thermal.HeatSource1D heatSource1D2(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-77.5,0})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=2500,
    offset=0,
    height=212.5e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{-95,-5},{-85,5}})));

  Components.PipeFlow intDowncomer(
    Cfnom=0.005,
    FluidPhaseStart=ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid,
    dpnom(displayUnit="kPa") = 1,
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    redeclare model HeatTransfer =
        ORNL_AdvSMR.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer (alpha0=
            5000),
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall,
    nNodes=nNodes,
    DynamicMomentum=false,
    avoidInletEnthalpyDerivative=false,
    Kfnom=0.005,
    FFtype=ORNL_AdvSMR.Choices.Flow1D.FFtypes.Colebrook,
    L=5.04,
    wnom=1152.9,
    rhonom=950,
    A=Modelica.Constants.pi*13.3919e-3^2/4,
    omega=Modelica.Constants.pi*13.3919e-3,
    Dhyd=13.3919e-3,
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    H=-5.04,
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    hstartout=28.8858e3 + 1.2753e3*(282 + 273),
    pstart=100000,
    Nt=2139) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={40,0})));

  Components.CounterFlowConvection2 counterFlowConvection(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-75,-10},{-55,10}})));

  Components.CounterCurrentConvection counterFlowConvection1(nNodes=9)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

equation
  connect(riserTi.outlet, intermediateRiser.infl) annotation (Line(
      points={{-40,-34},{-40,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(riserTi.inlet, intermediatePump.outfl) annotation (Line(
      points={{-40,-46},{-40,-73},{-6,-73}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(riserTo.inlet, intermediateRiser.outfl) annotation (Line(
      points={{-40,34},{-40,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dcTo.outlet, intermediatePump.infl) annotation (Line(
      points={{40,-46},{40,-78},{8,-78}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{79,-1.11022e-016},{78.5,-1.11022e-016},{78.5,0},{84.5,0}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(sodiumExpansionTank.inlet, riserTo.outlet) annotation (Line(
      points={{-10.5,69.5},{-10.5,60},{-40,60},{-40,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sodiumExpansionTank.outlet, dcTi.inlet) annotation (Line(
      points={{10.5,69.5},{10.5,60},{40,60},{40,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ramp1.y, intermediatePump.in_n) annotation (Line(
      points={{4.5,-60},{2.6,-60},{2.6,-72}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(heatSource1D2.power, ramp2.y) annotation (Line(
      points={{-79.5,0},{-84.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcTi.outlet, intDowncomer.infl) annotation (Line(
      points={{40,34},{40,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(intDowncomer.outfl, dcTo.inlet) annotation (Line(
      points={{40,-15},{40,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(heatSource1D2.wall, counterFlowConvection.dHThtc_in) annotation (Line(
      points={{-76,0},{-65,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterFlowConvection.dHThtc_in1, intermediateRiser.wall) annotation
    (Line(
      points={{-60,0},{-54,0},{-54,-0.075},{-47.5,-0.075}},
      color={255,127,0},
      smooth=Smooth.None));

  connect(counterFlowConvection1.dHThtc_in1, heatSource1D1.wall) annotation (
      Line(
      points={{65,0},{75.5,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(intDowncomer.wall, counterFlowConvection1.dHThtc_in) annotation (Line(
      points={{47.5,0.075},{53.25,0.075},{53.25,0},{60,0}},
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
end IntermediateLoop_wHTC;
