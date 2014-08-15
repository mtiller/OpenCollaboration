within Ethan2;
model SandboxII
  parameter Modelica.SIunits.MassFlowRate wnom=173 "coolant flowrate";
  constant Real pi = Modelica.Constants.pi;
  parameter Real wop = 100 "nominal mass flow";
  Real rhop = 998 "nominal density";
  Real qop = wop/rhop;
  parameter Real dop = 61 "nominal pressure increase (bar)";
  Real hop = (dop*1e5)/(rhop*9.81);

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.Pump pump(
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.quadraticFlow (q_nom={0.5*qop,qop,2*qop},
          head_nom={1.1*hop,hop,hop/1.1}),
    n0=1000,
    V=10,
    rho0=998,
    wstart=9,
    w0=210,
    dp0=6100000)                   annotation (Placement(transformation(extent={{-10,-12},
            {10,8}})));
  ThermoPower3.Water.SourceP sourceP(p0=700000)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  ThermoPower3.Water.SinkP sinkP(p0=6800000)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  ThermoPower3.Water.Header header(
    V=0.1,
    hstart=1e5,
    pstart=700000)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermoPower3.Water.Header header1(
    V=0.1,
    hstart=1e5,
    pstart=6800000)
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  ThermoPower3.Water.Tank tank(
    A=1,
    V0=0.1,
    ystart=0.1,
    pext=680000,
    hstart=1e5)
    annotation (Placement(transformation(extent={{-34,-4},{-14,16}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=7e4,
    duration=10,
    offset=7e5,
    startTime=10)
    annotation (Placement(transformation(extent={{-148,22},{-128,42}})));
equation
  connect(header.inlet, sourceP.flange) annotation (Line(
      points={{-60.1,0},{-80,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump.outfl, header1.inlet) annotation (Line(
      points={{6,5},{20,5},{20,0},{23.9,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(header1.outlet, sinkP.flange) annotation (Line(
      points={{44,0},{60,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump.infl, tank.outlet) annotation (Line(
      points={{-8,0},{-16,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tank.inlet, header.outlet) annotation (Line(
      points={{-32,0},{-40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ramp.y, sourceP.in_p0) annotation (Line(
      points={{-127,32},{-110,32},{-110,9.2},{-94,9.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics));
end SandboxII;
