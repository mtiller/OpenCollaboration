within Ethan2;
model PCS_test_2
  Modelica.SIunits.MassFlowRate expected;
  Modelica.SIunits.MassFlowRate out;

  constant Real pi = Modelica.Constants.pi;
  parameter Real wop = 190 "nominal mass flow fw pump 1";
  parameter Real wop2 = 279.15 "nominal mass flow fw pump 2";
  Real rhop = 948 "nominal density";
  Real rhop2 = 886 "nominal density fw 2";
  Real qop = wop/rhop;
  parameter Real dop = 66 "nominal pressure increase (bar)";
  Real hop = (dop*1e5)/(rhop*9.81);
  Real hop2 = (0.75*1e5)/(886*9.81);
  constant Real slop = 1.3;

  parameter Modelica.SIunits.Length dtube = 0.024;
  parameter Integer Ntw = 1838 "Number of tubes in bundle";
  parameter Modelica.SIunits.Length HTLength = 16.76;

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SourceW sourceW(w0=279.15, h=2.2e6)
    annotation (Placement(transformation(extent={{-138,30},{-118,50}})));
  ThermoPower3.Water.SteamTurbineStodola hpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6800000,
    Kt=0.0135)
    annotation (Placement(transformation(extent={{-14,58},{6,38}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        3000/60*3.14159)
    annotation (Placement(transformation(extent={{164,38},{148,54}})));
  SteamDrumSeperator ms(
    Vnom=1,
    Mlstart=200,
    Mvstart=20,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  PrePresCondenser ppc(hop=76.8)
    annotation (Placement(transformation(extent={{82,-12},{102,8}})));
  ThermoPower3.Water.SinkP sinkP(p0=6800000)
    annotation (Placement(transformation(extent={{-116,-66},{-136,-46}})));
  ThermoPower3.Water.SteamTurbineStodola lpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6.8e+16,
    Kt=0.089)
             annotation (Placement(transformation(extent={{38,58},{58,38}})));
  ThermoPower3.Water.Mixer fw1(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=1,
    hstart=6e5,
    allowFlowReversal=false,
    pstart=6800000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-46})));
  ThermoPower3.Water.FlowSplit flowSplit
    annotation (Placement(transformation(extent={{12,26},{32,46}})));
  ThermoPower3.Water.Pump pumpfw1(
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.quadraticFlow (q_nom={0.5*
            qop,qop,2*qop}, head_nom={slop*hop,hop,hop/slop}),
    n0=1000,
    V=10,
    rho0=998,
    w0=210,
    hstart=6.1e5,
    wstart=210,
    dp0=6100000)
    annotation (Placement(transformation(extent={{2,-78},{-18,-58}})));
  ThermoPower3.Water.Tank fwtank1(
    A=1,
    V0=0.1,
    hstart=5e5,
    pext=690000,
    ystart=7.099)
    annotation (Placement(transformation(extent={{26,-70},{6,-50}})));
  Modelica.Blocks.Sources.Sine ramp1(
    startTime=500,
    amplitude=0,
    freqHz=0,
    offset=2.4e6)
    annotation (Placement(transformation(extent={{-162,56},{-142,76}})));
  ThermoPower3.Water.Mixer fw2(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=1,
    pstart=6800000,
    hstart=7.7e5)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-28,-52})));
  ThermoPower3.Water.Pump pumpfw2(
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.quadraticFlow (q_nom={0.5*279.15/rhop2,279.15/rhop2,1.5*279.15/rhop2}, head_nom={slop*hop2,hop2,hop2/slop}),
    n0=1000,
    V=1,
    rho0=945,
    w0=279.15,
    hstart=8e5,
    wstart=279.15,
    dp0=1000)
    annotation (Placement(transformation(extent={{-68,-64},{-88,-44}})));
  ThermoPower3.Water.Tank fwtank2(
    V0=0.1,
    hstart=9e5,
    A=0.1,
    ystart=1.028,
    pext=6700000)
    annotation (Placement(transformation(extent={{-44,-56},{-64,-36}})));
  UserInteraction.Outputs.NumericValue numericValue11(input_Value=(lpturbine.Pm +
        hpturbine.Pm)/(lpturbine.Pm + hpturbine.Pm + ppc.Condenser.Q))
    annotation (Placement(transformation(extent={{-10,-104},{10,-84}})));
equation
  expected = ms.x*ms.qf;
  out = ms.qs+ms.qc;
  connect(sourceW.flange, ms.feed) annotation (Line(
      points={{-118,40},{-82,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hpturbine.shaft_b, lpturbine.shaft_a) annotation (Line(
      points={{2.4,48},{41.4,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(lpturbine.shaft_b, constantSpeed.flange) annotation (Line(
      points={{54.4,48},{54,48},{54,46},{148,46}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hpturbine.outlet, flowSplit.in1) annotation (Line(
      points={{4,40},{10,40},{10,36},{16,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out1, lpturbine.inlet) annotation (Line(
      points={{28,40},{40,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pumpfw1.infl, fwtank1.outlet) annotation (Line(
      points={{0,-66},{8,-66}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp1.y, sourceW.in_h) annotation (Line(
      points={{-141,66},{-118,66},{-118,46},{-124,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fwtank1.inlet, fw1.out) annotation (Line(
      points={{24,-66},{24,-46},{30,-46}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.cond, fw2.in1) annotation (Line(
      points={{-72,30},{-18,30},{-18,-46},{-20,-46}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pumpfw1.outfl, fw2.in2) annotation (Line(
      points={{-14,-61},{-14,-61.5},{-20,-61.5},{-20,-58}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.steam, hpturbine.inlet) annotation (Line(
      points={{-62.2,40},{-12,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lpturbine.outlet, ppc.flangeA) annotation (Line(
      points={{56,40},{96,40},{96,8},{92.4,8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pumpfw2.infl, fwtank2.outlet) annotation (Line(
      points={{-70,-52},{-62,-52}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(fwtank2.inlet, fw2.out) annotation (Line(
      points={{-46,-52},{-38,-52}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ppc.flangeB, fw1.in2) annotation (Line(
      points={{92.4,-12},{74,-12},{74,-52},{48,-52}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out2, fw1.in1) annotation (Line(
      points={{28,32},{32,32},{32,-20},{64,-20},{64,-40},{48,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PCS_test_2;
