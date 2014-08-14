within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model TestST3LRh_bypass
  package FluidMedium = ThermoPower3.Water.StandardWater;

  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.ST3L_bypass
    steamTurbines(
    redeclare package FluidMedium = FluidMedium,
    steamHPNomFlowRate=67.6,
    steamHPNomPressure=1.28e7,
    steamIPNomFlowRate=81.10 - 67.5,
    steamIPNomPressure=2.68e6,
    steamLPNomPressure=6e5,
    pcond=5.3982e3,
    mixLP_V=50,
    steamLPNomFlowRate=89.82 - 81.10,
    valveHP_dpnom=1.6e5,
    valveIP_dpnom=5e4,
    valveLP_dpnom=2.64e4,
    HPT_eta_iso_nom=0.833,
    IPT_eta_iso_nom=0.903,
    LPT_eta_iso_nom=0.876,
    valveHP_Cv=1165,
    valveIP_Cv=5625,
    valveLP_Cv=14733,
    bypassHP_Cv=272,
    bypassIP_Cv=1595,
    bypassLP_Cv=7540,
    HPT_Kt=0.0032078,
    IPT_Kt=0.018883,
    LPT_Kt=0.078004,
    valveDrumIP_Cv=810,
    valveDrumLP_Cv=1670) annotation (Placement(transformation(extent={{-94,
            -40},{-14,40}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      w_fixed=314.16/2, useSupport=false) annotation (Placement(
        transformation(extent={{20,-10},{0,10}}, rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators annotation (
      Placement(transformation(
        origin={66,-74},
        extent={{-20,-6},{20,6}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant com_valveHP(k=1) annotation (Placement(
        transformation(extent={{96,30},{76,50}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveIP(k=1) annotation (Placement(
        transformation(extent={{96,-10},{76,10}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveLP(k=1) annotation (Placement(
        transformation(extent={{96,-50},{76,-30}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_bypassHP(k=0) annotation (
      Placement(transformation(extent={{36,30},{56,50}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_bypassIP(k=0) annotation (
      Placement(transformation(extent={{36,-10},{56,10}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_bypassLP(k=0) annotation (
      Placement(transformation(extent={{36,-50},{56,-30}}, rotation=0)));
  ThermoPower3.Water.SinkP sinkLPT_p(
    redeclare package Medium = FluidMedium,
    p0=5.3982e3,
    h=2.3854e6) annotation (Placement(transformation(extent={{-34,-66},{-46,
            -54}}, rotation=0)));
  ThermoPower3.Water.SourceP sourceHPT_p(h=3.47e6, p0=1.296e7)
    annotation (Placement(transformation(
        origin={-86,64},
        extent={{-6,-6},{6,6}},
        rotation=270)));
  ThermoPower3.Water.SourceP sourceLPT(h=3.109e6, p0=6.296e5) annotation (
     Placement(transformation(
        origin={-38,64},
        extent={{-6,-6},{6,6}},
        rotation=270)));
  inner ThermoPower3.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SinkP sinkP(p0=29.8e5, h=3.1076e6) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-74,80})));
  ThermoPower3.Water.SourceP sourceP(h=3.554e6, p0=2730000) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-62,64})));
equation
  connect(com_valveHP.y, actuators.Opening_valveHP) annotation (Line(
        points={{75,40},{66,40},{66,-74}}, color={0,0,127}));
  connect(com_valveIP.y, actuators.Opening_valveIP)
    annotation (Line(points={{75,0},{66,0},{66,-74}}, color={0,0,127}));
  connect(com_valveLP.y, actuators.Opening_valveLP) annotation (Line(
        points={{75,-40},{66,-40},{66,-74}}, color={0,0,127}));
  connect(actuators, steamTurbines.ActuatorsBus) annotation (Line(points=
          {{66,-74},{18,-74},{18,-28},{-14,-28}}, color={213,255,170}));
  connect(steamTurbines.Shaft_b, constantSpeed.flange) annotation (Line(
      points={{-14,0},{0,0}},
      color={0,0,0},
      thickness=0.5));
  connect(com_bypassHP.y, actuators.Opening_byPassHP) annotation (Line(
        points={{57,40},{66,40},{66,-74}}, color={0,0,127}));
  connect(com_bypassIP.y, actuators.Opening_byPassIP)
    annotation (Line(points={{57,0},{66,0},{66,-74}}, color={0,0,127}));
  connect(com_bypassLP.y, actuators.Opening_byPassLP) annotation (Line(
        points={{57,-40},{66,-40},{66,-74}}, color={0,0,127}));
  connect(sinkLPT_p.flange, steamTurbines.LPT_Out) annotation (Line(
      points={{-34,-60},{-26,-60},{-26,-40}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.LPT_In, sourceLPT.flange) annotation (Line(
      points={{-38,40},{-38,58}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_In, sourceHPT_p.flange) annotation (Line(
      points={{-86,40},{-86,50},{-86,58}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_Out, sinkP.flange) annotation (Line(
      points={{-74,40},{-74,74}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(steamTurbines.IPT_In, sourceP.flange) annotation (Line(
      points={{-62,40},{-62,58}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    experiment(StopTime=1000),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})));
end TestST3LRh_bypass;
