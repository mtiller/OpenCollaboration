within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model heatExchanger "Heat Exchanger fluid - gas"
  extends ThermoPower3.PowerPlants.HRSG.Interfaces.HeatExchanger;

  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_G
    "Constant heat transfer coefficient in the gas side";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_F
    "Constant heat transfer coefficient in the fluid side";
  parameter ORNL_AdvSMR.Choices.Flow1D.FFtypes FFtype_G=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction
    "Friction Factor Type, gas side";
  parameter Real Kfnom_G=0 "Nominal hydraulic resistance coefficient, gas side";
  parameter Modelica.SIunits.Pressure dpnom_G=0
    "Nominal pressure drop, gas side (friction term only!)";
  parameter Modelica.SIunits.Density rhonom_G=0
    "Nominal inlet density, gas side";
  parameter Real Cfnom_G=0 "Nominal Fanning friction factor, gas side";
  parameter ORNL_AdvSMR.Choices.Flow1D.FFtypes FFtype_F=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction
    "Friction Factor Type, fluid side";
  parameter Real Kfnom_F=0 "Nominal hydraulic resistance coefficient";
  parameter Modelica.SIunits.Pressure dpnom_F=0
    "Nominal pressure drop fluid side (friction term only!)";
  parameter Modelica.SIunits.Density rhonom_F=0
    "Nominal inlet density fluid side";
  parameter Real Cfnom_F=0 "Nominal Fanning friction factor";
  parameter ORNL_AdvSMR.Choices.Flow1D.HCtypes HCtype_F=ThermoPower3.Choices.Flow1D.HCtypes.Downstream
    "Location of the hydraulic capacitance, fluid side";
  parameter Boolean counterCurrent=true "Counter-current flow";
  parameter Boolean gasQuasiStatic=false
    "Quasi-static model of the flue gas (mass, energy and momentum static balances";
  constant Real pi=Modelica.Constants.pi;

  ThermoPower3.Water.Flow1D fluidFlow(
    Nt=1,
    N=N_F,
    wnom=fluidNomFlowRate,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    redeclare package Medium = FluidMedium,
    L=exchSurface_F^2/(fluidVol*pi*4),
    A=(fluidVol*4/exchSurface_F)^2/4*pi,
    omega=fluidVol*4/exchSurface_F*pi,
    Dhyd=fluidVol*4/exchSurface_F,
    FFtype=FFtype_F,
    HydraulicCapacitance=HCtype_F,
    Kfnom=Kfnom_F,
    dpnom=dpnom_F,
    rhonom=rhonom_F,
    Cfnom=Cfnom_F,
    FluidPhaseStart=FluidPhaseStart,
    pstart=pstart_F) annotation (Placement(transformation(extent={{-20,-80},{20,
            -40}}, rotation=0)));
  ORNL_AdvSMR.Thermal.ConvHT convHT(N=N_F, gamma=gamma_F) annotation (Placement(
        transformation(extent={{-20,-40},{20,-20}}, rotation=0)));
  ORNL_AdvSMR.Thermal.MetalTube metalTube(
    rhomcm=rhomcm,
    lambda=lambda,
    N=N_F,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    L=exchSurface_F^2/(fluidVol*pi*4),
    rint=fluidVol*4/exchSurface_F/2,
    WallRes=false,
    rext=(metalVol + fluidVol)*4/extSurfaceTub/2,
    Tstartbar=Tstartbar_M) annotation (Placement(transformation(extent={{-20,-6},
            {20,-26}}, rotation=0)));
  ThermoPower3.Gas.Flow1D gasFlow(
    Dhyd=1,
    wnom=gasNomFlowRate,
    N=N_G,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    redeclare package Medium = FlueGasMedium,
    QuasiStatic=gasQuasiStatic,
    pstart=pstart_G,
    L=L,
    A=gasVol/L,
    omega=exchSurface_G/L,
    FFtype=FFtype_G,
    Kfnom=Kfnom_G,
    dpnom=dpnom_G,
    rhonom=rhonom_G,
    Cfnom=Cfnom_G,
    Tstartbar=Tstartbar_G) annotation (Placement(transformation(extent={{-20,80},
            {20,40}}, rotation=0)));
  ORNL_AdvSMR.Thermal.CounterCurrent cC(N=N_F, counterCurrent=counterCurrent)
    annotation (Placement(transformation(extent={{-20,-10},{20,10}}, rotation=0)));
  ORNL_AdvSMR.Thermal.HeatFlowDistribution heatFlowDistribution(
    N=N_F,
    A1=exchSurface_G,
    A2=extSurfaceTub) annotation (Placement(transformation(extent={{-20,4},{20,
            24}}, rotation=0)));
  ORNL_AdvSMR.Thermal.ConvHT2N convHT2N(
    N1=N_G,
    N2=N_F,
    gamma=gamma_G) annotation (Placement(transformation(extent={{-20,20},{20,40}},
          rotation=0)));

  final parameter Modelica.SIunits.Distance L=1 "Tube length";
  parameter ORNL_AdvSMR.Choices.FluidPhase.FluidPhases FluidPhaseStart=
      ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid
    "Fluid phase (only for initialization!)"
    annotation (Dialog(tab="Initialization"));
equation
  connect(fluidFlow.wall, convHT.side2)
    annotation (Line(points={{0,-50},{0,-50},{0,-33.1}}, color={255,127,0}));
  connect(gasFlow.infl, gasIn) annotation (Line(
      points={{-20,60},{-100,60},{-100,0}},
      color={159,159,223},
      thickness=0.5));
  connect(gasFlow.outfl, gasOut) annotation (Line(
      points={{20,60},{100,60},{100,0}},
      color={159,159,223},
      thickness=0.5));
  connect(fluidFlow.outfl, waterOut) annotation (Line(
      points={{20,-60},{40,-60},{40,-100},{0,-100}},
      thickness=0.5,
      color={0,0,255}));
  connect(fluidFlow.infl, waterIn) annotation (Line(
      points={{-20,-60},{-40,-60},{-40,100},{0,100}},
      thickness=0.5,
      color={0,0,255}));
  connect(heatFlowDistribution.side2, cC.side1)
    annotation (Line(points={{0,10.9},{0,3}}, color={255,127,0}));
  connect(convHT2N.side1, gasFlow.wall)
    annotation (Line(points={{0,33},{0,33},{0,50}}, color={255,127,0}));
  connect(heatFlowDistribution.side1, convHT2N.side2)
    annotation (Line(points={{0,17},{0,17},{0,26.9}}, color={255,127,0}));
  connect(metalTube.int, convHT.side1)
    annotation (Line(points={{0,-19},{0,-27}}, color={255,127,0}));
  connect(metalTube.ext, cC.side2)
    annotation (Line(points={{0,-13},{0,-13},{0,-3.1}}, color={255,127,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end heatExchanger;
