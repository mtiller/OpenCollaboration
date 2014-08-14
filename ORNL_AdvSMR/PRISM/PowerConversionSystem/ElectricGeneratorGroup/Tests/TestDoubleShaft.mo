within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Tests;
model TestDoubleShaft
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    Turbine1(
    wstart=70.59,
    wnom=70.59,
    Kt=0.00307,
    eta_iso_nom=0.83,
    PRstart=5,
    pnom=12800000) annotation (Placement(transformation(extent={{-76,8},{-36,48}},
          rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW1(
    h=3.47e6,
    w0=67.6,
    p0=128e5) annotation (Placement(transformation(extent={{-96,54},{-82,68}},
          rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP1(p0=29.8e5, h=3.1076e6) annotation (
      Placement(transformation(extent={{-30,54},{-18,66}},rotation=0)));
protected
  ORNL_AdvSMR.Interfaces.Sensors sensors annotation (Placement(transformation(
        origin={72,50},
        extent={{-10,-6},{10,6}},
        rotation=180)));
  ORNL_AdvSMR.Interfaces.Actuators actuators annotation (Placement(
        transformation(extent={{64,-36},{84,-24}}, rotation=0)));
public
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true) annotation (
      Placement(transformation(extent={{20,-70},{40,-50}}, rotation=0)));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGeneratorGroup.Examples.DoubleShaft_static
    doubleShaft(
    Pn=50e8,
    J_shaft_A=2000,
    omega_nom_A=314.16/2,
    J_shaft_B=2000,
    omega_nom_B=314.16/2,
    SSInit=true) annotation (Placement(transformation(extent={{20,-20},{80,40}},
          rotation=0)));
  ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    Turbine2(
    eta_iso_nom=0.9,
    Kt=0.01478,
    wstart=81.1,
    wnom=81.1,
    PRstart=5,
    pnom=2800000) annotation (Placement(transformation(extent={{-76,-50},{-36,-10}},
          rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW2(
    w0=81.1,
    p0=26.8e5,
    h=3.554e6) annotation (Placement(transformation(extent={{-96,-6},{-82,8}},
          rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP2(p0=6e5, h=3.128e6) annotation (Placement(
        transformation(extent={{-30,-6},{-18,6}}, rotation=0)));
  inner ORNL_AdvSMR.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(sourceW1.flange, Turbine1.inlet) annotation (Line(
      points={{-82,61},{-72,61},{-72,44}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP1.flange, Turbine1.outlet) annotation (Line(
      points={{-30,60},{-40,60},{-40,44}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourceW2.flange, Turbine2.inlet) annotation (Line(
      points={{-82,1},{-72,1},{-72,-14}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP2.flange, Turbine2.outlet) annotation (Line(
      points={{-30,0},{-40,0},{-40,-14}},
      thickness=0.5,
      color={0,0,255}));
  connect(Turbine2.shaft_b, doubleShaft.shaft_B) annotation (Line(
      points={{-43.2,-30},{0,-30},{0,-5},{20,-5}},
      color={0,0,0},
      thickness=0.5));
  connect(Turbine1.shaft_b, doubleShaft.shaft_A) annotation (Line(
      points={{-43.2,28},{-11.75,28},{-11.75,25},{19.7,25}},
      color={0,0,0},
      thickness=0.5));
  connect(actuators, doubleShaft.ActuatorsBus) annotation (Line(points={{74,-30},
          {92,-30},{92,-11},{80,-11}}, color={213,255,170}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftA) annotation (Line(
        points={{41,-60},{60,-60},{60,-30},{74,-30}}, color={255,0,255}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftB) annotation (Line(
        points={{41,-60},{52,-60},{52,-30},{74,-30}}, color={255,0,255}));
  connect(doubleShaft.SensorsBus, sensors) annotation (Line(points={{80,-2},{92,
          -2},{92,50},{72,50}}, color={255,170,213}));
  annotation (Diagram(graphics));
end TestDoubleShaft;
