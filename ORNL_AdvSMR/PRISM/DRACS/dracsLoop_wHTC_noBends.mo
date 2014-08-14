within ORNL_AdvSMR.PRISM.DRACS;
model dracsLoop_wHTC_noBends

  package Medium = ORNL_AdvSMR.Media.Fluids.Na;

  import Modelica.Constants.*;
  import Modelica.SIunits.*;

  // number of Nodes
  parameter Integer nNodes=9 "Number of axial nodes";

  inner System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyState,
      allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Components.PipeFlow ihxTube(
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
    Nt=2139,
    hstartin=28.8858e3 + 1.2753e3*(387 + 273),
    hstartout=28.8858e3 + 1.2753e3*(387 + 273),
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-70,-40})));

  Thermal.HeatSource1D heatSource1D1(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,5},{10,-5}},
        rotation=90,
        origin={107,18})));

  Components.SodiumExpansionTank sodiumExpansionTank(
    redeclare package Medium = Medium,
    hstart=28.8858e3 + 1.2753e3*(427 + 273),
    initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit,
    A=11.401,
    V0=18.241,
    pext=100000,
    ystart=2.5)
    annotation (Placement(transformation(extent={{-15,60},{15,90}})));

  Components.SensT riserTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,-70})));

  Components.SensT riserTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,-10})));

  Components.SensT dcTi(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,50})));

  Components.SensT dcTo(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,-15})));

  Modelica.Blocks.Sources.Ramp ramp(
    duration=2500,
    height=0,
    startTime=0,
    offset=-2.6275e4)
    annotation (Placement(transformation(extent={{125,13},{115,23}})));

  Thermal.HeatSource1D heatSource1D2(
    N=nNodes,
    L=5.04,
    omega=Modelica.Constants.pi*15.875e-3,
    redeclare ORNL_AdvSMR.Thermal.DHThtc wall) annotation (Placement(
        transformation(
        extent={{-10,-5},{10,5}},
        rotation=90,
        origin={-102.5,-40})));

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=2500,
    height=0,
    offset=2e4,
    startTime=0)
    annotation (Placement(transformation(extent={{-120,-45},{-110,-35}})));

  Components.PipeFlow sgTube(
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
    Nt=2139,
    pstart=100000) annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={70,18})));

  Components.CounterCurrentConvection counterFlowConvection(nNodes=nNodes)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));

  Components.CounterCurrentConvection counterFlowConvection1(nNodes=9)
    annotation (Placement(transformation(extent={{80,8},{100,28}})));

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
        origin={5,-85})));

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
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    nNodes=3,
    L=5,
    H=5,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=270,
        origin={-70,30})));
  Components.PipeFlow ihx2up1(
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
    hstartin=28.8858e3 + 1.2753e3*(427 + 273),
    nNodes=3,
    L=5,
    H=-5,
    pstart=100000) annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=90,
        origin={70,-55})));
equation
  connect(riserTi.outlet, ihxTube.infl) annotation (Line(
      points={{-70,-64},{-70,-55}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(riserTo.inlet, ihxTube.outfl) annotation (Line(
      points={{-70,-16},{-70,-25}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(heatSource1D1.power, ramp.y) annotation (Line(
      points={{109,18},{114.5,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource1D2.power, ramp2.y) annotation (Line(
      points={{-104.5,-40},{-109.5,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcTi.outlet, sgTube.infl) annotation (Line(
      points={{70,44},{70,33}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sgTube.outfl, dcTo.inlet) annotation (Line(
      points={{70,3},{70,-9}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatSource1D2.wall, counterFlowConvection.shellSide) annotation (Line(
      points={{-101,-40},{-90,-40}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterFlowConvection.tubeSide, ihxTube.wall) annotation (Line(
      points={{-85,-40},{-81.5,-40},{-81.5,-40.075},{-77.5,-40.075}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(sgTube.wall, counterFlowConvection1.shellSide) annotation (Line(
      points={{77.5,18.075},{84,18.075},{84,18},{90,18}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterFlowConvection1.tubeSide, heatSource1D1.wall) annotation (Line(
      points={{95,18},{105.5,18}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(pump2ihx.outfl, riserTi.inlet) annotation (Line(
      points={{-10,-85},{-70,-85},{-70,-76}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(sodiumExpansionTank.outlet, dcTi.inlet) annotation (Line(
      points={{10.5,64.5},{70,64.5},{70,56}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(riserTo.outlet, ihx2up.infl) annotation (Line(
      points={{-70,-4},{-70,15}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(dcTo.outlet, ihx2up1.infl) annotation (Line(
      points={{70,-21},{70,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihx2up1.outfl, pump2ihx.infl) annotation (Line(
      points={{70,-70},{70,-85},{20,-85}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ihx2up.outfl, sodiumExpansionTank.inlet) annotation (Line(
      points={{-70,45},{-70,65},{-10.5,65},{-10.5,64.5}},
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
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end dracsLoop_wHTC_noBends;
