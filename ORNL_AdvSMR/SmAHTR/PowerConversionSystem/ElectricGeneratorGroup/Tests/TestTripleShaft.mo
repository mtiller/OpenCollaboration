within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Tests;
model TestTripleShaft
  import aSMR = ORNL_AdvSMR;

protected
  ORNL_AdvSMR.Interfaces.Sensors sensors
                                      annotation (Placement(
        transformation(
        origin={72,50},
        extent={{-10,-6},{10,6}},
        rotation=180)));
  ORNL_AdvSMR.Interfaces.Actuators actuators
                                          annotation (Placement(
        transformation(extent={{64,-56},{84,-44}}, rotation=0)));
public
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{20,-98},{40,-78}},
          rotation=0)));
  SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples.TripleShaft_static
    tripleShaft(
    Pn=50e8,
    J_shaft_A=2000,
    J_shaft_B=2000,
    J_shaft_C=2000,
    omega_nom_A=314.16/2,
    omega_nom_B=314.16/2,
    omega_nom_C=314.16/2,
    SSInit=true) annotation (Placement(transformation(extent={{0,-40},
            {80,40}}, rotation=0)));
  SmAHTR.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    Turbine1(
    wstart=70.59,
    wnom=70.59,
    Kt=0.00307,
    eta_iso_nom=0.83,
    PRstart=5,
    pnom=12800000) annotation (Placement(transformation(extent={{-84,
            40},{-44,80}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW1(
    h=3.47e6,
    w0=67.6,
    p0=128e5) annotation (Placement(transformation(extent={{-100,80},
            {-86,94}}, rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP1(p0=29.8e5, h=3.1076e6)
                                                          annotation (
     Placement(transformation(extent={{-40,82},{-28,94}}, rotation=0)));
  SmAHTR.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    Turbine2(
    eta_iso_nom=0.9,
    Kt=0.01478,
    wstart=81.1,
    wnom=81.1,
    PRstart=5,
    pnom=2700000) annotation (Placement(transformation(extent={{-84,-20},
            {-44,20}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW2(
    w0=81.1,
    p0=26.8e5,
    h=3.554e6) annotation (Placement(transformation(extent={{-100,24},
            {-86,38}}, rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP2(p0=6e5, h=3.128e6)
                                                      annotation (
      Placement(transformation(extent={{-40,26},{-28,38}}, rotation=0)));
  SmAHTR.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    Turbine3(
    wstart=89.82,
    wnom=89.82,
    Kt=0.0769,
    PRstart=5,
    pnom=600000) annotation (Placement(transformation(extent={{-84,-78},
            {-44,-38}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW3(
    w0=89.82,
    p0=6e5,
    h=3.109e6) annotation (Placement(transformation(extent={{-100,-36},
            {-86,-22}}, rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP3(p0=5.3982e3, h=2.3854)
                                                          annotation (
     Placement(transformation(extent={{-40,-34},{-28,-22}}, rotation=
            0)));
  inner ORNL_AdvSMR.System system
                               annotation (Placement(transformation(
          extent={{80,80},{100,100}})));
equation
  connect(tripleShaft.SensorsBus, sensors) annotation (Line(points={{
          80,-16},{92,-16},{92,50},{72,50}}, color={255,170,213}));
  connect(actuators, tripleShaft.ActuatorsBus) annotation (Line(
        points={{74,-50},{92,-50},{92,-28},{80,-28}}, color={213,255,
          170}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftA)
    annotation (Line(points={{41,-88},{60,-88},{60,-50},{74,-50}},
        color={255,0,255}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftB)
    annotation (Line(points={{41,-88},{54,-88},{54,-50},{74,-50}},
        color={255,0,255}));
  connect(booleanConstant.y, actuators.breakerClosed_shaftC)
    annotation (Line(points={{41,-88},{48,-88},{48,-50},{74,-50}},
        color={255,0,255}));
  connect(sourceW1.flange, Turbine1.inlet) annotation (Line(
      points={{-86,87},{-80,87},{-80,76}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP1.flange, Turbine1.outlet) annotation (Line(
      points={{-40,88},{-48,88},{-48,76}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourceW2.flange, Turbine2.inlet) annotation (Line(
      points={{-86,31},{-80,31},{-80,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP2.flange, Turbine2.outlet) annotation (Line(
      points={{-40,32},{-48,32},{-48,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(Turbine1.shaft_b, tripleShaft.shaft_A) annotation (Line(
      points={{-51.2,60},{-20,60},{-20,24},{0,24}},
      color={0,0,0},
      thickness=0.5));
  connect(Turbine2.shaft_b, tripleShaft.shaft_B) annotation (Line(
      points={{-51.2,0},{0,0}},
      color={0,0,0},
      thickness=0.5));
  connect(sourceW3.flange, Turbine3.inlet) annotation (Line(
      points={{-86,-29},{-80,-29},{-80,-42}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP3.flange, Turbine3.outlet) annotation (Line(
      points={{-40,-28},{-48,-28},{-48,-42}},
      thickness=0.5,
      color={0,0,255}));
  connect(Turbine3.shaft_b, tripleShaft.shaft_C) annotation (Line(
      points={{-51.2,-58},{-20,-58},{-20,-24},{0,-24}},
      color={0,0,0},
      thickness=0.5));
  annotation (Diagram(graphics));
end TestTripleShaft;
