within ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup;
model CondPlant_open
  "Condensation plant with condenser ratio control (type ImpPressureCondenser_tap)"
  extends Interfaces.CondPlant_base;
  parameter Real setPoint_ratio "SetPoint ratio Steam Volume / Total Volume";

  ThermoPower3.PowerPlants.SteamTurbineGroup.Components.Comp_bubble_h
    BubbleEnthalpy(redeclare package FluidMedium = FluidMedium, p=p)
    annotation (Placement(transformation(extent={{68,-54},{38,-34}}, rotation=0)));

  ThermoPower3.Water.SinkP sinkP(p0=p) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
  ThermoPower3.Water.SourceP sourceP(p0=p) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-40})));
equation

  connect(sinkP.flange, SteamIn) annotation (Line(
      points={{1.83697e-015,40},{0,40},{0,100}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WaterOut, sourceP.flange) annotation (Line(
      points={{0,-100},{0,-50},{-1.83697e-015,-50}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(BubbleEnthalpy.h, sourceP.in_h) annotation (Line(
      points={{39.5,-44},{9,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end CondPlant_open;
