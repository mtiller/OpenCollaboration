within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.Tests;
model RankineCycleSim
  "This model simulates an example Rankine-Cycle-based power conversion system."
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.Components.SteamTurbineStodola steamTurbineStodola(
    PRstart=5,
    wnom=100,
    Kt=0.01478,
    pnom=6000000)
    annotation (Placement(transformation(extent={{-40,-40},{0,0}})));
  ORNL_AdvSMR.Components.SourceP sourceP(h=5e6, p0=6000000)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  ORNL_AdvSMR.Components.SinkP sinkP(p0=5500000)
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  inner ORNL_AdvSMR.System system
                               annotation (Placement(transformation(
          extent={{-100,80},{-80,100}})));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.SingleShaft_static
    singleShaft_static(Pn=100e6, J_shaft=2000)
    annotation (Placement(transformation(extent={{40,-40},{80,0}})));
  ORNL_AdvSMR.Interfaces.Actuators actuators
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  ORNL_AdvSMR.Interfaces.Sensors sensors
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      w_fixed=314.16/2) annotation (Placement(transformation(extent={{-90,
            -30},{-70,-10}})));
equation
  connect(sourceP.flange, steamTurbineStodola.inlet) annotation (Line(
      points={{-50,30},{-40,30},{-40,0}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sinkP.flange, steamTurbineStodola.outlet) annotation (Line(
      points={{10,-80},{0,-80},{0,-40}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(steamTurbineStodola.shaft_b, singleShaft_static.shaft)
    annotation (Line(
      points={{0,-20},{40,-20}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(singleShaft_static.SensorsBus, sensors) annotation (Line(
      points={{80,-28},{90,-28},{90,30},{70,30}},
      color={255,170,213},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(singleShaft_static.ActuatorsBus, actuators) annotation (Line(
      points={{80,-34},{90,-34},{90,-70},{70,-70}},
      color={213,255,170},
      thickness=1,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(constantSpeed.flange, steamTurbineStodola.shaft_a)
    annotation (Line(
      points={{-70,-20},{-40,-20}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics));
end RankineCycleSim;
