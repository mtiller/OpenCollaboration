within Ethan2;
model MixerTest "IdealMixing"

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SourceW sourceW(w0=10, h=1e5)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  ThermoPower3.Water.SinkP sinkP1(R=0, p0=6800000)
    annotation (Placement(transformation(extent={{84,10},{104,30}})));
  ThermoPower3.Water.SourceW sourceW1(w0=10, h=1e5)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  SensTHW sensTHW
    annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
  UserInteraction.Outputs.NumericValue numericValue(hideConnector=false)
    annotation (Placement(transformation(extent={{-32,68},{-12,88}})));
  UserInteraction.Outputs.NumericValue numericValue1(hideConnector=false)
    annotation (Placement(transformation(extent={{-32,52},{-12,72}})));
  SensTHW sensTHW2
    annotation (Placement(transformation(extent={{-72,-46},{-52,-26}})));
  UserInteraction.Outputs.NumericValue numericValue2(hideConnector=false)
    annotation (Placement(transformation(extent={{-38,-26},{-18,-6}})));
  UserInteraction.Outputs.NumericValue numericValue3(hideConnector=false)
    annotation (Placement(transformation(extent={{-38,-42},{-18,-22}})));
  SensTHW sensTHW1
    annotation (Placement(transformation(extent={{50,14},{70,34}})));
  UserInteraction.Outputs.NumericValue numericValue4(hideConnector=false)
    annotation (Placement(transformation(extent={{88,50},{108,70}})));
  UserInteraction.Outputs.NumericValue numericValue5(hideConnector=false)
    annotation (Placement(transformation(extent={{94,32},{114,52}})));
  ThermoPower3.Water.Mixer mix(
    hstart=1e5,
    V=0.1,
    pstart=101325)
    annotation (Placement(transformation(extent={{-2,24},{18,44}})));
  Modelica.Blocks.Sources.Ramp ramph1(
    offset=1e5,
    startTime=1,
    duration=2,
    height=10e5)
    annotation (Placement(transformation(extent={{-136,76},{-116,96}})));
  Modelica.Blocks.Sources.Ramp rampw1(
    height=0,
    duration=0,
    offset=10,
    startTime=0)
    annotation (Placement(transformation(extent={{-136,44},{-116,64}})));
  Modelica.Blocks.Sources.Ramp ramph2(
    offset=1e5,
    duration=2,
    startTime=4,
    height=5e5)
    annotation (Placement(transformation(extent={{-136,-4},{-116,16}})));
  Modelica.Blocks.Sources.Ramp rampw2(
    offset=10,
    height=10,
    duration=5,
    startTime=10)
    annotation (Placement(transformation(extent={{-136,-36},{-116,-16}})));
  ThermoPower3.Water.SourceW sourceW2(w0=10, h=1e5)
    annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
  ThermoPower3.Water.SourceW sourceW3(w0=10, h=1e5)
    annotation (Placement(transformation(extent={{-100,-78},{-80,-58}})));
  ThermoPower3.Water.FlowJoin join
    annotation (Placement(transformation(extent={{-4,-46},{16,-26}})));
  ThermoPower3.Water.SinkP sinkP2(R=0, p0=6800000)
    annotation (Placement(transformation(extent={{76,-46},{96,-26}})));
  SensTHW sensTHW3
    annotation (Placement(transformation(extent={{42,-42},{62,-22}})));
  UserInteraction.Outputs.NumericValue numericValue6(hideConnector=false)
    annotation (Placement(transformation(extent={{80,-6},{100,14}})));
  UserInteraction.Outputs.NumericValue numericValue7(hideConnector=false)
    annotation (Placement(transformation(extent={{86,-24},{106,-4}})));
equation
  connect(sourceW.flange, sensTHW.inlet) annotation (Line(
      points={{-80,40},{-66,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue.Value, sensTHW.H) annotation (Line(
      points={{-33,78},{-42,78},{-42,51.8},{-52,51.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue1.Value, sensTHW.W) annotation (Line(
      points={{-33,62},{-40,62},{-40,45},{-52,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue2.Value, sensTHW2.H) annotation (Line(
      points={{-39,-16},{-42,-16},{-42,-28.2},{-54,-28.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue3.Value, sensTHW2.W) annotation (Line(
      points={{-39,-32},{-46,-32},{-46,-35},{-54,-35}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensTHW2.inlet, sourceW1.flange) annotation (Line(
      points={{-68,-40},{-80,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue4.Value, sensTHW1.H) annotation (Line(
      points={{87,60},{78,60},{78,31.8},{68,31.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue5.Value, sensTHW1.W) annotation (Line(
      points={{93,42},{80,42},{80,25},{68,25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensTHW1.outlet, sinkP1.flange) annotation (Line(
      points={{66,20},{84,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mix.out, sensTHW1.inlet) annotation (Line(
      points={{18,34},{38,34},{38,20},{54,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mix.in1, sensTHW.outlet) annotation (Line(
      points={{0,40},{-54,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mix.in2, sensTHW2.outlet) annotation (Line(
      points={{0,28},{-14,28},{-14,-40},{-56,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(rampw1.y, sourceW.in_w0) annotation (Line(
      points={{-115,54},{-110,54},{-110,46},{-94,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramph1.y, sourceW.in_h) annotation (Line(
      points={{-115,86},{-86,86},{-86,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramph2.y, sourceW1.in_h) annotation (Line(
      points={{-115,6},{-86,6},{-86,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(rampw2.y, sourceW1.in_w0) annotation (Line(
      points={{-115,-26},{-94,-26},{-94,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW3.in_w0, sourceW1.in_w0) annotation (Line(
      points={{-94,-62},{-100,-62},{-100,-60},{-108,-60},{-108,-26},{-94,-26},
          {-94,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW3.in_h, sourceW1.in_h) annotation (Line(
      points={{-86,-62},{-86,-52},{-104,-52},{-104,6},{-86,6},{-86,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW2.in_h, sourceW.in_h) annotation (Line(
      points={{-86,24},{-86,30},{-106,30},{-106,86},{-86,86},{-86,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceW2.in_w0, sourceW.in_w0) annotation (Line(
      points={{-94,24},{-112,24},{-112,54},{-110,54},{-110,46},{-94,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(join.in1, sourceW2.flange) annotation (Line(
      points={{0,-32},{0,18},{-80,18}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(join.in2, sourceW3.flange) annotation (Line(
      points={{0,-40},{0,-68},{-80,-68}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue6.Value, sensTHW3.H) annotation (Line(
      points={{79,4},{70,4},{70,-24.2},{60,-24.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue7.Value, sensTHW3.W) annotation (Line(
      points={{85,-14},{72,-14},{72,-31},{60,-31}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensTHW3.outlet, sinkP2.flange) annotation (Line(
      points={{58,-36},{76,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensTHW3.inlet, join.out) annotation (Line(
      points={{46,-36},{12,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end MixerTest;
