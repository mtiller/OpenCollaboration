within Ethan2;
model DRACS_2
  constant Real pi = Modelica.Constants.pi;
  constant Modelica.SIunits.Length dtube_core = 0.01021;
  constant Modelica.SIunits.Length dtube_dar =  0.01664;
  constant Modelica.SIunits.Length dtube_rise = 0.05;
  constant Integer Nt_dar = 120;
  constant Integer Nt_core = 664;
  Modelica.SIunits.Temperature looptemp[12];
  parameter Modelica.SIunits.Length Dint=3.5 "Internal diameter of each tube";
  parameter Modelica.SIunits.Length Dext=3.75 "External diameter of each tube";
  parameter Modelica.SIunits.Length L = 2 "length of annulus";
  Modelica.SIunits.Power powercore "power from core";
  Modelica.SIunits.Power powerdar "power to radiator";
  Modelica.SIunits.Power dummy "power to radiator";
  parameter Integer parallel = 3;

  ThermoPower3.Water.Flow1D   core(
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
    dpnom=100,
    pstart=992000,
    N=3)            annotation (Placement(transformation(
        extent={{12,-11},{-12,11}},
        rotation=-90,
        origin={45,-70})));
  ThermoPower3.Water.Flow1D   dAR(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=true,
    allowFlowReversal=false,
    rhonom=800,
    L=2,
    H=-2,
    A=dtube_dar^2*0.25*pi,
    omega=dtube_dar^2*pi,
    Dhyd=dtube_dar,
    wnom=7.2,
    Nt=Nt_dar,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0.001,
    Cfnom=0.001,
    w(start=0.0396),
    hstartin=8.87e5,
    hstartout=8.86e5,
    N=3,
    dpnom=100,
    pstart=959140)  annotation (Placement(transformation(
        extent={{12,-10},{-12,10}},
        rotation=90,
        origin={-24,68})));
  ThermoPower3.Water.Flow1D riser(
    Nt=1,
    L=6,
    H=6,
    A=pi*dtube_rise^2/4,
    omega=pi*dtube_rise,
    wnom=7.2,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=true,
    allowFlowReversal=false,
    rhonom=800,
    Dhyd=dtube_rise,
    Kfnom=0.001,
    Cfnom=0.005,
    w(start=2.2167),
    hstartin=8.87e5,
    hstartout=8.87e5,
    N=3,
    dpnom=100,
    pstart=94200000000)
                    annotation (Placement(transformation(
        extent={{28,-11},{-28,11}},
        rotation=270,
        origin={45,-10})));
  ThermoPower3.Water.Flow1D downcomer(
    Nt=1,
    L=6,
    A=pi*dtube_rise^2/4,
    omega=pi*dtube_rise,
    wnom=7.2,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=true,
    allowFlowReversal=false,
    H=-6,
    rhonom=800,
    Dhyd=dtube_rise,
    Kfnom=0.001,
    Cfnom=0.005,
    w(start=2.2167),
    hstartin=8.86e5,
    hstartout=8.86e5,
    N=3,
    pstart=1095300,
    dpnom=100)      annotation (Placement(transformation(
        extent={{-29,12},{29,-12}},
        rotation=270,
        origin={-24,-13})));
  ConvHT_multiple             convHT_core(                gamma=2.7e4, N=3,
    Np=parallel)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={66,-70})));
  ThermoPower3.Water.Tank tank(
    A=0.1,
    V0=0.1,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    ystart=1.13457,
    hstart=8.85e5,
    pext=1000000)
    annotation (Placement(transformation(extent={{-12,-86},{8,-66}})));
  ThermoPower3.Thermal.MetalTube darwall(
    lambda=25,
    rhomcm=4000,
    rext=0.01995/2,
    rint=dtube_dar/2,
    L=2,
    WallRes=false,
    N=3,
    Tstartbar=623.15)
         annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-64,68})));
  ThermoPower3.Thermal.DHT dHT(N=3)
    annotation (Placement(transformation(extent={{78,-100},{100,-40}})));
  ThermoPower3.Thermal.ConvHT convHT_DAR1(            N=3, gamma=20000)
                                                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,68})));
  RVACS rVACS(
    N=3,
    Ntr=Nt_dar,
    Do=0.7,
    ksi=10) annotation (Placement(transformation(extent={{-114,70},{-90,96}})));
equation
  looptemp = cat(1,core.T,riser.T,dAR.T,downcomer.T);
  powercore = Nt_core*core.A*(core.u[3]*core.rho[3]*core.h[3] - core.u[1]*core.rho[1]*core.h[1]);
  powerdar = dAR.A*Nt_dar*(dAR.u[1]*dAR.rho[1]*dAR.h[1] - dAR.u[3]*dAR.rho[3]*dAR.h[3]);
  -dummy = dAR.Q;
  connect(core.outfl, riser.infl) annotation (Line(
      points={{45,-58},{45,-38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(downcomer.infl, dAR.outfl) annotation (Line(
      points={{-24,16},{-24,56}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(core.infl, tank.outlet) annotation (Line(
      points={{45,-82},{6,-82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tank.inlet, downcomer.outfl) annotation (Line(
      points={{-10,-82},{-24,-82},{-24,-42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(riser.outfl, dAR.infl) annotation (Line(
      points={{45,18},{45,80},{-24,80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(darwall.int, convHT_DAR1.side1) annotation (Line(
      points={{-61,68},{-53,68}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_DAR1.side2, dAR.wall) annotation (Line(
      points={{-46.9,68},{-29,68}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(rVACS.side1, darwall.ext) annotation (Line(
      points={{-102,71.3},{-84,71.3},{-84,68},{-67.1,68}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(core.wall, convHT_core.side2) annotation (Line(
      points={{50.5,-70},{62.9,-70}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_core.side1, dHT) annotation (Line(
      points={{69,-70},{89,-70}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-120,
            -100},{100,100}}, preserveAspectRatio=false), graphics));
end DRACS_2;
