within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup;
model STG_3LRh_valve
  "Steam turbine group (three pressure levels, reheat) with inlet valves"
  extends SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces.STGroup3LRh;
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.ST3L_valve
    steamTurbines(
    redeclare package FluidMedium = FluidMedium,
    steamHPNomFlowRate=67.6,
    steamIPNomFlowRate=81.10 - 67.5,
    steamLPNomFlowRate=89.82 - 81.10,
    HPT_eta_iso_nom=0.833,
    IPT_eta_iso_nom=0.903,
    LPT_eta_iso_nom=0.876,
    mixLP_V=20,
    valveHP_Cv=1165,
    valveIP_Cv=5625,
    valveLP_Cv=14733,
    HPT_Kt=0.0032078,
    IPT_Kt=0.018883,
    LPT_Kt=0.078004,
    steamHPNomPressure=12800000,
    steamIPNomPressure=2680000,
    steamLPNomPressure=600000,
    SSInit=SSInit,
    pcond=5398.2,
    valveHP_dpnom=160000,
    valveIP_dpnom=50000,
    valveLP_dpnom=29640) annotation (Placement(transformation(extent={{
            -80,-50},{20,50}}, rotation=0)));
  ThermoPower3.PowerPlants.HRSG.Components.PrescribedSpeedPump
    totalFeedPump(
    redeclare package WaterMedium = FluidMedium,
    rho0=1000,
    q_nom={0.0898,0,0.1},
    head_nom={72.74,130,0},
    nominalFlow=89.8,
    n0=1500,
    nominalOutletPressure=600000,
    nominalInletPressure=5398.2) annotation (Placement(transformation(
        origin={98,-180},
        extent={{16,16},{-16,-16}},
        rotation=180)));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.CondPlant_open
    controlledCondeser(
    redeclare package FluidMedium = FluidMedium,
    Vlstart=1.5,
    SSInit=SSInit,
    p=5398.2,
    Vtot=1,
    setPoint_ratio=1) annotation (Placement(transformation(extent={{-24,
            -150},{36,-90}}, rotation=0)));
equation
  connect(steamTurbines.Shaft_a, Shaft_a) annotation (Line(
      points={{-80,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(steamTurbines.Shaft_b, Shaft_b) annotation (Line(
      points={{20,0},{200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ActuatorsBus, steamTurbines.ActuatorsBus) annotation (Line(
        points={{200,-140},{60,-140},{60,-35},{20,-35}}, color={213,255,
          170}));
  connect(steamTurbines.IPT_In, From_RH_IP) annotation (Line(
      points={{-40,50},{-40,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.LPT_In, From_SH_LP) annotation (Line(
      points={{-10,50},{-10,100},{80,100},{80,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_Out, To_RH_IP) annotation (Line(
      points={{-55,50},{-55,140},{-100,140},{-100,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_In, From_SH_HP) annotation (Line(
      points={{-70,50},{-70,100},{-160,100},{-160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(SensorsBus, steamTurbines.SensorsBus) annotation (Line(points=
         {{200,-80},{66,-80},{66,-20},{20,-20}}, color={255,170,213}));
  connect(totalFeedPump.outlet, WaterOut) annotation (Line(
      points={{114,-180},{160,-180},{160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(controlledCondeser.SteamIn, steamTurbines.LPT_Out)
    annotation (Line(
      points={{6,-90},{6,-50},{5,-50}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(controlledCondeser.WaterOut, totalFeedPump.inlet) annotation (
     Line(
      points={{6,-150},{6,-180},{82,-180}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ActuatorsBus.nPump_feedLP, totalFeedPump.pumpSpeed_rpm)
    annotation (Line(points={{200,-140},{60,-140},{60,-170.4},{86.48,-170.4}},
        color={213,255,170}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent=
           {{-200,-200},{200,200}}), graphics));
end STG_3LRh_valve;
