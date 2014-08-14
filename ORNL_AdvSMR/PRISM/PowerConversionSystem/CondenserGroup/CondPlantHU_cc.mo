within ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup;
model CondPlantHU_cc
  "Condensation plant with condenser ratio control (type ImpPressureCondenser_tap) and coupling Heat Usage"
  extends Interfaces.CondPlantHU_base;
  parameter Modelica.SIunits.Volume mixCondenser_V
    "Internal volume of the mixer";
  parameter Modelica.SIunits.SpecificEnthalpy mixCondenser_hstart=1e5
    "Enthalpy start value";
  parameter Modelica.SIunits.Pressure mixCondenser_pstart=1e5
    "Pressure start value";

  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.CondPlant_cc condPlant_cc(
    p=p,
    Vtot=Vtot,
    Vlstart=Vlstart,
    setPoint_ratio=0.8,
    SSInit=SSInit)
    annotation (Placement(transformation(extent={{20,0},{80,60}}, rotation=0)));
  ThermoPower3.Water.Mixer mixCondenser(
    initOpt=if SSInit then ThermoPower3.Choices.Init.Options.steadyState else
        ThermoPower3.Choices.Init.Options.noInit,
    redeclare package Medium = FluidMedium,
    V=mixCondenser_V,
    pstart=mixCondenser_pstart) annotation (Placement(transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(condPlant_cc.SteamIn, SteamIn) annotation (Line(
      points={{50,60},{50,100}},
      thickness=0.5,
      color={0,0,255}));
  connect(WaterOut, mixCondenser.out) annotation (Line(
      points={{0,-100},{0,-60},{-1.83697e-015,-60}},
      thickness=0.5,
      color={0,0,255}));
  connect(mixCondenser.in1, condPlant_cc.WaterOut) annotation (Line(
      points={{6,-42},{6,-20},{50,-20},{50,0}},
      thickness=0.5,
      color={0,0,255}));
  connect(SensorsBus, condPlant_cc.SensorsBus) annotation (Line(points={{98,-40},
          {80,-40},{80,-20},{96,-20},{96,18},{79.4,18}}, color={255,170,213}));
  connect(ActuatorsBus, condPlant_cc.ActuatorsBus) annotation (Line(points={{98,
          -72},{72,-72},{72,-12},{88,-12},{88,8.4},{79.4,8.4}}, color={213,255,
          170}));
  connect(mixCondenser.in2, CondensatedFromHU) annotation (Line(
      points={{-6,-42},{-6,-20},{-50,-20},{-50,100}},
      thickness=0.5,
      color={0,0,255}));
  annotation (Diagram(graphics));
end CondPlantHU_cc;
