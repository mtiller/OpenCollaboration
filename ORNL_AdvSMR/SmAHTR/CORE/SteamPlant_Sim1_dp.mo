within ORNL_AdvSMR.SmAHTR.CORE;
model SteamPlant_Sim1_dp
  "Test total plant with levels control and ratio control on the condenser, inlet valves"
  package FlueGasMedium = ThermoPower3.Media.FlueGas;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  parameter Boolean SSInit=true "Steady-state initialization";

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
      fluidLPNomPressure=604700)) annotation (Placement(transformation(
          extent={{-100,20},{0,120}}, rotation=0)));
public
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{180,-60},{160,-40}},
          rotation=0)));
public
  ThermoPower3.PowerPlants.HRSG.Control.levelsControl levelsControl(
    CSmin_levelHP=30,
    CSmax_levelHP=96,
    CSmin_levelIP=5,
    CSmax_levelIP=25,
    Level_HP(steadyStateInit=true),
    Level_IP(steadyStateInit=true),
    Level_LP(steadyStateInit=true),
    CSmax_levelLP=2400) annotation (Placement(transformation(extent={{60,
            100},{120,160}}, rotation=0)));
public
  Modelica.Blocks.Sources.Ramp valveHP_com(
    height=0,
    offset=1,
    duration=2) annotation (Placement(transformation(extent={{180,60},{
            160,80}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp valveIP_com(
    height=0,
    offset=1,
    duration=2) annotation (Placement(transformation(extent={{180,20},{
            160,40}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp valveLP_com(
    height=0,
    offset=1,
    duration=2) annotation (Placement(transformation(extent={{180,-20},{
            160,0}}, rotation=0)));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.GeneratorGroup
    singleShaft(
    eta=0.9,
    J_shaft=15000,
    d_shaft=25,
    Pmax=150e6,
    SSInit=true,
    delta_start=0.7) annotation (Placement(transformation(extent={{60,-180},
            {160,-80}},rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators1 annotation (
      Placement(transformation(extent={{120,-60},{100,-40}}, rotation=0)));
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
        transformation(extent={{-100,-180},{0,-80}}, rotation=0)));
  ThermoPower3.Gas.FlangeA flangeA(redeclare package Medium =
        FlueGasMedium) annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  ThermoPower3.Gas.FlangeB flangeB(redeclare package Medium =
        FlueGasMedium) annotation (Placement(transformation(extent={{90,-10},
            {110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
equation
  connect(valveHP_com.y, actuators1.Opening_valveHP) annotation (Line(
        points={{159,70},{110,70},{110,-50}}, color={0,0,127}));
  connect(valveIP_com.y, actuators1.Opening_valveIP) annotation (Line(
        points={{159,30},{110,30},{110,-50}}, color={0,0,127}));
  connect(valveLP_com.y, actuators1.Opening_valveLP) annotation (Line(
        points={{159,-10},{110,-10},{110,-50}}, color={0,0,127}));
  connect(levelsControl.SensorsBus, hRSG.SensorsBus) annotation (Line(
        points={{60,130},{20,130},{20,110},{0,110}}, color={255,170,213}));
  connect(hRSG.SensorsBus, sTG_3LRh.SensorsBus) annotation (Line(points={
          {0,110},{20,110},{20,-150},{0,-150}}, color={255,170,213}));
  connect(sTG_3LRh.ActuatorsBus, hRSG.ActuatorsBus) annotation (Line(
        points={{0,-165},{14,-165},{14,95},{0,95}}, color={213,255,170}));
  connect(actuators1, hRSG.ActuatorsBus) annotation (Line(points={{110,-50},
          {14,-50},{14,95},{0,95}}, color={213,255,170}));
  connect(levelsControl.ActuatorsBus, hRSG.ActuatorsBus) annotation (Line(
        points={{120,130},{140,130},{140,95},{0,95}}, color={213,255,170}));
  connect(booleanConstant.y, actuators1.ConnectedGenerator) annotation (
      Line(
      points={{159,-50},{110,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(singleShaft.shaft, sTG_3LRh.Shaft_b) annotation (Line(
      points={{60,-130},{0,-130}},
      color={0,0,0},
      thickness=0.5));
  connect(sTG_3LRh.SensorsBus, singleShaft.SensorsBus) annotation (Line(
        points={{0,-150},{40,-150},{40,-190},{180,-190},{180,-150},{160,-150}},
        color={255,170,213}));
  connect(singleShaft.ActuatorsBus, sTG_3LRh.ActuatorsBus) annotation (
      Line(points={{160,-165},{172,-165},{172,-184},{34,-184},{34,-165},{
          0,-165}}, color={213,255,170}));
  connect(sTG_3LRh.WaterOut, hRSG.WaterIn) annotation (Line(
      points={{-10,-80},{-10,-36},{-10,20}},
      thickness=0.5,
      color={0,0,255}));
  connect(sTG_3LRh.From_SH_LP, hRSG.Sh_LP_Out) annotation (Line(
      points={{-30,-80},{-30,-36},{-30,20}},
      thickness=0.5,
      color={0,0,255}));
  connect(sTG_3LRh.From_RH_IP, hRSG.Rh_IP_Out) annotation (Line(
      points={{-60,-80},{-60,-36},{-60,20}},
      thickness=0.5,
      color={0,0,255}));
  connect(sTG_3LRh.From_SH_HP, hRSG.Sh_HP_Out) annotation (Line(
      points={{-90,-80},{-90,-36},{-90,20}},
      thickness=0.5,
      color={0,0,255}));
  connect(sTG_3LRh.To_RH_IP, hRSG.Rh_IP_In) annotation (Line(
      points={{-75,-80},{-75,20}},
      thickness=0.5,
      color={0,0,255}));
  connect(flangeA, hRSG.GasIn) annotation (Line(
      points={{-100,0},{-99.75,0},{-99.75,60},{-100,60}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  connect(hRSG.GasOut, flangeB) annotation (Line(
      points={{0,60},{50,60},{50,0},{100,0}},
      color={159,159,223},
      thickness=1,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics),
    experiment(
      StopTime=6000,
      NumberOfIntervals=3000,
      Tolerance=1e-006),
    Documentation(info="<html>
<p>Characteristic simulations: variation of the gas flow rate.
</html>",
    revisions="<html>
<ul>
<li><i>15 Apr 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>"),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={95,95,95},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={215,215,215}),Text(
                extent={{-80,10},{80,-10}},
                lineColor={0,127,255},
                lineThickness=1,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={215,215,215},
                textString="Heat Recovery Steam Generator")}));
end SteamPlant_Sim1_dp;
