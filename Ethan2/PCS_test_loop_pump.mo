within Ethan2;
model PCS_test_loop_pump
  Modelica.SIunits.MassFlowRate expected;
  Modelica.SIunits.MassFlowRate out;

  constant Real pi = Modelica.Constants.pi;
  parameter Real wop = 190 "nominal mass flow";
  Real rhop = 948 "nominal density";
  Real qop = wop/rhop;
  parameter Real dop = 66 "nominal pressure increase (bar)";
  Real hop = (dop*1e5)/(rhop*9.81);
  constant Real slop = 1.3;

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  SteamDrumSeperator ms(
    Vnom=1,
    Mlstart=200,
    Mvstart=20,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  UserInteraction.Outputs.NumericValue numericValue3(input_Value=ms.conserve/
        1e6)
    annotation (Placement(transformation(extent={{-52,52},{-32,72}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=ms.p/1e5)
    annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
  ThermoPower3.Water.SensW sensW
    annotation (Placement(transformation(extent={{-56,-42},{-76,-22}})));
  UserInteraction.Outputs.NumericValue numericValue5(input_Value=ms.p/1e5,
      hideConnector=false)
    annotation (Placement(transformation(extent={{-90,-2},{-110,18}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=0,
    duration=1,
    offset=450e6,
    startTime=0)
    annotation (Placement(transformation(extent={{-190,68},{-170,88}})));
  ThermoPower3.Water.Mixer fw2(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    hstart=1e5,
    V=1,
    pstart=6800000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-38,-36})));
  ThermoPower3.Water.Flow1D flow1D(
    N=5,
    Nt=100,
    L=0.5,
    H=0,
    A=0.2,
    omega=0.2,
    Dhyd=0.2,
    wnom=279.15,
    hstartin=8e5,
    hstartout=2.2e6,
    pstart=6800000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-148,4})));
  ThermoPower3.Thermal.ConvHT convHT(gamma=1000, N=5)
    annotation (Placement(transformation(extent={{-174,18},{-154,38}})));
  ThermoPower3.Thermal.HeatSource1D heatSource1D(
    N=5,
    Nt=100,
    L=1,
    omega=1)
    annotation (Placement(transformation(extent={{-174,36},{-154,56}})));
  ThermoPower3.Water.Header header(
    V=5,
    hstart=2.4e6,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-104,30},{-84,50}})));
  ThermoPower3.Water.Pump pump1(
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.quadraticFlow (q_nom={0.5*qop,qop,2*qop},
          head_nom={slop*hop,hop,hop/slop}),
    n0=1000,
    V=10,
    rho0=998,
    wstart=9,
    w0=210,
    hstart=5e5,
    dp0=6100000)                   annotation (Placement(transformation(extent={{-104,
            -48},{-124,-28}})));
  ThermoPower3.Water.Tank tank1(
    A=1,
    V0=0.1,
    hstart=5e5,
    ystart=5.6925,
    pext=720000)
    annotation (Placement(transformation(extent={{-80,-40},{-100,-20}})));
  ThermoPower3.Water.SinkP sinkP
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  ThermoPower3.Water.SourceW sourceW
    annotation (Placement(transformation(extent={{10,-52},{-10,-32}})));
equation
  expected = ms.x*ms.qf;
  out = ms.qs+ms.qc;
  connect(numericValue5.Value, sensW.w) annotation (Line(
      points={{-89,8},{-80,8},{-80,-26},{-74,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ms.cond, fw2.in1) annotation (Line(
      points={{-42,30},{-30,30},{-30,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensW.inlet, fw2.out) annotation (Line(
      points={{-60,-36},{-48,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(convHT.side2, flow1D.wall) annotation (Line(
      points={{-164,24.9},{-158,24.9},{-158,4},{-153,4}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(heatSource1D.wall, convHT.side1) annotation (Line(
      points={{-164,43},{-164,31}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(header.inlet, flow1D.outfl) annotation (Line(
      points={{-104.1,40},{-148,40},{-148,14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp1.y, heatSource1D.power) annotation (Line(
      points={{-169,78},{-168,78},{-168,50},{-164,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(header.outlet, ms.feed) annotation (Line(
      points={{-84,40},{-52,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump1.infl, tank1.outlet) annotation (Line(
      points={{-106,-36},{-98,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tank1.inlet, sensW.outlet) annotation (Line(
      points={{-82,-36},{-76,-36},{-76,-36},{-72,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump1.outfl, flow1D.infl) annotation (Line(
      points={{-120,-31},{-148,-31},{-148,-6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP.flange, ms.steam) annotation (Line(
      points={{-10,40},{-32.2,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sourceW.flange, fw2.in2) annotation (Line(
      points={{-10,-42},{-30,-42}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PCS_test_loop_pump;
