within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup;
model ST3L_base_noMixing "Steam turbine with three pressure levels"
  extends Interfaces.ST_3L_noMixing;

  //Mixers Parameters
  parameter Modelica.SIunits.Volume mixLP_V "Internal volume of the LP mixer";
  parameter Modelica.SIunits.Pressure mixLP_pstart=steamLPNomPressure
    "Pressure start value of the LP mixer"
    annotation (Dialog(tab="Initialization", group="LP mixer"));

  ThermoPower3.Water.SteamTurbineStodola ST_HP(
    redeclare package Medium = FluidMedium,
    wnom=steamHPNomFlowRate,
    eta_mech=HPT_eta_mech,
    eta_iso_nom=HPT_eta_iso_nom,
    Kt=HPT_Kt,
    wstart=HPT_wstart,
    PRstart=steamHPNomPressure/steamIPNomPressure,
    pnom=steamHPNomPressure) annotation (Placement(transformation(extent={{-152,
            -20},{-112,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_IP(
    redeclare package Medium = FluidMedium,
    eta_mech=IPT_eta_mech,
    eta_iso_nom=IPT_eta_iso_nom,
    Kt=IPT_Kt,
    wstart=IPT_wstart,
    wnom=steamIPNomFlowRate + steamHPNomFlowRate,
    PRstart=steamIPNomPressure/steamLPNomPressure,
    pnom=steamIPNomPressure) annotation (Placement(transformation(extent={{-20,
            -20},{20,20}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_LP(
    redeclare package Medium = FluidMedium,
    eta_mech=LPT_eta_mech,
    eta_iso_nom=LPT_eta_iso_nom,
    Kt=LPT_Kt,
    wstart=LPT_wstart,
    wnom=steamLPNomFlowRate + steamIPNomFlowRate + steamHPNomFlowRate,
    PRstart=steamLPNomPressure/pcond,
    pnom=steamLPNomPressure) annotation (Placement(transformation(extent={{100,
            -20},{140,20}}, rotation=0)));
protected
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateHPT_in(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-160,70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateHPT_out(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-100,70},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateIPT_in(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-40,70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateIPT_out(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={40,70},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateLPT_in(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={80,70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateLPT_out(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={160,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(ST_HP.shaft_a, Shaft_a) annotation (Line(
      points={{-145.2,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(Shaft_b, ST_LP.shaft_b) annotation (Line(
      points={{200,0},{132.8,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_LP.shaft_a, ST_IP.shaft_b) annotation (Line(
      points={{106.8,0},{12.8,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_IP.shaft_a, ST_HP.shaft_b) annotation (Line(
      points={{-13.2,0},{-119.2,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_HP.inlet, stateHPT_in.outlet) annotation (Line(
      points={{-148,16},{-160,16},{-160,64}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateHPT_in.inlet, HPT_In) annotation (Line(
      points={{-160,76},{-160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_HP.outlet, stateHPT_out.inlet) annotation (Line(
      points={{-116,16},{-100,16},{-100,64}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_IP.inlet, stateIPT_in.outlet) annotation (Line(
      points={{-16,16},{-40,16},{-40,64}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateIPT_in.inlet, IPT_In) annotation (Line(
      points={{-40,76},{-40,140},{-40,140},{0,140},{0,200},{0,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_IP.outlet, stateIPT_out.inlet) annotation (Line(
      points={{16,16},{40,16},{40,64}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateLPT_in.outlet, ST_LP.inlet) annotation (Line(
      points={{80,64},{80,16},{104,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(ST_LP.outlet, stateLPT_out.inlet) annotation (Line(
      points={{136,16},{160,16},{160,-24}},
      thickness=0.5,
      color={0,0,255}));
  connect(LPT_Out, stateLPT_out.outlet) annotation (Line(
      points={{140,-200},{140,-50},{160,-50},{160,-36}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateHPT_out.outlet, HPT_Out) annotation (Line(
      points={{-100,76},{-100,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(IPT_Out, stateIPT_out.outlet) annotation (Line(
      points={{60,200},{60,120},{40,120},{40,76}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(LPT_In, stateLPT_in.inlet) annotation (Line(
      points={{160,200},{160,120},{80,120},{80,76}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics));
end ST3L_base_noMixing;
