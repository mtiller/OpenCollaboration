within Ethan2;
model FHR_PCS_1 "Null implementation for FHR PCS"
  extends ORNL_AdvSMR.Interfaces.PowerConversionSystem;
  ThermoPower3.Water.SteamTurbineStodola hpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6800000,
    Kt=0.0135)
    annotation (Placement(transformation(extent={{-42,56},{-22,36}})));
  SteamDrumSeperator ms(
    Vnom=1,
    Mlstart=200,
    Mvstart=20,
    pstart=6800000)
    annotation (Placement(transformation(extent={{-70,28},{-50,48}})));
  PrePresCondenser ppc(hop=76.8)
    annotation (Placement(transformation(extent={{54,-14},{74,6}})));
  ThermoPower3.Water.SteamTurbineStodola lpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6.8e+16,
    Kt=0.089)
             annotation (Placement(transformation(extent={{10,56},{30,36}})));
  ThermoPower3.Water.Mixer fw1(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=1,
    hstart=6e5,
    allowFlowReversal=false,
    pstart=6800000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={48,-56})));
  ThermoPower3.Water.FlowSplit flowSplit
    annotation (Placement(transformation(extent={{-16,24},{4,44}})));
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
    annotation (Placement(transformation(extent={{10,-88},{-10,-68}})));
  ThermoPower3.Water.Tank fwtank1(
    A=1,
    V0=0.1,
    hstart=5e5,
    pext=690000,
    ystart=7.099)
    annotation (Placement(transformation(extent={{34,-80},{14,-60}})));
  ThermoPower3.Water.Mixer fw2(
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    V=1,
    pstart=6800000,
    hstart=7.7e5)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-18,-18})));
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
    annotation (Placement(transformation(extent={{-60,-74},{-80,-54}})));
  ThermoPower3.Water.Tank fwtank2(
    V0=0.1,
    hstart=9e5,
    A=0.1,
    ystart=1.028,
    pext=6700000)
    annotation (Placement(transformation(extent={{-34,-22},{-54,-2}})));
equation
  connect(hpturbine.shaft_b,lpturbine. shaft_a) annotation (Line(
      points={{-25.6,46},{13.4,46}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hpturbine.outlet,flowSplit. in1) annotation (Line(
      points={{-24,38},{-18,38},{-18,34},{-12,34}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out1,lpturbine. inlet) annotation (Line(
      points={{0,38},{12,38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pumpfw1.infl,fwtank1. outlet) annotation (Line(
      points={{8,-76},{16,-76}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(fwtank1.inlet,fw1. out) annotation (Line(
      points={{32,-76},{32,-56},{38,-56}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.cond,fw2. in1) annotation (Line(
      points={{-60,28},{-8,28},{-8,-12},{-10,-12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pumpfw1.outfl,fw2. in2) annotation (Line(
      points={{-6,-71},{-6,-71.5},{-10,-71.5},{-10,-24}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.steam,hpturbine. inlet) annotation (Line(
      points={{-50.2,38},{-40,38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lpturbine.outlet,ppc. flangeA) annotation (Line(
      points={{28,38},{68,38},{68,6},{64.4,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pumpfw2.infl,fwtank2. outlet) annotation (Line(
      points={{-62,-62},{-56,-62},{-56,-18},{-52,-18}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(fwtank2.inlet,fw2. out) annotation (Line(
      points={{-36,-18},{-28,-18}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ppc.flangeB, fw1.in2) annotation (Line(
      points={{64.4,-14},{66,-14},{66,-62},{56,-62}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowSplit.out2, fw1.in1) annotation (Line(
      points={{0,30},{24,30},{24,-28},{56,-28},{56,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ms.feed, steamInlet) annotation (Line(
      points={{-70,38},{-70,60},{-100,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lpturbine.shaft_b, rotorShaft) annotation (Line(
      points={{26.4,46},{100,46},{100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pumpfw2.outfl, condensateReturn) annotation (Line(
      points={{-76,-57},{-88,-57},{-88,-60},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics));
end FHR_PCS_1;
