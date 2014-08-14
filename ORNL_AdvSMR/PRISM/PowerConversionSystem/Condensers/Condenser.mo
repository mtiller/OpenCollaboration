within ORNL_AdvSMR.PRISM.PowerConversionSystem.Condensers;
model Condenser "Condenser"
  extends
    ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup.Interfaces.Condenser;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_cond
    "Coefficient of heat transfer on condensation surfaces";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_cool
    "Coefficient of heat transfer of cooling fluid side";
  parameter ThermoPower3.Choices.Flow1D.FFtypes FFtype_cool=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction
    "Friction Factor Type";
  parameter ThermoPower3.Choices.Flow1D.HCtypes HCtype_cool=ThermoPower3.Choices.Flow1D.HCtypes.Downstream
    "Location of the hydraulic capacitance";
  parameter Modelica.SIunits.Pressure dpnom_cool=0
    "Nominal pressure drop (friction term only!)";
  parameter ThermoPower3.Density rhonom_cool=0 "Nominal inlet density";

  //other data
  constant Real pi=Modelica.Constants.pi;

  ORNL_AdvSMR.Components.Flow1D flowCooling(
    Nt=1,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    redeclare package Medium = FluidMedium,
    L=coolExchSurface^2/(coolVol*pi*4),
    A=(coolVol*4/coolExchSurface)^2/4*pi,
    omega=coolVol*4/coolExchSurface*pi,
    Dhyd=coolVol*4/coolExchSurface,
    wnom=coolNomFlowRate,
    N=N_cool,
    FFtype=FFtype_cool,
    dpnom=dpnom_cool,
    rhonom=rhonom_cool,
    HydraulicCapacitance=HCtype_cool) annotation (Placement(transformation(
        origin={20,10},
        extent={{-12,-10},{12,10}},
        rotation=90)));
  ThermoPower3.Thermal.ConvHT convHT(gamma=gamma_cool, N=N_cool) annotation (
      Placement(transformation(
        origin={-22,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Components.CondenserShell
    condenserShell(
    redeclare package Medium = FluidMedium,
    V=condVol,
    Mm=metalVol*rhoMetal,
    Ac=condExchSurface,
    Af=coolExchSurface,
    cm=cm,
    hc=gamma_cond,
    Nc=N_cool,
    pstart=pstart_cond,
    Vlstart=Vlstart_cond,
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit) annotation (Placement(
        transformation(extent={{-66,-6},{-34,26}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ratio_VvonVtot annotation (Placement(
        transformation(
        origin={-100,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(flowCooling.infl, coolingIn) annotation (Line(
      points={{20,-2},{20,-40},{100,-40}},
      thickness=0.5,
      color={0,0,255}));
  connect(flowCooling.outfl, coolingOut) annotation (Line(
      points={{20,22},{20,60},{100,60}},
      thickness=0.5,
      color={0,0,255}));
  connect(convHT.side2, flowCooling.wall)
    annotation (Line(points={{-18.9,10},{15,10}}, color={255,127,0}));
  connect(condenserShell.steam, steamIn) annotation (Line(
      points={{-50,26},{-50,100},{-10,100}},
      thickness=0.5,
      color={0,0,255}));
  connect(condenserShell.condensate, waterOut) annotation (Line(
      points={{-50,-6},{-50,-100},{-10,-100}},
      thickness=0.5,
      color={0,0,255}));
  connect(condenserShell.coolingFluid, convHT.side1) annotation (Line(points={{
          -50,10},{-46,10},{-40,10},{-25,10}}, color={255,127,0}));
  connect(condenserShell.ratio_VvVtot, ratio_VvonVtot)
    annotation (Line(points={{-61.2,10},{-100,10}}, color={0,0,127}));
  annotation (Diagram(graphics), Icon(graphics));
end Condenser;
