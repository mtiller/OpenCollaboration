within Ethan2;
model PCS_test_Demo
//  Modelica.SIunits.MassFlowRate expected;
//  Modelica.SIunits.MassFlowRate out;

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
  ThermoPower3.Water.SourceW sourceW(        h=2.7e6, w0=1)
    annotation (Placement(transformation(extent={{-138,-8},{-118,12}})));
  ThermoPower3.Water.SteamTurbineStodola hpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6800000,
    Kt=0.0135)
    annotation (Placement(transformation(extent={{-48,20},{-28,0}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        3000/60*3.14159)
    annotation (Placement(transformation(extent={{70,16},{54,32}})));
  UserInteraction.Outputs.NumericValue out_power(input_Value=hpturbine.Pm/1e6)
    annotation (Placement(transformation(extent={{-46,-22},{-26,-2}})));
  ThermoPower3.Water.SteamTurbineStodola lpturbine(
    wnom=234,
    wstart=1,
    PRstart=1.1,
    eta_mech=0.98,
    eta_iso_nom=0.92,
    pnom=6.8e+16,
    Kt=0.089)
             annotation (Placement(transformation(extent={{28,20},{48,0}})));
  UserInteraction.Outputs.NumericValue out_power1(input_Value=lpturbine.Pm/
        1e6) annotation (Placement(transformation(extent={{28,-22},{48,-2}})));
  UserInteraction.Outputs.NumericValue out_power2(input_Value=lpturbine.inlet.p
        /1e5) annotation (Placement(transformation(extent={{18,18},{38,38}})));
  ThermoPower3.Water.FlowSplit flowSplit(
    allowFlowReversal=false,
    rev_in1=false,
    rev_out1=false,
    rev_out2=false,
    checkFlowDirection=false)
    annotation (Placement(transformation(extent={{2,-12},{22,8}})));

  ThermoPower3.Water.ValveLin valveLin(Kv=10)
    annotation (Placement(transformation(extent={{-76,12},{-56,-8}})));
  ThermoPower3.Water.SinkP sinkP(p0=8000)
    annotation (Placement(transformation(extent={{78,-8},{98,12}})));
  ThermoPower3.Water.SinkP sinkP1(p0=770000)
    annotation (Placement(transformation(extent={{32,-62},{52,-42}})));
  UserInteraction.Outputs.NumericValue out_power5(input_Value=hpturbine.inlet.p
        /1e5) annotation (Placement(transformation(extent={{-52,18},{-32,38}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-130,-52},{-110,-32}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0,
    duration=0,
    offset=2e6)
    annotation (Placement(transformation(extent={{-156,30},{-136,50}})));
  UserInteraction.Outputs.NumericValue out_power3(input_Value=hpturbine.w,
      hideConnector=false)
              annotation (Placement(transformation(extent={{-86,24},{-66,44}})));
  ThermoPower3.Water.SensP sensP
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  ThermoPower3.Water.ValveLin valveLin1(Kv=10)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={26,-30})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
equation
//  expected = ms.x*ms.qf;
//  out = ms.qs+ms.qc;
  connect(hpturbine.shaft_b, lpturbine.shaft_a) annotation (Line(
      points={{-31.6,10},{31.4,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(lpturbine.shaft_b, constantSpeed.flange) annotation (Line(
      points={{44.4,10},{44,10},{44,24},{54,24}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(flowSplit.out1, lpturbine.inlet) annotation (Line(
      points={{18,2},{30,2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(const.y, valveLin.cmd) annotation (Line(
      points={{-109,-42},{-78,-42},{-78,-6},{-66,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, sourceW.in_h) annotation (Line(
      points={{-135,40},{-128,40},{-128,8},{-124,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lpturbine.outlet, sinkP.flange) annotation (Line(
      points={{46,2},{78,2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hpturbine.inlet, valveLin.outlet) annotation (Line(
      points={{-46,2},{-56,2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(valveLin.inlet, sourceW.flange) annotation (Line(
      points={{-76,2},{-118,2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hpturbine.outlet, flowSplit.in1) annotation (Line(
      points={{-30,2},{-22,2},{-22,-2},{6,-2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(valveLin.inlet, sensP.flange) annotation (Line(
      points={{-76,2},{-88,2},{-88,16},{-100,16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(out_power3.Value, sensP.p) annotation (Line(
      points={{-87,34},{-90,34},{-90,26},{-92,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinkP1.flange, valveLin1.inlet) annotation (Line(
      points={{32,-52},{26,-52},{26,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(valveLin1.outlet, flowSplit.out2) annotation (Line(
      points={{26,-20},{26,-6},{18,-6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(valveLin1.cmd, const1.y) annotation (Line(
      points={{18,-30},{5,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PCS_test_Demo;
