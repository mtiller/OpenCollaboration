within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model endToEndPlant

  DRACS.dRACS_AirTowers dRACS_AirTowers
    annotation (Placement(transformation(extent={{-100,25},{-60,65}})));
  DRACS.dRACS_SaltLoop dRACS_SaltLoop
    annotation (Placement(transformation(extent={{-55,5},{-15,45}})));
  PrimaryHeatTransportSystem.Tests.smAHTR smAHTR
    annotation (Placement(transformation(extent={{-10,-15},{30,25}})));
  Modelica.Fluid.Sources.Boundary_pT airIn(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = Media.Fluids.Air,
    p=100000,
    T=673.15) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-105,75})));
  Modelica.Fluid.Sources.Boundary_pT airOut(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = Media.Fluids.Air,
    p=100000,
    T=673.15) annotation (Placement(transformation(
        extent={{-5,5},{5,-5}},
        rotation=270,
        origin={-120,75})));
  CORE.ReactorKinetics reactorKinetics
    annotation (Placement(transformation(extent={{-50,-65},{-10,-25}})));
  IntermediateHeatTransportSystem.secondaryHeatTrLoop secondaryHeatTrLoop
    annotation (Placement(transformation(extent={{35,-35},{75,5}})));
  PowerConversionSystem.RankineCycle.superCriticalWaterTurbineGenerator
    superCriticalWaterTurbineGenerator
    annotation (Placement(transformation(extent={{80,-90},{120,-50}})));
equation
  connect(dRACS_AirTowers.airToSaltInterface, dRACS_SaltLoop.heatPorts_a)
    annotation (Line(
      points={{-60,45},{-57.5,45},{-57.5,25},{-55,25}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(airIn.ports[1], dRACS_AirTowers.airIn) annotation (Line(
      points={{-105,70},{-105,61},{-100,61}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(airOut.ports[1], dRACS_AirTowers.airOut) annotation (Line(
      points={{-120,70},{-120,56},{-100,56}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(dRACS_SaltLoop.heatPorts_b, smAHTR.heatPorts_a) annotation (
      Line(
      points={{-15,25},{-12.5,25},{-12.5,5},{-10,5}},
      color={127,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(smAHTR.heatPorts_b, secondaryHeatTrLoop.heatPorts_a)
    annotation (Line(
      points={{30,5},{32.5,5},{32.5,-15},{35,-15}},
      color={127,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(reactorKinetics.Q_Z1, smAHTR.u) annotation (Line(
      points={{-10.5,-33},{-7,-33},{-7,-14}},
      color={0,0,127},
      smooth=Smooth.None,
      thickness=1));
  connect(secondaryHeatTrLoop.flangeB, superCriticalWaterTurbineGenerator.flangeA)
    annotation (Line(
      points={{65,-35},{65,-45},{84,-45},{84,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(reactorKinetics.Q_Z2, smAHTR.u1) annotation (Line(
      points={{-10.5,-45},{-2,-45},{-2,-14}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(reactorKinetics.Q_Z3, smAHTR.u2) annotation (Line(
      points={{-10.5,-57},{4,-57},{4,-14}},
      color={0,0,127},
      thickness=1,
      smooth=Smooth.None));
  connect(superCriticalWaterTurbineGenerator.flangeB, secondaryHeatTrLoop.flangeA)
    annotation (Line(
      points={{90,-50},{90,-40},{71,-40},{71,-35}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-130,-100},{130,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-130,-100},{130,100}},
        grid={0.5,0.5})));
end endToEndPlant;
