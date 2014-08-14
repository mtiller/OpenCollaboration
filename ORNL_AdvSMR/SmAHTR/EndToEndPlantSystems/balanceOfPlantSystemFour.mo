within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model balanceOfPlantSystemFour "Test of STG with condenser control"
  import aSMR = ORNL_AdvSMR;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  PowerConversionSystem.SteamTurbineGroup.ST3L_base_noMixing sTG_3LRh(
      redeclare package FluidMedium = FluidMedium) annotation (Placement(
        transformation(extent={{-85,-50},{15,50}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveHP(k=1) annotation (Placement(
        transformation(extent={{100,-50},{90,-40}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveIP(k=1) annotation (Placement(
        transformation(extent={{100,-65},{90,-55}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveLP(k=1) annotation (Placement(
        transformation(extent={{100,-80},{90,-70}}, rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators annotation (
      Placement(transformation(
        origin={85,-90},
        extent={{-15,-5},{15,5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant n_pump(k=1425) annotation (Placement(
        transformation(extent={{70,-50},{80,-40}}, rotation=0)));
  PowerConversionSystem.ElectricGeneratorGroup.Examples.GeneratorGroup_noBreaker
    singleShaft(
    eta=0.9,
    J_shaft=15000,
    d_shaft=25,
    Pmax=150e6,
    SSInit=true,
    delta_start=0.7) annotation (Placement(transformation(extent={{25,-30},
            {85,30}},rotation=0)));

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
        origin={-37.5,80},
        extent={{-7.5,7.5},{7.5,-7.5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant com_valveHP1(k=1500) annotation (
      Placement(transformation(extent={{-10,85},{-20,95}}, rotation=0)));
equation
  connect(com_valveHP.y, actuators.Opening_valveHP) annotation (Line(
        points={{89.5,-45},{85,-45},{85,-90}}, color={0,0,127}));
  connect(com_valveIP.y, actuators.Opening_valveIP) annotation (Line(
        points={{89.5,-60},{85,-60},{85,-90}}, color={0,0,127}));
  connect(com_valveLP.y, actuators.Opening_valveLP) annotation (Line(
        points={{89.5,-75},{85,-75},{85,-90}}, color={0,0,127}));
  connect(actuators, sTG_3LRh.ActuatorsBus) annotation (Line(points={{85,
          -90},{35,-90},{35,-35},{20,-35}}, color={213,255,170}));
  connect(n_pump.y, actuators.nPump_feedLP) annotation (Line(points={{
          80.5,-45},{85,-45},{85,-90}}, color={0,0,127}));
  connect(com_valveHP1.y, totalFeedPump.pumpSpeed_rpm) annotation (Line(
      points={{-20.5,90},{-25,90},{-25,84.5},{-32.1,84.5}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.HPT_Out, sTG_3LRh.IPT_In) annotation (Line(
      points={{-60,50},{-60,65},{-40,65},{-40,50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sTG_3LRh.LPT_Out, totalFeedPump.inlet) annotation (Line(
      points={{5,-50},{5,-84.5},{20,-84.5},{20,80},{-30,80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sTG_3LRh.HPT_In, totalFeedPump.outlet) annotation (Line(
      points={{-75,50},{-75,80},{-45,80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sTG_3LRh.Shaft_b, singleShaft.shaft) annotation (Line(
      points={{15,0},{25,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(sTG_3LRh.IPT_Out, sTG_3LRh.LPT_In) annotation (Line(
      points={{-25,50},{-25,65},{-5,65},{-5,50}},
      color={0,127,255},
      thickness=1,
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
end balanceOfPlantSystemFour;
