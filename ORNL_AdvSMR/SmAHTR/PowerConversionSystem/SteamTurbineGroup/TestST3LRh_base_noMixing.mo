within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup;
model TestST3LRh_base_noMixing
  import aSMR = ORNL_AdvSMR;
  package FluidMedium = ThermoPower3.Water.StandardWater;

  SmAHTR.PowerConversionSystem.SteamTurbineGroup.ST3L_base_noMixing
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
    pcond=5398.2) annotation (Placement(transformation(extent={{-75,-50},
            {25,50}}, rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkLPT(
    redeclare package Medium = FluidMedium,
    p0=5.3982e3,
    h=2.3854e6) annotation (Placement(transformation(
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=0,
        origin={37.5,-67.5})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      w_fixed=314.16/2, useSupport=false) annotation (Placement(
        transformation(extent={{90,-10},{70,10}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceP sourceHPT(h=3.47e6, p0=12800000)
    annotation (Placement(transformation(
        origin={-77.5,75},
        extent={{-7.5,-7.5},{7.5,7.5}},
        rotation=0)));
  inner ORNL_AdvSMR.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=100,
    startTime=100,
    height=-8e5,
    offset=128e5) annotation (Placement(transformation(extent={{-100,85},
            {-85,100}})));
equation
  connect(constantSpeed.flange, steamTurbines.Shaft_b) annotation (Line(
      points={{70,0},{70,0},{25,0}},
      color={0,0,0},
      thickness=0.5));
  connect(sinkLPT.flange, steamTurbines.LPT_Out) annotation (Line(
      points={{30,-67.5},{15,-67.5},{15,-50}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.HPT_In, sourceHPT.flange) annotation (Line(
      points={{-65,50},{-65,66.5},{-65,75},{-70,75}},
      thickness=0.5,
      color={0,0,255}));
  connect(steamTurbines.IPT_Out, steamTurbines.LPT_In) annotation (Line(
      points={{-15,50},{-15,85},{5,85},{5,50}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(steamTurbines.HPT_Out, steamTurbines.IPT_In) annotation (Line(
      points={{-50,50},{-50,85},{-30,85},{-30,50}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ramp.y, sourceHPT.in_p0) annotation (Line(
      points={{-84.25,92.5},{-80.5,92.5},{-80.5,81.9}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(StopTime=1000),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end TestST3LRh_base_noMixing;
