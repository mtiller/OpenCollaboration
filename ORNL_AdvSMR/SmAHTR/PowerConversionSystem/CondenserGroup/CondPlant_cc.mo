within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.CondenserGroup;
model CondPlant_cc
  "Condensation plant with condenser ratio control (type ImpPressureCondenser_tap)"
  extends SmAHTR.PowerConversionSystem.CondenserGroup.Interfaces.CondPlant_base;
  parameter Real setPoint_ratio "SetPoint ratio Steam Volume / Total Volume";

  ThermoPower3.PowerPlants.Control.PID pID(
    PVmax=1,
    PVmin=0.1,
    CSmin=-0.6,
    CSmax=0.6,
    Ti=2000,
    Kp=-3,
    steadyStateInit=SSInit) annotation (Placement(transformation(extent=
           {{-40,34},{-60,54}}, rotation=0)));
  Modelica.Blocks.Sources.Constant setPoint(k=setPoint_ratio)
    annotation (Placement(transformation(extent={{-6,42},{-18,54}},
          rotation=0)));
  Condensers.CondenserPreP_tap condenserIdeal_tap(
    redeclare package Medium = FluidMedium,
    p=p,
    Vtot=Vtot,
    Vlstart=Vlstart) annotation (Placement(transformation(extent={{16,-26},
            {76,34}}, rotation=0)));
  ThermoPower3.Water.SourceW sourceTap(
    redeclare package Medium = FluidMedium,
    p0=p,
    allowFlowReversal=true) annotation (Placement(transformation(extent=
           {{-80,-30},{-60,-10}}, rotation=0)));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Components.Comp_bubble_h
    BubbleEnthalpy(redeclare package FluidMedium = FluidMedium, p=p)
    annotation (Placement(transformation(extent={{-30,-10},{-60,10}},
          rotation=0)));
  parameter Boolean SSInit=false "Initialize in steady state";
equation

  connect(setPoint.y, pID.SP)
    annotation (Line(points={{-18.6,48},{-40,48}}, color={0,0,127}));
  connect(pID.CS, sourceTap.in_w0) annotation (Line(points={{-60,44},{-74,
          44},{-74,-14}}, color={0,0,127}));
  connect(pID.PV, condenserIdeal_tap.ratio_Vv_Vtot) annotation (Line(
        points={{-40,40},{-28,40},{-28,-2},{16,-2}}, color={0,0,127}));
  connect(condenserIdeal_tap.steamIn, SteamIn) annotation (Line(
      points={{46,34},{46,64},{0,64},{0,100}},
      thickness=0.5,
      color={0,0,255}));
  connect(condenserIdeal_tap.waterOut, WaterOut) annotation (Line(
      points={{46,-26},{46,-52},{0,-52},{0,-100}},
      thickness=0.5,
      color={0,0,255}));
  connect(BubbleEnthalpy.h, sourceTap.in_h) annotation (Line(points={{-58.5,
          0},{-66,0},{-66,-14}}, color={0,0,127}));
  connect(SensorsBus.Cond_ratio, condenserIdeal_tap.ratio_Vv_Vtot)
    annotation (Line(points={{98,-40},{-8,-40},{-8,-2},{16,-2}}, color=
          {255,170,213}));
  connect(SensorsBus.Cond_Q, condenserIdeal_tap.Qcond) annotation (Line(
        points={{98,-40},{-8,-40},{-8,16},{16,16}}, color={255,170,213}));
  connect(sourceTap.flange, condenserIdeal_tap.tapWater) annotation (
      Line(
      points={{-60,-20},{22,-20}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon);
end CondPlant_cc;
