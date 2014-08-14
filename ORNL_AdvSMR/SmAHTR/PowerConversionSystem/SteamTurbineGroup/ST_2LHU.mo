within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup;
model ST_2LHU
  "Steam Turbine Group (two pressure levels) with coupling Heat Usage"
  extends SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces.ST_2LHU;

  //Mixers Parameters
  parameter Modelica.SIunits.Volume mixLP_V "Internal volume of the LP mixer";
  parameter Modelica.SIunits.Pressure mixLP_pstart
    "Pressure start value of the LP mixer"
    annotation (Dialog(tab="Initialization", group="LP mixer"));

  //Valves Parameters
  parameter Real valveHP_Cv=0 "Cv (US) flow coefficient of the HP valve"
    annotation (Dialog(group="HP valves"));
  parameter Modelica.SIunits.Pressure valveHP_dpnom
    "Nominal pressure drop of the HP valve"
    annotation (Dialog(group="HP valves"));
  parameter Real bypassHP_Cv=0
    "Cv (US) flow coefficient of the HP valve of bypass"
    annotation (Dialog(group="HP valves"));
  parameter Real valveLP_Cv=0 "Cv (US) flow coefficient of the LP valve"
    annotation (Dialog(group="LP valves"));
  parameter Modelica.SIunits.Pressure valveLP_dpnom
    "Nominal pressure drop of the LP valve"
    annotation (Dialog(group="LP valves"));
  parameter Real bypassLP_Cv=0
    "Cv (US) flow coefficient of the HP valve of bypass"
    annotation (Dialog(group="LP valves"));
  parameter Real valveHU_Cv=0 "Cv (US) flow coefficient of the valve for HU"
    annotation (Dialog(group="Heat Usage valve"));
  parameter Modelica.SIunits.Pressure valveHU_dpnom
    "Nominal pressure drop of the valve for HU"
    annotation (Dialog(group="Heat Usage valve"));

  ThermoPower3.Water.SteamTurbineStodola ST_HP(
    redeclare package Medium = FluidMedium,
    wnom=steamHPNomFlowRate,
    eta_mech=HPT_eta_mech,
    eta_iso_nom=HPT_eta_iso_nom,
    Kt=HPT_Kt,
    wstart=HPT_wstart,
    PRstart=steamHPNomPressure/steamLPNomPressure,
    pnom=steamHPNomPressure) annotation (Placement(transformation(
          extent={{-84,-20},{-44,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_LP(
    redeclare package Medium = FluidMedium,
    eta_mech=LPT_eta_mech,
    eta_iso_nom=LPT_eta_iso_nom,
    Kt=LPT_Kt,
    wstart=LPT_wstart,
    wnom=steamHPNomFlowRate,
    PRstart=steamLPNomPressure/pcond,
    pnom=steamLPNomPressure) annotation (Placement(transformation(
          extent={{94,-20},{134,20}}, rotation=0)));
  ThermoPower3.Water.Mixer mixLP(
    redeclare package Medium = FluidMedium,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit,
    V=mixLP_V,
    pstart=mixLP_pstart,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Steam)
    annotation (Placement(transformation(
        origin={-40,-110},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap valveHU(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    CheckValve=true,
    redeclare package Medium = FluidMedium,
    Cv=valveHU_Cv,
    dpnom=valveHU_dpnom,
    pnom=steamLPNomPressure,
    wnom=steamHPNomFlowRate) annotation (Placement(transformation(
        origin={-19,-25},
        extent={{9,-9},{-9,9}},
        rotation=90)));
  ThermoPower3.Water.ValveVap valveLP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    CheckValve=true,
    dpnom=valveLP_dpnom,
    redeclare package Medium = FluidMedium,
    Cv=valveLP_Cv,
    wnom=steamHPNomFlowRate) annotation (Placement(transformation(
          extent={{60,6},{80,26}}, rotation=0)));
  ThermoPower3.Water.ValveVap valveHP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    Cv=valveHP_Cv,
    pnom=steamHPNomPressure,
    wnom=steamHPNomFlowRate,
    CheckValve=true,
    dpnom=valveHP_dpnom,
    redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(extent={{-114,6},{-94,26}}, rotation=0)));
  ThermoPower3.Water.ValveVap byPassHP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamHPNomPressure,
    wnom=steamHPNomFlowRate,
    CheckValve=true,
    Cv=bypassHP_Cv,
    dpnom=steamHPNomPressure - steamLPNomPressure) annotation (
      Placement(transformation(extent={{-100,40},{-80,60}}, rotation=0)));
  ThermoPower3.Water.ValveVap byPassLP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    CheckValve=true,
    Cv=bypassLP_Cv,
    dpnom=steamLPNomPressure - pcond,
    wnom=steamHPNomFlowRate) annotation (Placement(transformation(
          extent={{80,40},{100,60}}, rotation=0)));
equation
  connect(ST_HP.shaft_a, Shaft_a) annotation (Line(
      points={{-77.2,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_b, Shaft_b) annotation (Line(
      points={{126.8,0},{200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_a, ST_HP.shaft_b) annotation (Line(
      points={{100.8,0},{-51.2,0}},
      color={0,0,0},
      thickness=0.5));
  connect(valveHP.outlet, ST_HP.inlet) annotation (Line(
      points={{-94,16},{-80,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(mixLP.out, SteamForHU) annotation (Line(
      points={{-50,-110},{-60,-110},{-60,-200}},
      thickness=0.5,
      color={0,0,255}));
  connect(LPT_In, mixLP.in1) annotation (Line(
      points={{0,200},{0,-116},{-32,-116}},
      thickness=0.5,
      color={0,0,255}));
  connect(valveLP.outlet, ST_LP.inlet)
    annotation (Line(points={{80,16},{98,16}}, thickness=0.5));
  connect(mixLP.in2, valveHU.outlet) annotation (Line(
      points={{-32,-104},{-19,-104},{-19,-34}},
      thickness=0.5,
      color={0,0,255}));
  connect(ActuatorsBus.Opening_valveHP, valveHP.theta) annotation (Line(
        points={{200,-140},{-140,-140},{-140,32},{-104,32},{-104,24}},
        color={213,255,170}));
  connect(ActuatorsBus.Opening_valveLP, valveLP.theta) annotation (Line(
        points={{200,-140},{50,-140},{50,32},{70,32},{70,24}}, color={
          213,255,170}));
  connect(ActuatorsBus.Opening_byPassHP, byPassHP.theta) annotation (
      Line(points={{200,-140},{20,-140},{20,70},{-90,70},{-90,58}},
        color={213,255,170}));
  connect(ActuatorsBus.Opening_byPassLP, byPassLP.theta) annotation (
      Line(points={{200,-140},{50,-140},{50,70},{90,70},{90,58}}, color=
         {213,255,170}));
  connect(ActuatorsBus.Opening_valveHU, valveHU.theta) annotation (Line(
        points={{200,-140},{50,-140},{50,-60},{-40,-60},{-40,-25},{-26.2,
          -25}}, color={213,255,170}));
  connect(ST_LP.outlet, LPT_Out) annotation (Line(
      points={{130,16},{160,16},{160,-160},{48,-160},{48,-200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));

  connect(byPassLP.outlet, LPT_Out) annotation (Line(
      points={{100,50},{160,50},{160,-160},{48,-160},{48,-200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassHP.inlet, HPT_In) annotation (Line(
      points={{-100,50},{-120,50},{-120,200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveHP.inlet, HPT_In) annotation (Line(
      points={{-114,16},{-120,16},{-120,200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_HP.outlet, valveLP.inlet) annotation (Line(
      points={{-48,16},{60,16}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveHU.inlet, ST_HP.outlet) annotation (Line(
      points={{-19,-16},{-19,16},{-48,16}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_HP.outlet, byPassHP.outlet) annotation (Line(
      points={{-48,16},{-34,16},{-34,50},{-80,50}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassLP.inlet, ST_HP.outlet) annotation (Line(
      points={{80,50},{40,50},{40,16},{-48,16}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent=
           {{-200,-200},{200,200}}), graphics));
end ST_2LHU;
