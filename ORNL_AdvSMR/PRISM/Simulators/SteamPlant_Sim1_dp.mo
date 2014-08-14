within ORNL_AdvSMR.PRISM.Simulators;
model SteamPlant_Sim1_dp
  "Test total plant with levels control and ratio control on the condenser, inlet valves"
  package FlueGasMedium = ThermoPower3.Media.FlueGas;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  parameter Boolean SSInit=true "Steady-state initialization";

  ThermoPower3.Gas.SourceW sourceGas(
    redeclare package Medium = FlueGasMedium,
    w0=585.5,
    T=884.65) annotation (Placement(transformation(extent={{-168,90},{-132,110}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-50,
    duration=500,
    offset=585.5,
    startTime=4000) annotation (Placement(transformation(extent={{-190,120},{-170,
            140}}, rotation=0)));
public
  inner ThermoPower3.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{160,160},{200,200}})));
  ThermoPower3.PowerPlants.HRSG.Examples.HRSG_3LRh hRSG(
    SSInit=true,
    HeatExchangersGroup(
      fluidHPNomPressure_Sh=1.22116e7,
      fluidHPNomPressure_Ev=1.22116e7,
      fluidHPNomPressure_Ec=1.22116e7,
      fluidIPNomPressure_Rh=2.63694e6,
      fluidIPNomPressure_Sh=2.63694e6,
      fluidIPNomPressure_Ev=2.63694e6,
      fluidIPNomPressure_Ec=2.63694e6,
      fluidLPNomPressure_Sh=6.0474e5,
      fluidLPNomPressure_Ev=6.0474e5,
      fluidLPNomPressure_Ec=6.0474e5,
      fluidHPNomFlowRate_Sh=62.8,
      fluidHPNomFlowRate_Ec=64.5,
      fluidIPNomFlowRate_Rh=77.36,
      fluidIPNomFlowRate_Sh=14.5,
      fluidIPNomFlowRate_Ec=13.5,
      fluidLPNomFlowRate_Sh=10.95,
      fluidLPNomFlowRate_Ec=89.8,
      Sh_LP(gamma_G=30, gamma_F=4000),
      Sh_LP_N_F=4,
      Ec_LP(gamma_G=35, gamma_F=3000),
      Ev_LP(gamma_G=60, gamma_F=20000),
      Sh1HP_Rh1IP(
        gamma_G_A=70,
        gamma_G_B=70,
        gamma_F_A=4000,
        gamma_F_B=4000),
      Sh2HP_Rh2IP(
        gamma_F_A=4000,
        gamma_F_B=4000,
        gamma_G_A=70,
        gamma_G_B=70)),
    drums(
      fluidHPNomPressure=12211600,
      fluidIPNomPressure=2636940,
      fluidLPNomPressure=604700)) annotation (Placement(transformation(extent={
            {-110,60},{-10,160}}, rotation=0)));
public
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true) annotation (
      Placement(transformation(extent={{180,-30},{160,-10}}, rotation=0)));
public
  ThermoPower3.PowerPlants.HRSG.Control.levelsControl levelsControl(
    CSmin_levelHP=30,
    CSmax_levelHP=96,
    CSmin_levelIP=5,
    CSmax_levelIP=25,
    Level_HP(steadyStateInit=true),
    Level_IP(steadyStateInit=true),
    Level_LP(steadyStateInit=true),
    CSmax_levelLP=2400) annotation (Placement(transformation(extent={{60,120},{
            120,180}}, rotation=0)));
  ThermoPower3.Gas.SinkP sinkGas(redeclare package Medium = FlueGasMedium, T=
        362.309) annotation (Placement(transformation(extent={{30,90},{50,110}},
          rotation=0)));
public
  Modelica.Blocks.Sources.Ramp valveHP_com(
    height=0,
    offset=1,
    duration=2) annotation (Placement(transformation(extent={{180,90},{160,110}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp valveIP_com(
    height=0,
    offset=1,
    duration=2) annotation (Placement(transformation(extent={{180,50},{160,70}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp valveLP_com(
    height=0,
    offset=1,
    duration=2) annotation (Placement(transformation(extent={{180,10},{160,30}},
          rotation=0)));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.GeneratorGroup
    singleShaft(
    eta=0.9,
    J_shaft=15000,
    d_shaft=25,
    Pmax=150e6,
    SSInit=true,
    delta_start=0.7) annotation (Placement(transformation(extent={{60,-160},{
            160,-60}}, rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators1 annotation (Placement(
        transformation(extent={{150,-30},{130,-10}}, rotation=0)));
public
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.STG_3LRh_valve_cc
    sTG_3LRh(
    SSInit=true,
    steamTurbines(
      steamHPNomFlowRate=62.8,
      steamIPNomFlowRate=14.5,
      steamLPNomFlowRate=10.9,
      ST_HP(pnom=120e5),
      ST_IP(pnom=28e5),
      ST_LP(pnom=6.5e5),
      steamHPNomPressure=12202000,
      steamIPNomPressure=2636810,
      steamLPNomPressure=604700),
    totalFeedPump(nominalOutletPressure=604700)) annotation (Placement(
        transformation(extent={{-110,-160},{-10,-60}}, rotation=0)));
equation
  connect(ramp.y, sourceGas.in_w0) annotation (Line(points={{-169,130},{-160.8,
          130},{-160.8,105}}, color={0,0,127}));
  connect(sourceGas.flange, hRSG.GasIn) annotation (Line(
      points={{-132,100},{-110,100}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  connect(valveHP_com.y, actuators1.Opening_valveHP)
    annotation (Line(points={{159,100},{140,100},{140,-20}}, color={0,0,127}));
  connect(valveIP_com.y, actuators1.Opening_valveIP)
    annotation (Line(points={{159,60},{140,60},{140,-20}}, color={0,0,127}));
  connect(valveLP_com.y, actuators1.Opening_valveLP)
    annotation (Line(points={{159,20},{140,20},{140,-20}}, color={0,0,127}));
  connect(levelsControl.SensorsBus, hRSG.SensorsBus) annotation (Line(
      points={{60,150},{60,150},{-10,150}},
      color={255,170,213},
      thickness=0.5));
  connect(hRSG.SensorsBus, sTG_3LRh.SensorsBus) annotation (Line(
      points={{-10,150},{20,150},{20,-130},{-10,-130}},
      color={255,170,213},
      thickness=0.5));
  connect(sTG_3LRh.ActuatorsBus, hRSG.ActuatorsBus) annotation (Line(
      points={{-10,-145},{10,-145},{10,135},{-10,135}},
      color={213,255,170},
      thickness=0.5));
  connect(actuators1, hRSG.ActuatorsBus) annotation (Line(
      points={{140,-20},{10,-20},{10,135},{-10,135}},
      color={213,255,170},
      thickness=0.5));
  connect(levelsControl.ActuatorsBus, hRSG.ActuatorsBus) annotation (Line(
      points={{120,150},{140,150},{140,135},{-10,135}},
      color={213,255,170},
      thickness=0.5));
  connect(sinkGas.flange, hRSG.GasOut) annotation (Line(
      points={{30,100},{30,100},{-10,100}},
      color={159,159,223},
      thickness=1));
  connect(booleanConstant.y, actuators1.ConnectedGenerator) annotation (Line(
      points={{159,-20},{140,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(singleShaft.shaft, sTG_3LRh.Shaft_b) annotation (Line(
      points={{60,-110},{-10,-110}},
      color={0,0,0},
      thickness=1));
  connect(sTG_3LRh.SensorsBus, singleShaft.SensorsBus) annotation (Line(
      points={{-10,-130},{20,-130},{20,-170},{190,-170},{190,-130},{160,-130}},

      color={255,170,213},
      thickness=0.5));

  connect(singleShaft.ActuatorsBus, sTG_3LRh.ActuatorsBus) annotation (Line(
      points={{160,-145},{180,-145},{180,-180},{10,-180},{10,-145},{-10,-145}},

      color={213,255,170},
      thickness=0.5));

  connect(sTG_3LRh.WaterOut, hRSG.WaterIn) annotation (Line(
      points={{-20,-60},{-20,-60},{-20,60}},
      thickness=1,
      color={0,0,255}));
  connect(sTG_3LRh.From_SH_LP, hRSG.Sh_LP_Out) annotation (Line(
      points={{-40,-60},{-40,-60},{-40,60}},
      thickness=1,
      color={0,0,255}));
  connect(sTG_3LRh.From_RH_IP, hRSG.Rh_IP_Out) annotation (Line(
      points={{-70,-60},{-70,-60},{-70,60}},
      thickness=1,
      color={0,0,255}));
  connect(sTG_3LRh.From_SH_HP, hRSG.Sh_HP_Out) annotation (Line(
      points={{-100,-60},{-100,-60},{-100,60}},
      thickness=1,
      color={0,0,255}));
  connect(sTG_3LRh.To_RH_IP, hRSG.Rh_IP_In) annotation (Line(
      points={{-85,-60},{-85,-60},{-85,60}},
      thickness=1,
      color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1,
        grid={1,1}), graphics),
    experiment(
      StopTime=6000,
      __Dymola_NumberOfIntervals=3000,
      Tolerance=1e-006),
    Documentation(info="<html>
<p>Characteristic simulations: variation of the gas flow rate.
</html>", revisions="<html>
<ul>
<li><i>15 Apr 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>"),
    experimentSetupOutput(equdistant=false));
end SteamPlant_Sim1_dp;
