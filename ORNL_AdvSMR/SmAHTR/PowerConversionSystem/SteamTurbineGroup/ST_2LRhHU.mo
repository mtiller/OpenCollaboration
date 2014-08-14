within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup;
model ST_2LRhHU
  "Steam Turbine Group (two pressure levels and reheat) with coupling Heat Usage"
  extends SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces.ST_2LRhHU;

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

  ThermoPower3.Water.SteamTurbineStodola ST_HP(
    redeclare package Medium = FluidMedium,
    wnom=steamHPNomFlowRate,
    eta_mech=HPT_eta_mech,
    eta_iso_nom=HPT_eta_iso_nom,
    Kt=HPT_Kt,
    wstart=HPT_wstart,
    PRstart=steamHPNomPressure/steamLPNomPressure,
    pnom=steamHPNomPressure) annotation (Placement(transformation(
          extent={{-116,-20},{-76,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_LP(
    redeclare package Medium = FluidMedium,
    eta_mech=LPT_eta_mech,
    eta_iso_nom=LPT_eta_iso_nom,
    Kt=LPT_Kt,
    wstart=LPT_wstart,
    wnom=steamHPNomFlowRate,
    PRstart=steamLPNomPressure/pcond,
    pnom=steamLPNomPressure) annotation (Placement(transformation(
          extent={{54,-20},{94,20}}, rotation=0)));
  ThermoPower3.Water.Mixer mixLP(
    redeclare package Medium = FluidMedium,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit,
    V=mixLP_V,
    pstart=mixLP_pstart,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Steam)
    annotation (Placement(transformation(
        origin={-60,56},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ThermoPower3.Water.ValveVap valveLP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    CheckValve=true,
    dpnom=valveLP_dpnom,
    redeclare package Medium = FluidMedium,
    Cv=valveLP_Cv,
    wnom=steamHPNomFlowRate) annotation (Placement(transformation(
          extent={{20,6},{40,26}}, rotation=0)));
  ThermoPower3.Water.ValveVap valveHP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    Cv=valveHP_Cv,
    pnom=steamHPNomPressure,
    wnom=steamHPNomFlowRate,
    CheckValve=true,
    dpnom=valveHP_dpnom,
    redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(extent={{-150,6},{-130,26}}, rotation=0)));
  ThermoPower3.Water.ValveVap byPassHP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamHPNomPressure,
    wnom=steamHPNomFlowRate,
    CheckValve=true,
    Cv=bypassHP_Cv,
    dpnom=steamHPNomPressure - steamLPNomPressure) annotation (
      Placement(transformation(extent={{-140,40},{-120,60}}, rotation=0)));
  ThermoPower3.Water.ValveVap byPassLP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    CheckValve=true,
    Cv=bypassLP_Cv,
    dpnom=steamLPNomPressure - pcond,
    wnom=steamHPNomFlowRate) annotation (Placement(transformation(
          extent={{40,40},{60,60}}, rotation=0)));
equation
  connect(ST_HP.shaft_a, Shaft_a) annotation (Line(
      points={{-109.2,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_b, Shaft_b) annotation (Line(
      points={{86.8,0},{144,0},{200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_a, ST_HP.shaft_b) annotation (Line(
      points={{60.8,0},{-12,0},{-83.2,0}},
      color={0,0,0},
      thickness=0.5));
  connect(valveHP.outlet, ST_HP.inlet) annotation (Line(
      points={{-130,16},{-112,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(valveLP.outlet, ST_LP.inlet)
    annotation (Line(points={{40,16},{50,16},{58,16}}, thickness=0.5));
  connect(ActuatorsBus.Opening_valveHP, valveHP.theta) annotation (Line(
        points={{200,-140},{-180,-140},{-180,32},{-140,32},{-140,24}},
        color={213,255,170}));
  connect(ActuatorsBus.Opening_valveLP, valveLP.theta) annotation (Line(
        points={{200,-140},{10,-140},{10,32},{30,32},{30,24}}, color={
          213,255,170}));
  connect(ActuatorsBus.Opening_byPassHP, byPassHP.theta) annotation (
      Line(points={{200,-140},{-20,-140},{-20,70},{-130,70},{-130,58}},
        color={213,255,170}));
  connect(ActuatorsBus.Opening_byPassLP, byPassLP.theta) annotation (
      Line(points={{200,-140},{10,-140},{10,70},{50,70},{50,58}}, color=
         {213,255,170}));
  connect(valveHP.inlet, HPT_In) annotation (Line(
      points={{-150,16},{-160,16},{-160,200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassHP.inlet, HPT_In) annotation (Line(
      points={{-140,50},{-160,50},{-160,200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_LP.outlet, LPT_Out) annotation (Line(
      points={{90,16},{120,16},{120,-120},{80,-120},{80,-200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassLP.outlet, LPT_Out) annotation (Line(
      points={{60,50},{120,50},{120,-120},{80,-120},{80,-200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassHP.outlet, mixLP.in2) annotation (Line(
      points={{-120,50},{-68,50}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_HP.outlet, mixLP.in2) annotation (Line(
      points={{-80,16},{-80,50},{-68,50}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(LPT_In, mixLP.in1) annotation (Line(
      points={{80,200},{80,80},{-80,80},{-80,62},{-68,62}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(mixLP.out, SteamForHU) annotation (Line(
      points={{-50,56},{-40,56},{-40,-200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(HPT_Out, SteamForHU) annotation (Line(
      points={{-100,200},{-100,110},{-40,110},{-40,-200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveLP.inlet, LPT_In_Rh) annotation (Line(
      points={{20,16},{0,16},{0,138},{-40,138},{-40,200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassLP.inlet, LPT_In_Rh) annotation (Line(
      points={{40,50},{0,50},{0,138},{-40,138},{-40,200}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent=
           {{-200,-200},{200,200}}), graphics));
end ST_2LRhHU;
