within Ethan2;
model PCS_test_loop
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
    annotation (Placement(transformation(extent={{90,48},{74,64}})));
  SteamDrumSeperator ms(
    Vnom=1,
    Mlstart=200,
    Mvstart=20,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  UserInteraction.Outputs.NumericValue out_power(input_Value=hpturbine.Pm/1e6)
    annotation (Placement(transformation(extent={{-14,16},{6,36}})));
  PrePresCondenser ppc(hop=76.8)
    annotation (Placement(transformation(extent={{86,-8},{106,12}})));
  UserInteraction.Outputs.NumericValue numericValue1(input_Value=ppc.Condenser.Q
        /1e6)
    annotation (Placement(transformation(extent={{108,-8},{128,12}})));
  UserInteraction.Outputs.NumericValue numericValue3(input_Value=ms.conserve/
        1e6)
    annotation (Placement(transformation(extent={{-52,52},{-32,72}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=ms.p/1e5)
    annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
  UserInteraction.Outputs.NumericValue numericValue4(input_Value=ms.steam.p/
        1e5)
    annotation (Placement(transformation(extent={{-20,56},{0,76}})));
  ThermoPower3.Water.SteamTurbineStodola lpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6.8e+16,
    Kt=0.089)
             annotation (Placement(transformation(extent={{38,58},{58,38}})));
  UserInteraction.Outputs.NumericValue out_power1(input_Value=lpturbine.Pm/
        1e6) annotation (Placement(transformation(extent={{38,16},{58,36}})));
  UserInteraction.Outputs.NumericValue out_power2(input_Value=hpturbine.outlet.p
        /1e5) annotation (Placement(transformation(extent={{28,56},{48,76}})));
  ThermoPower3.Water.Mixer fw1(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    hstart=1e5,
    V=1,
    pstart=6800000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-46})));
  ThermoPower3.Water.FlowSplit flowSplit
    annotation (Placement(transformation(extent={{12,26},{32,46}})));
  ThermoPower3.Water.SensW sensW
    annotation (Placement(transformation(extent={{-56,-42},{-76,-22}})));
  ThermoPower3.Water.SensW sensW1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={26,2})));
  ThermoPower3.Water.SensW sensW2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={100,-26})));
  UserInteraction.Outputs.NumericValue numericValue5(input_Value=ms.p/1e5,
      hideConnector=false)
    annotation (Placement(transformation(extent={{-90,-2},{-110,18}})));
  UserInteraction.Outputs.NumericValue numericValue6(input_Value=ms.p/1e5,
      hideConnector=false)
    annotation (Placement(transformation(extent={{18,-26},{-2,-6}})));
  UserInteraction.Outputs.NumericValue numericValue7(input_Value=ms.p/1e5,
      hideConnector=false)
    annotation (Placement(transformation(extent={{114,-62},{134,-42}})));
  ThermoPower3.Water.Pump pump(
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.quadraticFlow (q_nom={0.5*qop,qop,2*qop},
          head_nom={slop*hop,hop,hop/slop}),
    n0=1000,
    V=10,
    rho0=998,
    wstart=9,
    w0=210,
    hstart=5e5,
    dp0=6100000)                   annotation (Placement(transformation(extent={{2,-78},
            {-18,-58}})));
  ThermoPower3.Water.Tank tank(
    A=1,
    V0=0.1,
    hstart=5e5,
    ystart=5.6925,
    pext=720000)
    annotation (Placement(transformation(extent={{26,-70},{6,-50}})));
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
equation
  expected = ms.x*ms.qf;
  out = ms.qs+ms.qc;
  connect(ms.steam, hpturbine.inlet) annotation (Line(
      points={{-32.2,40},{-12,40}},
      color={0,0,255},
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
  connect(hpturbine.outlet, flowSplit.in1) annotation (Line(
      points={{4,40},{10,40},{10,36},{16,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out1, lpturbine.inlet) annotation (Line(
      points={{28,40},{40,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out2, sensW1.inlet) annotation (Line(
      points={{28,32},{30,32},{30,8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensW1.outlet, fw1.in1) annotation (Line(
      points={{30,-4},{30,-26},{48,-26},{48,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ppc.flangeB, sensW2.inlet) annotation (Line(
      points={{96.4,-8},{96,-8},{96,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensW2.outlet, fw1.in2) annotation (Line(
      points={{96,-32},{96,-52},{48,-52}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue5.Value, sensW.w) annotation (Line(
      points={{-89,8},{-80,8},{-80,-26},{-74,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue6.Value, sensW1.w) annotation (Line(
      points={{19,-16},{20,-16},{20,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue7.Value, sensW2.w) annotation (Line(
      points={{113,-52},{106,-52},{106,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.infl,tank. outlet) annotation (Line(
      points={{0,-66},{8,-66}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tank.inlet, fw1.out) annotation (Line(
      points={{24,-66},{24,-46},{30,-46}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.cond, fw2.in1) annotation (Line(
      points={{-42,30},{-24,30},{-24,-30},{-30,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensW.inlet, fw2.out) annotation (Line(
      points={{-60,-36},{-48,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump.outfl, fw2.in2) annotation (Line(
      points={{-14,-61},{-14,-61.5},{-30,-61.5},{-30,-42}},
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PCS_test_loop;
