within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model balanceOfPlantSystemThree "Test of STG with condenser control"
  import aSMR = ORNL_AdvSMR;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  ThermoPower3.Water.SourceP sourceLPT(
    h=3.109e6,
    redeclare package Medium = FluidMedium,
    p0=600000) annotation (Placement(transformation(
        origin={-30,70},
        extent={{-5,-5},{5,5}},
        rotation=270)));
  PowerConversionSystem.SteamTurbineGroup.STG_3LRh_valve_cc sTG_3LRh(
      redeclare package FluidMedium = FluidMedium, steamTurbines(SSInit=
          false)) annotation (Placement(transformation(extent={{-100,-50},
            {0,50}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveHP(k=1) annotation (Placement(
        transformation(extent={{45,-55},{35,-45}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveIP(k=1) annotation (Placement(
        transformation(extent={{45,-70},{35,-60}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveLP(k=1) annotation (Placement(
        transformation(extent={{45,-85},{35,-75}}, rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators annotation (
      Placement(transformation(
        origin={30,-95},
        extent={{-15,-5},{15,5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant n_pump(k=1425) annotation (Placement(
        transformation(extent={{15,-55},{25,-45}}, rotation=0)));
  PowerConversionSystem.ElectricGeneratorGroup.Examples.GeneratorGroup_noBreaker
    singleShaft(
    eta=0.9,
    J_shaft=15000,
    d_shaft=25,
    Pmax=150e6,
    SSInit=true,
    delta_start=0.7) annotation (Placement(transformation(extent={{30,-30},
            {90,30}},rotation=0)));

  inner ORNL_AdvSMR.System system(Dynamics=ORNL_AdvSMR.Choices.System.Dynamics.SteadyStateInitial,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
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
        origin={-37,85},
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant pumpSpeed(k=1500) annotation (
      Placement(transformation(extent={{0,89},{-10,99}}, rotation=0)));
equation
  connect(com_valveHP.y, actuators.Opening_valveHP) annotation (Line(
        points={{34.5,-50},{30,-50},{30,-95}}, color={0,0,127}));
  connect(com_valveIP.y, actuators.Opening_valveIP) annotation (Line(
        points={{34.5,-65},{30,-65},{30,-95}}, color={0,0,127}));
  connect(com_valveLP.y, actuators.Opening_valveLP) annotation (Line(
        points={{34.5,-80},{30,-80},{30,-95}}, color={0,0,127}));
  connect(actuators, sTG_3LRh.ActuatorsBus) annotation (Line(
      points={{30,-95},{10,-95},{10,-35},{0,-35}},
      color={213,255,170},
      thickness=0.5));
  connect(n_pump.y, actuators.nPump_feedLP) annotation (Line(points={{
          25.5,-50},{30,-50},{30,-95}}, color={0,0,127}));
  connect(singleShaft.shaft, sTG_3LRh.Shaft_b) annotation (Line(
      points={{30,0},{0,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(pumpSpeed.y, totalFeedPump.pumpSpeed_rpm) annotation (Line(
      points={{-10.5,94},{-21,94},{-21,89.5},{-31.6,89.5}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.From_SH_LP, sourceLPT.flange) annotation (Line(
      points={{-30,50},{-30,65}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.To_RH_IP, sTG_3LRh.From_RH_IP) annotation (Line(
      points={{-75,50},{-75,65},{-60,65},{-60,50}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.From_SH_HP, totalFeedPump.outlet) annotation (Line(
      points={{-90,50},{-90,85},{-44.5,85}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.WaterOut, totalFeedPump.inlet) annotation (Line(
      points={{-10,50},{-10,85},{-29.5,85}},
      color={0,127,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(StopTime=20000, NumberOfIntervals=10000),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end balanceOfPlantSystemThree;
