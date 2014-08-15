within Ethan2;
model SandboxIII

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SourceW sourceW(w0=10, h=1e5)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  ThermoPower3.Water.SinkP sinkP1(R=0, p0=6800000)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  ThermoPower3.Water.SourceW sourceW1(w0=10, h=1e5)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  SensTHW sensTHW
    annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
  UserInteraction.Outputs.NumericValue numericValue(hideConnector=false)
    annotation (Placement(transformation(extent={{-32,68},{-12,88}})));
  UserInteraction.Outputs.NumericValue numericValue1(hideConnector=false)
    annotation (Placement(transformation(extent={{-32,52},{-12,72}})));
  SensTHW sensTHW2
    annotation (Placement(transformation(extent={{-72,-34},{-52,-54}})));
  UserInteraction.Outputs.NumericValue numericValue2(hideConnector=false)
    annotation (Placement(transformation(extent={{-34,-58},{-14,-38}})));
  UserInteraction.Outputs.NumericValue numericValue3(hideConnector=false)
    annotation (Placement(transformation(extent={{-34,-76},{-14,-56}})));
  SensTHW sensTHW1
    annotation (Placement(transformation(extent={{46,-6},{66,14}})));
  UserInteraction.Outputs.NumericValue numericValue4(hideConnector=false)
    annotation (Placement(transformation(extent={{84,30},{104,50}})));
  UserInteraction.Outputs.NumericValue numericValue5(hideConnector=false)
    annotation (Placement(transformation(extent={{90,12},{110,32}})));
  ThermoPower3.Water.Mixer mixer(
    V=1,
    pstart=101325,
    hstart=1e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp ramp
    annotation (Placement(transformation(extent={{-136,76},{-116,96}})));
  Modelica.Blocks.Sources.Ramp ramp1
    annotation (Placement(transformation(extent={{-136,44},{-116,64}})));
  Modelica.Blocks.Sources.Ramp ramp2
    annotation (Placement(transformation(extent={{-136,-4},{-116,16}})));
  Modelica.Blocks.Sources.Ramp ramp3
    annotation (Placement(transformation(extent={{-136,-36},{-116,-16}})));
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
      points={{-35,-48},{-42,-48},{-42,-51.8},{-54,-51.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue3.Value, sensTHW2.W) annotation (Line(
      points={{-35,-66},{-46,-66},{-46,-45},{-54,-45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensTHW2.inlet, sourceW1.flange) annotation (Line(
      points={{-68,-40},{-80,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue4.Value, sensTHW1.H) annotation (Line(
      points={{83,40},{74,40},{74,11.8},{64,11.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue5.Value, sensTHW1.W) annotation (Line(
      points={{89,22},{76,22},{76,5},{64,5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensTHW1.outlet, sinkP1.flange) annotation (Line(
      points={{62,0},{80,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.out, sensTHW1.inlet) annotation (Line(
      points={{10,0},{50,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.in1, sensTHW.outlet) annotation (Line(
      points={{-8,6},{-30,6},{-30,40},{-54,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.in2, sensTHW2.outlet) annotation (Line(
      points={{-8,-6},{-30,-6},{-30,-40},{-56,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp1.y, sourceW.in_w0) annotation (Line(
      points={{-115,54},{-104,54},{-104,46},{-94,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, sourceW.in_h) annotation (Line(
      points={{-115,86},{-86,86},{-86,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp2.y, sourceW1.in_h) annotation (Line(
      points={{-115,6},{-86,6},{-86,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp3.y, sourceW1.in_w0) annotation (Line(
      points={{-115,-26},{-94,-26},{-94,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SandboxIII;
