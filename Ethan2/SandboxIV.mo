within Ethan2;
model SandboxIV
  Modelica.SIunits.MassFlowRate expected;
   Modelica.SIunits.MassFlowRate out;
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SourceW sourceW(w0=279.15, h=2.2e6)
    annotation (Placement(transformation(extent={{-108,30},{-88,50}})));
  ThermoPower3.Water.SteamTurbineStodola hpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6800000,
    Kt=0.0112)
    annotation (Placement(transformation(extent={{-14,58},{6,38}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        3000/60*3.14159)
    annotation (Placement(transformation(extent={{90,48},{74,64}})));
  SteamDrumSeperator ms(
    Vnom=1,
    Mlstart=200,
    Mvstart=20,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  UserInteraction.Outputs.NumericValue out_power(input_Value=hpturbine.Pm/1e6)
    annotation (Placement(transformation(extent={{-16,6},{4,26}})));
  PrePresCondenser ppc
    annotation (Placement(transformation(extent={{86,-8},{106,12}})));
  ThermoPower3.Water.Mixer mixer(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=15,
    pstart=6800000,
    hstart=1e5)
    annotation (Placement(transformation(extent={{-24,-46},{-44,-26}})));
  UserInteraction.Outputs.NumericValue numericValue1(input_Value=ppc.Condenser.Q
        /1e6)
    annotation (Placement(transformation(extent={{108,-8},{128,12}})));
  UserInteraction.Outputs.NumericValue numericValue3(input_Value=ms.conserve/
        1e6)
    annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=ms.p/1e5)
    annotation (Placement(transformation(extent={{-54,10},{-34,30}})));
  ThermoPower3.Water.SinkP sinkP(p0=6800000)
    annotation (Placement(transformation(extent={{-90,-46},{-110,-26}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=10,
    offset=68e5,
    startTime=2,
    height=0)
    annotation (Placement(transformation(extent={{-152,-10},{-132,10}})));
  UserInteraction.Outputs.NumericValue numericValue4(input_Value=ms.steam.p/
        1e5)
    annotation (Placement(transformation(extent={{-34,40},{-14,60}})));
  ThermoPower3.Water.SteamTurbineStodola lpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6.8e+16,
    Kt=0.09) annotation (Placement(transformation(extent={{38,58},{58,38}})));
  UserInteraction.Outputs.NumericValue out_power1(input_Value=lpturbine.Pm/
        1e6) annotation (Placement(transformation(extent={{38,6},{58,26}})));
  UserInteraction.Outputs.NumericValue out_power2(input_Value=hpturbine.outlet.p
        /1e5) annotation (Placement(transformation(extent={{12,46},{32,66}})));
  ThermoPower3.Water.Mixer mixer1(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=15,
    pstart=6800000,
    hstart=1e5)
    annotation (Placement(transformation(extent={{44,-52},{24,-32}})));
  ThermoPower3.Water.FlowSplit flowSplit
    annotation (Placement(transformation(extent={{12,26},{32,46}})));
  ThermoPower3.Water.Pump pump(
    w0=10,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.linearFlow (q_nom={0.5*qop,2*qop},
          head_nom={1.1*hop,hop/1.1}),
    n0=1000,
    V=10,
    wstart=10,
    rho0=998,
    dp0=6100000)                   annotation (Placement(transformation(extent={{10,-54},
            {-10,-34}})));
equation
  expected = ms.x*ms.qf;
  out = ms.qs+ms.qc;
  connect(ms.steam, hpturbine.inlet) annotation (Line(
      points={{-32.2,40},{-12,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sourceW.flange, ms.feed) annotation (Line(
      points={{-88,40},{-52,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.out, sinkP.flange) annotation (Line(
      points={{-44,-36},{-90,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp.y, sinkP.in_p0) annotation (Line(
      points={{-131,0},{-88,0},{-88,-27.2},{-96,-27.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lpturbine.outlet, ppc.flangeA) annotation (Line(
      points={{56,40},{96.4,40},{96.4,12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hpturbine.shaft_b, lpturbine.shaft_a) annotation (Line(
      points={{2.4,48},{41.4,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(lpturbine.shaft_b, constantSpeed.flange) annotation (Line(
      points={{54.4,48},{54,48},{54,56},{74,56}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(ms.cond, mixer.in1) annotation (Line(
      points={{-42,30},{-22,30},{-22,-30},{-26,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ppc.flangeB, mixer1.in2) annotation (Line(
      points={{96.4,-8},{68,-8},{68,-48},{42,-48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hpturbine.outlet, flowSplit.in1) annotation (Line(
      points={{4,40},{10,40},{10,36},{16,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out1, lpturbine.inlet) annotation (Line(
      points={{28,40},{40,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out2, mixer1.in1) annotation (Line(
      points={{28,32},{30,32},{30,-26},{50,-26},{50,-36},{42,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer1.out, pump.infl) annotation (Line(
      points={{24,-42},{8,-42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.in2, pump.outfl) annotation (Line(
      points={{-26,-42},{-16,-42},{-16,-37},{-6,-37}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SandboxIV;
