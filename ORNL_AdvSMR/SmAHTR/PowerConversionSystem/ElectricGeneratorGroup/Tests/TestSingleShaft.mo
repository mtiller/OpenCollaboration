within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Tests;
model TestSingleShaft
  import aSMR = ORNL_AdvSMR;

  SmAHTR.PowerConversionSystem.ElectricGeneratorGroup.Examples.SingleShaft_static
    singleShaft(
    Pn=50e8,
    eta=0.9,
    J_shaft=100,
    d_shaft=0,
    omega_nom=314.16/2,
    SSInit=true) annotation (Placement(transformation(extent={{0,-40},
            {80,40}}, rotation=0)));
  SmAHTR.PowerConversionSystem.SteamTurbines.SteamTurbineStodola
    steamTurbineStodola(
    wstart=67.6,
    wnom=67.6,
    eta_iso_nom=0.83387,
    Kt=0.00307,
    PRstart=5,
    pnom=12800000) annotation (Placement(transformation(extent={{-80,
            -20},{-40,20}}, rotation=0)));
  ORNL_AdvSMR.Components.SourceW sourceW(
    h=3.47e6,
    w0=67.6,
    p0=128e5) annotation (Placement(transformation(extent={{-102,50},
            {-82,70}}, rotation=0)));
  ORNL_AdvSMR.Components.SinkP sinkP(p0=29.8e5, h=3.1076e6)
                                                         annotation (
      Placement(transformation(extent={{-36,50},{-16,70}}, rotation=0)));
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
    annotation (Placement(transformation(extent={{10,-90},{30,-70}},
          rotation=0)));
  inner ORNL_AdvSMR.System system(allowFlowReversal=false)
                                                        annotation (
      Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(sourceW.flange, steamTurbineStodola.inlet) annotation (Line(
      points={{-82,60},{-76,60},{-76,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(sinkP.flange, steamTurbineStodola.outlet) annotation (Line(
      points={{-36,60},{-44,60},{-44,16}},
      thickness=0.5,
      color={0,0,255}));
  connect(sensors, singleShaft.SensorsBus) annotation (Line(points={{
          72,50},{90,50},{90,-16},{80,-16}}, color={255,170,213}));
  connect(actuators, singleShaft.ActuatorsBus) annotation (Line(
        points={{74,-50},{90,-50},{90,-28},{80,-28}}, color={213,255,
          170}));
  connect(booleanConstant.y, actuators.breakerClosed) annotation (
      Line(points={{31,-80},{50,-80},{50,-50},{74,-50}}, color={255,0,
          255}));
  connect(steamTurbineStodola.shaft_b, singleShaft.shaft) annotation (
     Line(
      points={{-47.2,0},{0,0}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end TestSingleShaft;
