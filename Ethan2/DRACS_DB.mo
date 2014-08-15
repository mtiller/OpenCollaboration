within Ethan2;
model DRACS_DB
  constant Real pi = Modelica.Constants.pi;
  constant Modelica.SIunits.Length dtube_core = 0.01021;
  constant Modelica.SIunits.Length dtube_dar =  0.01664;
  constant Modelica.SIunits.Length dtube_rise = 0.05;
  constant Integer Nt_dar = 250;
  constant Integer Nt_core = 664;

  parameter Modelica.SIunits.Length Dint=3.5 "Internal diameter of each tube";
  parameter Modelica.SIunits.Length Dext=3.75 "External diameter of each tube";
  parameter Modelica.SIunits.Length L = 2 "length of annulus";

  ThermoPower3.Water.Flow1DDB core(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=true,
    allowFlowReversal=false,
    L=2,
    H=2,
    A=pi*dtube_core^2/4,
    omega=pi*dtube_core,
    Dhyd=dtube_core,
    wnom=7.2,
    rhonom=800,
    Nt=Nt_core,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0.001,
    Cfnom=0.005,
    w(start=0.00333),
    hstartin=8.85e5,
    hstartout=8.87e5,
    N=3,
    dpnom=100,
    pstart=992000)  annotation (Placement(transformation(
        extent={{12,-11},{-12,11}},
        rotation=-90,
        origin={45,-70})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SourceW sourceW(
    h=1.7e6,
    w0=0.026*664,
    p0=1000000,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na)
    annotation (Placement(transformation(extent={{-2,-92},{18,-72}})));
  ThermoPower3.Water.SinkP sinkP(p0=1000000, h=1.7e6,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na)
    annotation (Placement(transformation(extent={{54,-60},{74,-40}})));
equation

  connect(sourceW.flange, core.infl) annotation (Line(
      points={{18,-82},{45,-82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sinkP.flange, core.outfl) annotation (Line(
      points={{54,-50},{50,-50},{50,-58},{45,-58}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-120,
            -100},{100,100}}, preserveAspectRatio=false), graphics));
end DRACS_DB;
