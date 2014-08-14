within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup;
model STG_3LRh_valve_cc
  "Steam turbine group (three pressure levels, reheat) with inlet valves and controlled condenser"
  extends Interfaces.STGroup3LRh;
  ST3L_valve steamTurbines(
    redeclare package FluidMedium = FluidMedium,
    steamHPNomFlowRate=67.6,
    HPT_eta_iso_nom=0.833,
    IPT_eta_iso_nom=0.903,
    LPT_eta_iso_nom=0.876,
    HPT_Kt=0.0032078,
    IPT_Kt=0.018883,
    LPT_Kt=0.078004,
    mixLP_V=5,
    steamIPNomFlowRate=81.3524 - 67.6,
    steamLPNomFlowRate=89.438 - 81.3524,
    valveHP_Cv=1165,
    valveIP_Cv=5625,
    valveLP_Cv=14733,
    steamHPNomPressure=12800000,
    steamIPNomPressure=2680000,
    steamLPNomPressure=600000,
    SSInit=SSInit,
    pcond=5398.2,
    valveHP_dpnom=160000,
    valveIP_dpnom=50000,
    valveLP_dpnom=29640) annotation (Placement(transformation(extent={{-80,-50},
            {20,50}}, rotation=0)));
  CondenserGroup.CondPlant_cc controlledCondeser(
    redeclare package FluidMedium = FluidMedium,
    Vtot=10,
    Vlstart=1.5,
    setPoint_ratio=0.85,
    p=5398.2,
    SSInit=SSInit) annotation (Placement(transformation(extent={{-24,-140},{36,
            -80}}, rotation=0)));
  ThermoPower3.PowerPlants.HRSG.Components.PrescribedSpeedPump totalFeedPump(
    redeclare package WaterMedium = FluidMedium,
    rho0=1000,
    q_nom={0.0898,0,0.1},
    head_nom={72.74,130,0},
    nominalFlow=89.8,
    n0=1500,
    nominalOutletPressure=600000,
    nominalInletPressure=5398.2) annotation (Placement(transformation(
        origin={94,-182},
        extent={{16,16},{-16,-16}},
        rotation=180)));
equation
  connect(steamTurbines.Shaft_b, Shaft_b) annotation (Line(
      points={{20,0},{200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(steamTurbines.Shaft_a, Shaft_a) annotation (Line(
      points={{-80,0},{-200,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ActuatorsBus, steamTurbines.ActuatorsBus) annotation (Line(points={{
          200,-140},{100,-140},{100,-35},{20,-35}}, color={213,255,170}));
  connect(controlledCondeser.SteamIn, steamTurbines.LPT_Out) annotation (Line(
      points={{6,-80},{6,-50},{5,-50}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.IPT_In, From_RH_IP) annotation (Line(
      points={{-40,50},{-40,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_Out, To_RH_IP) annotation (Line(
      points={{-55,50},{-55,140},{-100,140},{-100,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.LPT_In, From_SH_LP) annotation (Line(
      points={{-10,50},{-10,100},{80,100},{80,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_In, From_SH_HP) annotation (Line(
      points={{-70,50},{-70,100},{-160,100},{-160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(SensorsBus, steamTurbines.SensorsBus) annotation (Line(points={{200,-80},
          {80,-80},{80,-20},{20,-20}}, color={255,170,213}));
  connect(SensorsBus, controlledCondeser.SensorsBus) annotation (Line(points={{
          200,-80},{80,-80},{80,-122},{35.4,-122}}, color={255,170,213}));
  connect(ActuatorsBus, controlledCondeser.ActuatorsBus) annotation (Line(
        points={{200,-140},{100,-140},{100,-131.6},{35.4,-131.6}}, color={213,
          255,170}));
  connect(totalFeedPump.outlet, WaterOut) annotation (Line(
      points={{110,-182},{160,-182},{160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(ActuatorsBus.nPump_feedLP, totalFeedPump.pumpSpeed_rpm) annotation (
      Line(points={{200,-140},{58,-140},{58,-172.4},{82.48,-172.4}}, color={213,
          255,170}));
  connect(controlledCondeser.WaterOut, totalFeedPump.inlet) annotation (Line(
      points={{6,-140},{6,-182},{78,-182}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-200,
            -200},{200,200}}), graphics));
end STG_3LRh_valve_cc;
