within Ethan2;
model PCS_Demo
  Modelica.SIunits.MassFlowRate expected;
   Modelica.SIunits.MassFlowRate out;
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.ThroughW sourceW(w0=279.15)
    annotation (Placement(transformation(extent={{-98,30},{-78,50}})));
  ThermoPower3.Water.SteamTurbineStodola turbine(
    wnom=234,
    Kt=0.01132,
    wstart=1,
    PRstart=1.1,
    pnom=6800000,
    eta_mech=0.98,
    eta_iso_nom=0.92)
    annotation (Placement(transformation(extent={{16,22},{36,42}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        3000/60*3.14159)
    annotation (Placement(transformation(extent={{82,12},{66,28}})));
  SteamDrumSeperator ms(
    Vnom=1,
    Mlstart=200,
    Mvstart=20,
    pstart=50000)
    annotation (Placement(transformation(extent={{-26,30},{-6,50}})));
  UserInteraction.Outputs.NumericValue out_power(input_Value=turbine.Pm/1e6)
    annotation (Placement(transformation(extent={{16,6},{36,26}})));
  PrePresCondenser ppc
    annotation (Placement(transformation(extent={{86,-8},{106,12}})));
  ThermoPower3.Water.Mixer mixer(
    V=10,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid,
    pstart=6800000,
    hstart=2e6)
    annotation (Placement(transformation(extent={{2,-46},{-18,-26}})));
  ThermoPower3.Water.Flow1D sg(
    L=1,
    wnom=10,
    N=5,
    Kfnom=0.005,
    rhonom=1000,
    Cfnom=0.005,
    A=0.0125,
    omega=0.0125,
    Dhyd=0.008,
    e=0.1,
    Nt=100,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    dpnom=100,
    pstart=6800000,
    hstartin=2.2e6,
    hstartout=2.2e6)
    annotation (Placement(transformation(extent={{-44,-46},{-64,-26}})));
  ThermoPower3.Thermal.ConvHT convHT(N=5, gamma=1000)
    annotation (Placement(transformation(extent={{-64,-26},{-44,-6}})));
  ThermoPower3.Thermal.HeatSource1D heatSource1D(
    N=5,
    Nt=100,
    L=1,
    omega=0.0125)
    annotation (Placement(transformation(extent={{-64,-8},{-44,12}})));
  UserInteraction.Outputs.NumericValue numericValue1(input_Value=ppc.Condenser.Q
        /1e6)
    annotation (Placement(transformation(extent={{108,-8},{128,12}})));
  UserInteraction.Outputs.NumericValue in_power(input_Value=(sg.h[5]*sg.outfl.m_flow
         + sg.h[1]*sg.infl.m_flow)/1e6)
    annotation (Placement(transformation(extent={{-64,-62},{-44,-42}})));
  UserInteraction.Outputs.NumericValue numericValue3(input_Value=ms.conserve)
    annotation (Placement(transformation(extent={{-26,44},{-6,64}})));
  UserInteraction.Outputs.NumericValue numericValue4(input_Value=-(100*(
        out_power.y/in_power.y)))
    annotation (Placement(transformation(extent={{-10,-104},{10,-84}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=10,
    height=0,
    duration=0,
    offset=450e6)
    annotation (Placement(transformation(extent={{-98,6},{-78,26}})));
equation
  expected = ms.x*ms.qf;
  out = ms.qs+ms.qc;
  connect(constantSpeed.flange, turbine.shaft_b) annotation (Line(
      points={{66,20},{52,20},{52,32},{32.4,32}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(ms.steam, turbine.inlet) annotation (Line(
      points={{-6.2,40},{18,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(turbine.outlet, ppc.flangeA) annotation (Line(
      points={{34,40},{96.4,40},{96.4,12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.in1, ms.cond) annotation (Line(
      points={{0,-30},{6,-30},{6,30},{-16,30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.in2, ppc.flangeB) annotation (Line(
      points={{0,-42},{96,-42},{96,-8},{96.4,-8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sg.infl, mixer.out) annotation (Line(
      points={{-44,-36},{-18,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(convHT.side2, sg.wall) annotation (Line(
      points={{-54,-19.1},{-54,-31}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(heatSource1D.wall, convHT.side1) annotation (Line(
      points={{-54,-1},{-54,-13}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(sourceW.inlet, sg.outfl) annotation (Line(
      points={{-98,40},{-112,40},{-112,-36},{-64,-36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sourceW.outlet, ms.feed) annotation (Line(
      points={{-78,40},{-26,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp.y, heatSource1D.power) annotation (Line(
      points={{-77,16},{-64,16},{-64,6},{-54,6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PCS_Demo;
