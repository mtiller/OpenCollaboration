within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup;
model STG_3LRh_cc
  "Steam turbine group (three pressure levels, reheat) and controlled condenser"
  extends Interfaces.STGroup3LRh;
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.ST3L_base steamTurbines(
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
    steamHPNomPressure=12800000,
    steamIPNomPressure=2680000,
    steamLPNomPressure=600000,
    SSInit=SSInit,
    pcond=5398.2) annotation (Placement(transformation(extent={{-80,-50},{20,50}},
          rotation=0)));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.CondPlant_cc
    controlledCondeser(
    redeclare package FluidMedium = FluidMedium,
    Vtot=10,
    Vlstart=1.5,
    setPoint_ratio=0.85,
    p=5398.2,
    SSInit=SSInit) annotation (Placement(transformation(extent={{-26,-140},{34,
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
        origin={84,-180},
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
  connect(controlledCondeser.SteamIn, steamTurbines.LPT_Out) annotation (Line(
      points={{4,-80},{4,-50},{5,-50}},
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
  connect(steamTurbines.HPT_In, From_SH_HP) annotation (Line(
      points={{-70,50},{-70,100},{-160,100},{-160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.LPT_In, From_SH_LP) annotation (Line(
      points={{-10,50},{-10,100},{80,100},{80,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(SensorsBus, steamTurbines.SensorsBus) annotation (Line(points={{200,-80},
          {80,-80},{80,-20},{20,-20}}, color={255,170,213}));
  connect(SensorsBus, controlledCondeser.SensorsBus) annotation (Line(points={{
          200,-80},{80,-80},{80,-122},{33.4,-122}}, color={255,170,213}));
  connect(ActuatorsBus, steamTurbines.ActuatorsBus) annotation (Line(points={{
          200,-140},{100,-140},{100,-35},{20,-35}}, color={213,255,170}));
  connect(ActuatorsBus, controlledCondeser.ActuatorsBus) annotation (Line(
        points={{200,-140},{100,-140},{100,-131.6},{33.4,-131.6}}, color={213,
          255,170}));
  connect(totalFeedPump.outlet, WaterOut) annotation (Line(
      points={{100,-180},{160,-180},{160,200}},
      thickness=0.5,
      color={0,0,255}));
  connect(ActuatorsBus.nPump_feedLP, totalFeedPump.pumpSpeed_rpm) annotation (
      Line(points={{200,-140},{48,-140},{48,-170.4},{72.48,-170.4}}, color={213,
          255,170}));
  connect(controlledCondeser.WaterOut, totalFeedPump.inlet) annotation (Line(
      points={{4,-140},{4,-180},{68,-180}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,
            -200},{200,200}}), graphics));
end STG_3LRh_cc;
