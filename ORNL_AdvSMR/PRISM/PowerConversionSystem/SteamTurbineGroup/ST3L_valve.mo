within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup;
model ST3L_valve "Steam turbine with three pressure levels, inlet valves"
  extends Interfaces.ST_3L;

  //Mixers Parameters
  parameter Modelica.SIunits.Volume mixLP_V "Internal volume of the LP mixer";

  //Valves Parameters
  parameter Real valveHP_Cv=0 "Cv (US) flow coefficient of the HP valve"
    annotation (Dialog(group="HP valve"));
  parameter Modelica.SIunits.Pressure valveHP_dpnom
    "Nominal pressure drop of the HP valve"
    annotation (Dialog(group="HP valve"));
  parameter Real valveIP_Cv=0 "Cv (US) flow coefficient of the IP valve"
    annotation (Dialog(group="IP valve"));
  parameter Modelica.SIunits.Pressure valveIP_dpnom
    "Nominal pressure drop of the IP valve"
    annotation (Dialog(group="IP valve"));
  parameter Real valveLP_Cv=0 "Cv (US) flow coefficient of the LP valve"
    annotation (Dialog(group="LP valve"));
  parameter Modelica.SIunits.Pressure valveLP_dpnom
    "Nominal pressure drop of the LP valve"
    annotation (Dialog(group="LP valve"));

  ThermoPower3.Water.SteamTurbineStodola ST_HP(
    redeclare package Medium = FluidMedium,
    wnom=steamHPNomFlowRate,
    eta_mech=HPT_eta_mech,
    eta_iso_nom=HPT_eta_iso_nom,
    Kt=HPT_Kt,
    pnom=steamHPNomPressure,
    PRstart=steamHPNomPressure/steamIPNomPressure) annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_IP(
    redeclare package Medium = FluidMedium,
    eta_mech=IPT_eta_mech,
    eta_iso_nom=IPT_eta_iso_nom,
    Kt=IPT_Kt,
    wnom=steamIPNomFlowRate + steamHPNomFlowRate,
    pnom=steamIPNomPressure,
    PRstart=steamIPNomPressure/steamLPNomPressure) annotation (Placement(
        transformation(extent={{2,-20},{42,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_LP(
    redeclare package Medium = FluidMedium,
    eta_mech=LPT_eta_mech,
    eta_iso_nom=LPT_eta_iso_nom,
    Kt=LPT_Kt,
    wnom=steamLPNomFlowRate + steamIPNomFlowRate + steamHPNomFlowRate,
    pnom=steamLPNomPressure,
    PRstart=steamLPNomPressure/pcond) annotation (Placement(transformation(
          extent={{122,-20},{162,20}}, rotation=0)));
  ThermoPower3.Water.Mixer mixLP(
    redeclare package Medium = FluidMedium,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    V=mixLP_V,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Steam,
    pstart=steamLPNomPressure) annotation (Placement(transformation(
        origin={76,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoPower3.Water.ValveVap valveHP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    Cv=valveHP_Cv,
    pnom=steamHPNomPressure,
    wnom=steamHPNomFlowRate,
    dpnom=valveHP_dpnom,
    redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-138,16},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap valveIP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    Cv=valveIP_Cv,
    pnom=steamIPNomPressure,
    dpnom=valveIP_dpnom,
    redeclare package Medium = FluidMedium,
    wnom=steamIPNomFlowRate + steamHPNomFlowRate) annotation (Placement(
        transformation(
        origin={-18,16},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap valveLP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    dpnom=valveLP_dpnom,
    redeclare package Medium = FluidMedium,
    wnom=steamLPNomFlowRate + steamIPNomFlowRate + steamHPNomFlowRate,
    Cv=valveLP_Cv) annotation (Placement(transformation(
        origin={102,16},
        extent={{10,10},{-10,-10}},
        rotation=180)));
equation
  connect(valveIP.outlet, ST_IP.inlet) annotation (Line(
      points={{-8,16},{-1,16},{6,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(ActuatorsBus.Opening_valveHP, valveHP.theta) annotation (Line(
      points={{200,-140},{-180,-140},{-180,40},{-138,40},{-138,24}},
      color={85,255,85},
      thickness=0.5));
  connect(ActuatorsBus.Opening_valveIP, valveIP.theta) annotation (Line(
      points={{200,-140},{-60,-140},{-60,40},{-18,40},{-18,24}},
      color={85,255,85},
      thickness=0.5));
  connect(ActuatorsBus.Opening_valveLP, valveLP.theta) annotation (Line(
      points={{200,-140},{60,-140},{60,40},{102,40},{102,24}},
      color={85,255,85},
      thickness=0.5));
  connect(ST_HP.inlet, valveHP.outlet) annotation (Line(
      points={{-116,16},{-128,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_HP.shaft_a, Shaft_a) annotation (Line(
      points={{-113.2,0},{-165.6,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.inlet, valveLP.outlet) annotation (Line(
      points={{126,16},{119,16},{119,16},{112,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(Shaft_b, ST_LP.shaft_b) annotation (Line(
      points={{200,0},{168.4,0},{154.8,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_a, ST_IP.shaft_b) annotation (Line(
      points={{128.8,0},{34.8,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_IP.shaft_a, ST_HP.shaft_b) annotation (Line(
      points={{8.8,0},{-87.2,0}},
      color={0,0,0},
      thickness=0.5));
  connect(mixLP.in1, LPT_In) annotation (Line(
      points={{82,98},{82,139},{82,200},{80,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(valveHP.inlet, HPT_In) annotation (Line(
      points={{-148,16},{-160,16},{-160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_HP.outlet, HPT_Out) annotation (Line(
      points={{-84,16},{-70,16},{-70,120},{-100,120},{-100,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(valveIP.inlet, IPT_In) annotation (Line(
      points={{-28,16},{-40,16},{-40,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_IP.outlet, mixLP.in2) annotation (Line(
      points={{38,16},{50,16},{50,120},{70,120},{70,98}},
      thickness=0.5,
      color={0,0,255}));
  connect(valveLP.inlet, mixLP.out) annotation (Line(
      points={{92,16},{76,16},{76,80}},
      thickness=0.5,
      color={0,0,255}));
  connect(LPT_Out, ST_LP.outlet) annotation (Line(
      points={{140,-200},{140,-40},{182,-40},{182,16},{158,16}},
      thickness=0.5,
      color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-200,
            -200},{200,200}}), graphics), Icon(graphics));
end ST3L_valve;
