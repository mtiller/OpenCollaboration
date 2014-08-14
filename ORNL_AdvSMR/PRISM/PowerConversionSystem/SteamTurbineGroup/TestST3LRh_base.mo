within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup;
model TestST3LRh_base
  import aSMR = ORNL_AdvSMR;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.ST3L_base
    steamTurbines(
    redeclare package FluidMedium = FluidMedium,
    steamHPNomFlowRate=67.6,
    steamIPNomFlowRate=81.10 - 67.5,
    steamLPNomFlowRate=89.82 - 81.10,
    HPT_eta_iso_nom=0.833,
    IPT_eta_iso_nom=0.903,
    LPT_eta_iso_nom=0.876,
    HPT_Kt=0.0032078,
    IPT_Kt=0.018883,
    LPT_Kt=0.078004,
    mixLP_V=10,
    steamHPNomPressure=12800000,
    steamIPNomPressure=2680000,
    steamLPNomPressure=600000,
    pcond=5398.2) annotation (Placement(transformation(extent={{-80,-40},{0,40}},
          rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkLPT(
    redeclare package Medium = FluidMedium,
    p0=5.3982e3,
    h=2.3854e6) annotation (Placement(transformation(extent={{4,-66},{16,-54}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        314.16/2, useSupport=false) annotation (Placement(transformation(extent
          ={{66,-10},{46,10}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceP sourceHPT(h=3.47e6, p0=1.28e7) annotation (
      Placement(transformation(
        origin={-72,66},
        extent={{-6,-6},{6,6}},
        rotation=270)));
  ORNL_AdvSMR.Components.SourceP sourceLPT(h=3.109e6, p0=6e5) annotation (
      Placement(transformation(
        origin={-24,60},
        extent={{-6,-6},{6,6}},
        rotation=270)));
  inner ORNL_AdvSMR.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ORNL_AdvSMR.Components.SinkP sinkP(h=3.1076e6, p0=2980000) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-60,84})));
  ORNL_AdvSMR.Components.SourceP sourceP(h=3.554e6, p0=2680000) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-48,66})));
equation
  connect(constantSpeed.flange, steamTurbines.Shaft_b) annotation (Line(
      points={{46,0},{0,0}},
      color={0,0,0},
      thickness=0.5));
  connect(sinkLPT.flange, steamTurbines.LPT_Out) annotation (Line(
      points={{4,-60},{-12,-60},{-12,-40}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.LPT_In, sourceLPT.flange) annotation (Line(
      points={{-24,40},{-24,54}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_In, sourceHPT.flange) annotation (Line(
      points={{-72,40},{-72,54},{-72,60}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_Out, sinkP.flange) annotation (Line(
      points={{-60,40},{-60,78}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(steamTurbines.IPT_In, sourceP.flange) annotation (Line(
      points={{-48,40},{-48,60}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=1000),
    experimentSetupOutput(equdistant=false));
end TestST3LRh_base;
