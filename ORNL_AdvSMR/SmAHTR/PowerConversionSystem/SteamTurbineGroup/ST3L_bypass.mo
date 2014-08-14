within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup;
model ST3L_bypass
  "Steam turbine with three pressure levels, inlet and by-pass valves "
  extends SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces.ST_3L;

  //Mixers Parameters
  parameter Modelica.SIunits.Volume mixLP_V "Internal volume of the LP mixer";
  parameter Modelica.SIunits.Pressure mixLP_pstart=steamLPNomPressure
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
  parameter Real valveIP_Cv=0 "Cv (US) flow coefficient of the IP valve"
    annotation (Dialog(group="IP valves"));
  parameter Modelica.SIunits.Pressure valveIP_dpnom
    "Nominal pressure drop of the IP valve"
    annotation (Dialog(group="IP valves"));
  parameter Real bypassIP_Cv=0
    "Cv (US) flow coefficient of the IP valve of bypass"
    annotation (Dialog(group="IP valves"));
  parameter Real valveDrumIP_Cv=0
    "Cv (US) flow coefficient of the valve of pressurization IP drum"
    annotation (Dialog(group="IP valves"));
  parameter Real valveLP_Cv=0 "Cv (US) flow coefficient of the LP valve"
    annotation (Dialog(group="LP valves"));
  parameter Modelica.SIunits.Pressure valveLP_dpnom
    "Nominal pressure drop of the LP valve"
    annotation (Dialog(group="LP valves"));
  parameter Real bypassLP_Cv=0
    "Cv (US) flow coefficient of the HP valve of bypass"
    annotation (Dialog(group="LP valves"));
  parameter Real valveDrumLP_Cv=0
    "Cv (US) flow coefficient of the valve of pressurization LP drum"
    annotation (Dialog(group="LP valves"));

  ThermoPower3.Water.Mixer mixLP(
    redeclare package Medium = FluidMedium,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState
         else ThermoPower3.Choices.Init.Options.noInit,
    V=mixLP_V,
    pstart=mixLP_pstart,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Steam)
    annotation (Placement(transformation(
        origin={74,90},
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
        origin={-140,16},
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
        origin={-20,16},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap valveLP(
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    dpnom=valveLP_dpnom,
    redeclare package Medium = FluidMedium,
    wnom=steamLPNomFlowRate + steamIPNomFlowRate + steamHPNomFlowRate,
    Cv=valveLP_Cv) annotation (Placement(transformation(
        origin={100,16},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap byPassHP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamHPNomPressure,
    wnom=steamHPNomFlowRate,
    dpnom=steamHPNomPressure - steamIPNomPressure,
    Cv=bypassHP_Cv) annotation (Placement(transformation(
        origin={-120,40},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap byPassIP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamIPNomPressure,
    dpnom=steamIPNomPressure - steamLPNomPressure,
    wnom=steamIPNomFlowRate + steamHPNomFlowRate,
    Cv=bypassIP_Cv) annotation (Placement(transformation(
        origin={0,40},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.ValveVap byPassLP(
    redeclare package Medium = FluidMedium,
    CvData=ThermoPower3.Choices.Valve.CvTypes.Cv,
    pnom=steamLPNomPressure,
    wnom=steamLPNomFlowRate + steamIPNomFlowRate + steamHPNomFlowRate,
    Cv=bypassLP_Cv,
    dpnom=steamLPNomPressure - pcond) annotation (Placement(
        transformation(
        origin={120,40},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ThermoPower3.Water.SensP p_ST_LP(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{90,
            74},{110,94}}, rotation=0)));
protected
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateHPT_in(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-160,90},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateHPT_out(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-100,90},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateIPT_in(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-40,90},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateIPT_out(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={44,90},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateLPT_in(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={74,62},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateLPT_out(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={176,-20},
        extent={{10,-10},{-10,10}},
        rotation=90)));
public
  ThermoPower3.Water.SteamTurbineStodola ST_HP(
    redeclare package Medium = FluidMedium,
    wnom=steamHPNomFlowRate,
    eta_mech=HPT_eta_mech,
    eta_iso_nom=HPT_eta_iso_nom,
    Kt=HPT_Kt,
    wstart=HPT_wstart,
    PRstart=steamHPNomPressure/steamIPNomPressure,
    pnom=steamHPNomPressure) annotation (Placement(transformation(
          extent={{-120,-20},{-80,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_IP(
    redeclare package Medium = FluidMedium,
    eta_mech=IPT_eta_mech,
    eta_iso_nom=IPT_eta_iso_nom,
    Kt=IPT_Kt,
    wstart=IPT_wstart,
    wnom=steamIPNomFlowRate + steamHPNomFlowRate,
    PRstart=steamIPNomPressure/steamLPNomPressure,
    pnom=steamIPNomPressure) annotation (Placement(transformation(
          extent={{8,-20},{48,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_LP(
    redeclare package Medium = FluidMedium,
    eta_mech=LPT_eta_mech,
    eta_iso_nom=LPT_eta_iso_nom,
    Kt=LPT_Kt,
    wstart=LPT_wstart,
    wnom=steamLPNomFlowRate + steamIPNomFlowRate + steamHPNomFlowRate,
    PRstart=steamLPNomPressure/pcond,
    pnom=steamLPNomPressure) annotation (Placement(transformation(
          extent={{120,-20},{160,20}}, rotation=0)));
equation
  connect(ActuatorsBus.Opening_valveHP, valveHP.theta) annotation (Line(
        points={{200,-140},{-180,-140},{-180,30},{-140,30},{-140,24}},
        color={213,255,170}));
  connect(ActuatorsBus.Opening_valveIP, valveIP.theta) annotation (Line(
        points={{200,-140},{-60,-140},{-60,34},{-20,34},{-20,24}},
        color={213,255,170}));
  connect(ActuatorsBus.Opening_valveLP, valveLP.theta) annotation (Line(
        points={{200,-140},{60,-140},{60,32},{100,32},{100,24}}, color=
          {213,255,170}));
  connect(ActuatorsBus.Opening_byPassHP, byPassHP.theta) annotation (
      Line(points={{200,-140},{-180,-140},{-180,30},{-140,30},{-140,60},
          {-120,60},{-120,48}}, color={213,255,170}));
  connect(ActuatorsBus.Opening_byPassIP, byPassIP.theta) annotation (
      Line(points={{200,-140},{-60,-140},{-60,34},{-20,34},{-20,60},{
          9.79717e-016,60},{9.79717e-016,48}}, color={213,255,170}));
  connect(ActuatorsBus.Opening_byPassLP, byPassLP.theta) annotation (
      Line(points={{200,-140},{60,-140},{60,32},{100,32},{100,60},{120,
          60},{120,48}}, color={213,255,170}));
  connect(SensorsBus.p_STLP_in, p_ST_LP.p) annotation (Line(points={{
          200,-80},{-60,-80},{-60,160},{134,160},{134,90},{108,90}},
        color={255,170,213}));
  connect(p_ST_LP.flange, mixLP.out) annotation (Line(
      points={{100,80},{74,80}},
      color={0,0,255},
      thickness=0.5));
  connect(stateHPT_in.inlet, HPT_In) annotation (Line(
      points={{-160,96},{-160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateIPT_in.inlet, IPT_In) annotation (Line(
      points={{-40,96},{-40,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateIPT_out.outlet, mixLP.in2) annotation (Line(
      points={{44,96},{44,140},{68,140},{68,98}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateLPT_in.inlet, mixLP.out)
    annotation (Line(points={{74,68},{74,80}}, thickness=0.5));
  connect(LPT_Out, stateLPT_out.outlet) annotation (Line(
      points={{140,-200},{140,-40},{176,-40},{176,-26}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateHPT_out.outlet, HPT_Out) annotation (Line(
      points={{-100,96},{-100,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(mixLP.in1, LPT_In) annotation (Line(
      points={{80,98},{80,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateLPT_out.inlet, byPassLP.outlet) annotation (Line(
      points={{176,-14},{176,40},{130,40}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveLP.inlet, stateLPT_in.outlet) annotation (Line(
      points={{90,16},{74,16},{74,56}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassLP.inlet, stateLPT_in.outlet) annotation (Line(
      points={{110,40},{74,40},{74,56}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassIP.outlet, stateIPT_out.inlet) annotation (Line(
      points={{10,40},{44,40},{44,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassIP.inlet, stateIPT_in.outlet) annotation (Line(
      points={{-10,40},{-40,40},{-40,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveIP.inlet, stateIPT_in.outlet) annotation (Line(
      points={{-30,16},{-40,16},{-40,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassHP.outlet, stateHPT_out.inlet) annotation (Line(
      points={{-110,40},{-100,40},{-100,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(byPassHP.inlet, stateHPT_in.outlet) annotation (Line(
      points={{-130,40},{-160,40},{-160,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveHP.inlet, stateHPT_in.outlet) annotation (Line(
      points={{-150,16},{-160,16},{-160,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_IP.shaft_a, ST_HP.shaft_b) annotation (Line(
      points={{14.8,0},{14.8,0},{-87.2,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_HP.shaft_a, Shaft_a) annotation (Line(
      points={{-113.2,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_a, ST_IP.shaft_b) annotation (Line(
      points={{126.8,0},{126.8,0},{40.8,0}},
      color={0,0,0},
      thickness=0.5));
  connect(Shaft_b, ST_LP.shaft_b) annotation (Line(
      points={{200,0},{200,0},{152.8,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_HP.inlet, valveHP.outlet) annotation (Line(
      points={{-116,16},{-123,16},{-123,16},{-130,16}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_HP.outlet, stateHPT_out.inlet) annotation (Line(
      points={{-84,16},{-84,40},{-100,40},{-100,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_IP.outlet, stateIPT_out.inlet) annotation (Line(
      points={{44,16},{44,84}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_IP.inlet, valveIP.outlet) annotation (Line(
      points={{12,16},{1,16},{1,16},{-10,16}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(valveLP.outlet, ST_LP.inlet) annotation (Line(
      points={{110,16},{117,16},{117,16},{124,16}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_LP.outlet, stateLPT_out.inlet) annotation (Line(
      points={{156,16},{176,16},{176,-14}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent=
           {{-200,-200},{200,200}}), graphics), Icon(graphics));
end ST3L_bypass;
