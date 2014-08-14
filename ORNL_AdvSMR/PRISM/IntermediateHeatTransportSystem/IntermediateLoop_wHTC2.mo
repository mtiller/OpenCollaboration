within ORNL_AdvSMR.PRISM.IntermediateHeatTransportSystem;
model IntermediateLoop_wHTC2

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

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
    Nt=2139,
    hstartin=28.8858e3 + 1.2753e3*(387 + 273),
    hstartout=28.8858e3 + 1.2753e3*(387 + 273)) annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-70,0})));

  Components.Pump intermediatePump(
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
    redeclare function flowCharacteristic =
        ORNL_AdvSMR.Functions.PumpCharacteristics.linearFlow (q_nom={1.2618,
            2.5236}, head_nom={135,100}),
    Np0=1,
    dp0(displayUnit="kPa") = 250000) annotation (Placement(transformation(
          extent={{10,-97},{-10,-77}}, rotation=0)));
  Thermal.HeatSource1D heatSource1D1(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={107,0})));

  Components.SodiumExpansionTank sodiumExpansionTank(
    redeclare package Medium = Medium,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    A=11.401,
    V0=18.241,
    pext=100000,
    ystart=2.5)
    annotation (Placement(transformation(extent={{-15,70},{15,100}})));

  Components.SensT riserTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,-40})));

  Components.SensT riserTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,40})));

  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,40})));

  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,-40})));

  Modelica.Blocks.Sources.Ramp ramp(
    duration=2500,
    height=-212.5e6 - 66.6513e6,
    offset=-2.96e6,
    startTime=1e3)
    annotation (Placement(transformation(extent={{125,-5},{115,5}})));

  Thermal.HeatSource1D heatSource1D2(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-107.5,0})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=2500,
    offset=0,
    height=212.5e6,
    startTime=1e3)
    annotation (Placement(transformation(extent={{-125,-5},{-115,5}})));

  Components.PipeFlow sg(
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
        origin={70,0})));

  Components.CounterCurrentConvection counterFlowConvection(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-105,-10},{-85,10}})));

  Components.CounterCurrentConvection counterFlowConvection1(nNodes=9)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));

  Components.PipeFlow ihx2up(
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
    L=1,
    nNodes=3,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={-40,65})));
  Components.PipeFlow pump2ihx(
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
    L=1,
    nNodes=3,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,15},{15,-15}},
        rotation=180,
        origin={-40,-80})));
  Components.PipeFlow up2sg(
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
    L=1,
    nNodes=3,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={40,65})));
  Components.PipeFlow sg2pump(
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
    L=1,
    nNodes=3,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,15},{15,-15}},
        rotation=180,
        origin={40,-85})));
equation
  connect(riserTi.outlet, intermediateRiser.infl) annotation (Line(
      points={{-70,-34},{-70,-15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(riserTo.inlet, intermediateRiser.outfl) annotation (Line(
      points={{-70,34},{-70,15}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{109,0},{114.5,0}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(heatSource1D2.power, ramp2.y) annotation (Line(
      points={{-109.5,0},{-114.5,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcTi.outlet, sg.infl) annotation (Line(
      points={{70,34},{70,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sg.outfl, dcTo.inlet) annotation (Line(
      points={{70,-15},{70,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(counterFlowConvection1.dHThtc_in1, heatSource1D1.wall) annotation (
      Line(
      points={{95,0},{105.5,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(sg.wall, counterFlowConvection1.dHThtc_in) annotation (Line(
      points={{77.5,0.075},{83.25,0.075},{83.25,0},{90,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(ihx2up.infl, riserTo.outlet) annotation (Line(
      points={{-55,65},{-70,65},{-70,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihx2up.outfl, sodiumExpansionTank.inlet) annotation (Line(
      points={{-25,65},{-10.5,65},{-10.5,74.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pump2ihx.infl, intermediatePump.outfl) annotation (Line(
      points={{-25,-80},{-6,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pump2ihx.outfl, riserTi.inlet) annotation (Line(
      points={{-55,-80},{-70,-80},{-70,-46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sodiumExpansionTank.outlet, up2sg.infl) annotation (Line(
      points={{10.5,74.5},{11,74.5},{11,65},{25,65}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(up2sg.outfl, dcTi.inlet) annotation (Line(
      points={{55,65},{70,65},{70,46}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(dcTo.outlet, sg2pump.infl) annotation (Line(
      points={{70,-46},{70,-85},{55,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sg2pump.outfl, intermediatePump.infl) annotation (Line(
      points={{25,-85},{8,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(counterFlowConvection.tubeSide, intermediateRiser.wall) annotation (
      Line(
      points={{-90,0},{-84,0},{-84,-0.075},{-77.5,-0.075}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(heatSource1D2.wall, counterFlowConvection.shellSide) annotation (Line(
      points={{-106,0},{-95,0}},
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
end IntermediateLoop_wHTC2;
