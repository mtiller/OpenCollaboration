within ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup;
model CondPlant "Condensation Plant"
  extends Interfaces.CondPlant;
  replaceable Condensers.Condenser condenser(
    redeclare package FluidMedium = FluidMedium,
    N_cool=N_cool,
    condNomFlowRate=condNomFlowRate,
    coolNomFlowRate=coolNomFlowRate,
    condNomPressure=condNomPressure,
    coolNomPressure=coolNomPressure,
    condExchSurface=condExchSurface,
    coolExchSurface=coolExchSurface,
    condVol=condVol,
    coolVol=coolVol,
    metalVol=metalVol,
    cm=cm,
    rhoMetal=rhoMetal,
    SSInit=SSInit,
    pstart_cond=pstart_cond) constrainedby Interfaces.Condenser(
    redeclare package FluidMedium = FluidMedium,
    N_cool=N_cool,
    condNomFlowRate=condNomFlowRate,
    coolNomFlowRate=coolNomFlowRate,
    condNomPressure=condNomPressure,
    coolNomPressure=coolNomPressure,
    condExchSurface=condExchSurface,
    coolExchSurface=coolExchSurface,
    condVol=condVol,
    coolVol=coolVol,
    metalVol=metalVol,
    cm=cm,
    rhoMetal=rhoMetal,
    SSInit=SSInit,
    pstart_cond=pstart_cond) annotation (Placement(transformation(extent={{-18,
            -22},{22,18}}, rotation=0)));
  ThermoPower3.Water.SourceW coolingIn(
    redeclare package Medium = FluidMedium,
    p0=coolNomPressure,
    w0=coolNomFlowRate,
    h=h_cool_in) annotation (Placement(transformation(extent={{90,-20},{70,0}},
          rotation=0)));
  ThermoPower3.Water.SinkP coolingOut(redeclare package Medium = FluidMedium,
      p0=coolNomPressure)
    annotation (Placement(transformation(extent={{70,0},{90,20}}, rotation=0)));
  replaceable
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water
    stateCoolingOut(redeclare package Medium = FluidMedium) constrainedby
    ThermoPower3.PowerPlants.SteamTurbineGroup.Components.BaseReader_water(
      redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{36,0},{56,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ratio_VvonVtot annotation (Placement(
        transformation(
        origin={-106,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  parameter Modelica.SIunits.SpecificEnthalpy h_cool_in=1e5
    "Nominal specific enthalpy";
equation
  connect(condenser.steamIn, SteamIn) annotation (Line(
      points={{0,18},{0,100}},
      thickness=0.5,
      color={0,0,255}));
  connect(condenser.waterOut, WaterOut) annotation (Line(
      points={{0,-22},{0,-100}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateCoolingOut.outlet, coolingOut.flange) annotation (Line(
      points={{52,10},{64,10},{70,10}},
      thickness=0.5,
      color={0,0,255}));
  connect(stateCoolingOut.inlet, condenser.coolingOut) annotation (Line(
      points={{40,10},{34,10},{22,10}},
      thickness=0.5,
      color={0,0,255}));
  connect(condenser.ratio_VvonVtot, ratio_VvonVtot)
    annotation (Line(points={{-18,0},{-106,0}}, color={0,0,127}));
  connect(coolingIn.flange, condenser.coolingIn) annotation (Line(
      points={{70,-10},{22,-10}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end CondPlant;
