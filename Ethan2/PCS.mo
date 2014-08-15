within Ethan2;
model PCS "PowerConversionSystem"
  parameter Modelica.SIunits.MassFlowRate wnom=234.538 "coolant flowrate";
  constant Real pi = Modelica.Constants.pi;

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SteamTurbineStodola turbine(
    wstart=wnom,
    wnom=wnom,
    PRstart=68,
    Kt=0.0152,
    pnom=6800000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        3000/60*3.14159)
    annotation (Placement(transformation(extent={{46,-24},{30,-8}})));
  ThermoPower3.Water.SensT sensT
    annotation (Placement(transformation(extent={{24,2},{44,22}})));
  UserInteraction.Outputs.NumericValue numericValue1(
                                                    input_Value=turbine.w,
      hideConnector=false)
    annotation (Placement(transformation(extent={{50,44},{70,64}})));
  UserInteraction.Outputs.NumericValue numericValue2(
                                                    input_Value=turbine.w,
      hideConnector=false)
    annotation (Placement(transformation(extent={{0,64},{20,84}})));
  ThermoPower3.Water.SensT sensT1
    annotation (Placement(transformation(extent={{-32,2},{-12,22}})));
  HeatEx1D heatEx1D(
    hstarttubein=2e5,
    hstarttubeout=2e5,
    Dshell=0.75,
    Nnodes=8,
    Nt=700,
    L=5,
    pstarttube=6800000,
    pstartshell=6800000,
    hstartshellin=1e6,
    hstartshellout=1e6)
    annotation (Placement(transformation(extent={{46,-68},{26,-48}})));
  PrePresCondenser prePresCondenser
    annotation (Placement(transformation(extent={{74,-24},{94,-4}})));
  ThermoPower3.Water.FlangeA flangeA
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  ThermoPower3.Water.Mixer mixer(
    V=10,
    FluidPhaseStart=ThermoPower3.Choices.FluidPhase.FluidPhases.TwoPhases,
    hstart=1e6,
    pstart=6800000)
    annotation (Placement(transformation(extent={{12,-74},{-8,-54}})));
  ThermoPower3.Water.FlangeB flangeB
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  SteamSeperator steamSeperator(
    Vt=10,
    pstart=6800000,
    Vlstart=1)
    annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
  ThermoPower3.Water.ThroughW throughW(w0=279.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,52})));
equation
  connect(constantSpeed.flange, turbine.shaft_b) annotation (Line(
      points={{30,-16},{12,-16},{12,0},{6.4,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sensT.inlet, turbine.outlet) annotation (Line(
      points={{28,8},{8,8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue1.Value, sensT.T) annotation (Line(
      points={{49,54},{46,54},{46,18},{42,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(numericValue2.Value, sensT1.T) annotation (Line(
      points={{-1,74},{-6,74},{-6,18},{-14,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensT1.outlet, turbine.inlet) annotation (Line(
      points={{-16,8},{-8,8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensT.outlet, prePresCondenser.flangeA) annotation (Line(
      points={{40,8},{84,8},{84.4,-4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(prePresCondenser.flangeB, heatEx1D.flangetin) annotation (Line(
      points={{84.4,-24},{84,-24},{84,-58},{46,-58}},
      color={0,0,255},
      smooth=Smooth.None));

  connect(heatEx1D.flangesout, mixer.in2) annotation (Line(
      points={{42,-68},{20,-68},{20,-70},{10,-70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(heatEx1D.flangetout, mixer.in1) annotation (Line(
      points={{26,-58},{10,-58}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(steamSeperator.steam, sensT1.inlet) annotation (Line(
      points={{-40.2,8},{-28,8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(steamSeperator.cond, heatEx1D.flangesin) annotation (Line(
      points={{-50,-2},{-10,-2},{-10,-48},{30,-48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer.out, flangeB) annotation (Line(
      points={{-8,-64},{-52,-64},{-52,-100},{-100,-100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flangeA, flangeA) annotation (Line(
      points={{-100,100},{-100,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(steamSeperator.feed, throughW.outlet) annotation (Line(
      points={{-60,8},{-80,8},{-80,42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(throughW.inlet, flangeA) annotation (Line(
      points={{-80,62},{-80,100},{-100,100}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end PCS;
