within Ethan2;
model SteamSeperationPlatform "Test flow rate of a pump tank loop"
  parameter Modelica.SIunits.MassFlowRate wNa = 2309.5;
  parameter Modelica.SIunits.MassFlowRate wh2o = 279.15;
  parameter Integer Nnodes = 5;
  parameter Modelica.SIunits.Length dtube = 0.024;
  parameter Modelica.SIunits.Length ttube = 0.00775;
  parameter Integer Ntw = 1838 "Number of tubes in bundle";
  parameter Modelica.SIunits.Length dshroud = 2.75;
  parameter Modelica.SIunits.Length HTLength = 16.76;
  parameter Modelica.SIunits.Volume plenumvol = 1.5 "tube plenum volume";
  constant Real pi = 3.14159265;

  ThermoPower3.Water.SinkP sinkP(
    h=1e5,
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    R=0,
    p0=6800000)
           annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  ThermoPower3.Water.SourceW sourceW(
    G=0,
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    w0=279,
    p0=6800000,
    h=2.2e5)
    annotation (Placement(transformation(extent={{-136,-30},{-116,-10}})));
  ThermoPower3.Water.SinkP sinkP1(            redeclare package Medium =
        Modelica.Media.Water.WaterIF97_ph,
    p0=6800000,
    R=0)
    annotation (Placement(transformation(extent={{-72,-74},{-92,-54}})));
  ThermoPower3.Water.SensW sensW2
    annotation (Placement(transformation(extent={{-98,-26},{-78,-6}})));
  UserInteraction.Outputs.NumericValue numericValue1(hideConnector=false)
    annotation (Placement(transformation(extent={{-76,-6},{-56,14}})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  SteamDrumSeperator
              ms(
    Mlstart=200,
    Mvstart=2,
    Vnom=1,
    Anom=1,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  UserInteraction.Outputs.NumericValue numericValue(input_Value=ms.steam.p/
        1e5) annotation (Placement(transformation(extent={{6,-14},{26,6}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=ms.cond.p/
        1e5) annotation (Placement(transformation(extent={{4,-44},{24,-24}})));
  ThermoPower3.Water.Tank tank(
    A=0.1,
    V0=0.1,
    pext=6800000,
    ystart=1,
    hstart=5e5)
    annotation (Placement(transformation(extent={{-38,-68},{-58,-48}})));
equation
  connect(sensW2.w, numericValue1.Value) annotation (Line(
      points={{-80,-10},{-78,-10},{-78,4},{-77,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW.flange, sensW2.inlet) annotation (Line(
      points={{-116,-20},{-94,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensW2.outlet, ms.feed) annotation (Line(
      points={{-82,-20},{-10,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.steam, sinkP.flange) annotation (Line(
      points={{9.8,-20},{100,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.cond, tank.inlet) annotation (Line(
      points={{0,-30},{-36,-30},{-36,-64},{-40,-64}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tank.outlet, sinkP1.flange) annotation (Line(
      points={{-56,-64},{-72,-64}},
      color={0,0,255},
      smooth=Smooth.None));
 annotation (Placement(transformation(extent={{15,-12},{-15,12}},
        rotation=180,
        origin={-21,-20})),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SteamSeperationPlatform;
