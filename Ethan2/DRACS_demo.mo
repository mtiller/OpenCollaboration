within Ethan2;
model DRACS_demo
  constant Real pi = Modelica.Constants.pi;
  constant Modelica.SIunits.Length dtube_core = 0.01021;
  constant Modelica.SIunits.Length dtube_dar =  0.01664;
  constant Modelica.SIunits.Length dtube_rise = 0.2;
  constant Integer Nt_dar = 56;
  constant Integer Nt_core = 664;
  Modelica.SIunits.Temperature looptemp[28];
  Modelica.SIunits.Velocity loopspeed[28];

  ThermoPower3.Water.Flow1D   core(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=true,
    allowFlowReversal=false,
    hstartin=8e5,
    hstartout=8e5,
    L=2,
    H=2,
    A=pi*dtube_core^2/4,
    omega=pi*dtube_core,
    Dhyd=dtube_core,
    wnom=7.2,
    rhonom=800,
    Nt=Nt_core,
    N=9,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0.001,
    Cfnom=0.005,
    dpnom=100,
    pstart=1000000) annotation (Placement(transformation(
        extent={{12,-11},{-12,11}},
        rotation=-90,
        origin={45,-70})));
  ThermoPower3.Water.Flow1D   dAR(
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    DynamicMomentum=true,
    allowFlowReversal=false,
    hstartin=8e5,
    hstartout=8e5,
    rhonom=800,
    L=2,
    H=-2,
    A=dtube_dar^2*0.25*pi,
    omega=dtube_dar^2*pi,
    Dhyd=dtube_dar,
    wnom=7.2,
    Nt=Nt_dar,
    N=9,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0.001,
    Cfnom=0.001,
    dpnom=100,
    pstart=1000000) annotation (Placement(transformation(
        extent={{12,-10},{-12,10}},
        rotation=90,
        origin={-24,66})));
  ThermoPower3.Water.Flow1D riser(
    Nt=1,
    L=6,
    H=6,
    A=pi*dtube_rise^2/4,
    omega=pi*dtube_rise,
    wnom=7.2,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    N=5,
    DynamicMomentum=true,
    allowFlowReversal=false,
    hstartin=8e5,
    hstartout=8e5,
    rhonom=800,
    Dhyd=dtube_rise,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0.001,
    Cfnom=0.005,
    dpnom=100,
    pstart=1000000) annotation (Placement(transformation(
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
    N=5,
    DynamicMomentum=true,
    allowFlowReversal=false,
    hstartin=8e5,
    hstartout=8e5,
    H=-6,
    rhonom=800,
    Dhyd=dtube_rise,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    Kfnom=0.001,
    Cfnom=0.005,
    dpnom=100,
    pstart=1000000) annotation (Placement(transformation(
        extent={{-29,12},{29,-12}},
        rotation=270,
        origin={-24,-13})));
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Water.SensP sensP(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na)
    annotation (Placement(transformation(extent={{56,-50},{76,-30}})));
  UserInteraction.Outputs.NumericValue numericValue(hideConnector=false)
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  ThermoPower3.Thermal.ConvHT convHT_core(gamma=650, N=9)
    annotation (Placement(transformation(extent={{108,-74},{128,-54}})));
  ThermoPower3.Thermal.TempSource1D tempsource_core(N=9)
    annotation (Placement(transformation(extent={{108,-46},{128,-26}})));
  Modelica.Blocks.Sources.Ramp dracstemp(
    duration=20,
    startTime=30,
    offset=673.15,
    height=200)
    annotation (Placement(transformation(extent={{154,-30},{134,-10}})));
  ThermoPower3.Thermal.ConvHT convHT_DAR(N=9, gamma=1650) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,84})));
  ThermoPower3.Thermal.TempSource1D tempsource_dar(N=9) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-72,84})));
  Modelica.Blocks.Sources.Ramp dartemp(
    duration=20,
    offset=320,
    height=-80,
    startTime=300)
    annotation (Placement(transformation(extent={{-110,74},{-90,94}})));
  ThermoPower3.Water.Tank tank(
    A=0.1,
    V0=0.1,
    ystart=1,
    hstart=8e5,
    redeclare package Medium = ORNL_AdvSMR.Media.Fluids.Na,
    pext=1000000)
    annotation (Placement(transformation(extent={{-12,-86},{8,-66}})));
  ThermoPower3.Water.SensP sensP3(redeclare package Medium =
        ORNL_AdvSMR.Media.Fluids.Na)
    annotation (Placement(transformation(extent={{50,-102},{70,-82}})));
  UserInteraction.Outputs.NumericValue numericValue6(hideConnector=false)
    annotation (Placement(transformation(extent={{74,-92},{94,-72}})));
  UserInteraction.Outputs.SpatialPlot spatialPlot(
    x=linspace(
        1,
        28,
        28),
    y=looptemp,
    maxX=28,
    minY=520,
    maxY=900)
    annotation (Placement(transformation(extent={{-160,-94},{-36,72}})));
  UserInteraction.Outputs.NumericValue numericValue1(input_Value=core.u[1])
    annotation (Placement(transformation(extent={{0,16},{20,36}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=dartemp.y)
    annotation (Placement(transformation(extent={{-136,72},{-116,92}})));
  UserInteraction.Outputs.NumericValue numericValue3(input_Value=dracstemp.y)
    annotation (Placement(transformation(extent={{106,-16},{126,4}})));
equation
  looptemp = cat(1,core.T,riser.T,dAR.T,downcomer.T);
  loopspeed = cat(1,core.u,riser.u,dAR.u,downcomer.u);
  connect(core.outfl, riser.infl) annotation (Line(
      points={{45,-58},{45,-38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(downcomer.infl, dAR.outfl) annotation (Line(
      points={{-24,16},{-24,54}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensP.flange, riser.infl) annotation (Line(
      points={{66,-44},{50,-44},{50,-50},{45,-50},{45,-38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue.Value, sensP.p) annotation (Line(
      points={{79,-30},{76,-30},{76,-34},{74,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(convHT_core.side2, core.wall) annotation (Line(
      points={{118,-67.1},{86,-67.1},{86,-70},{50.5,-70}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(tempsource_core.wall, convHT_core.side1) annotation (Line(
      points={{118,-39},{118,-61}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(dracstemp.y, tempsource_core.temperature) annotation (Line(
      points={{133,-20},{126,-20},{126,-32},{118,-32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempsource_dar.wall, convHT_DAR.side1) annotation (Line(
      points={{-69,84},{-53,84}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(dartemp.y, tempsource_dar.temperature) annotation (Line(
      points={{-89,84},{-76,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(convHT_DAR.side2, dAR.wall) annotation (Line(
      points={{-46.9,84},{-38,84},{-38,66},{-29,66}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(core.infl, tank.outlet) annotation (Line(
      points={{45,-82},{6,-82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tank.inlet, downcomer.outfl) annotation (Line(
      points={{-10,-82},{-24,-82},{-24,-42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(numericValue6.Value, sensP3.p) annotation (Line(
      points={{73,-82},{70,-82},{70,-86},{68,-86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensP3.flange, tank.outlet) annotation (Line(
      points={{60,-96},{30,-96},{30,-82},{6,-82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(riser.outfl, dAR.infl) annotation (Line(
      points={{45,18},{45,78},{-24,78}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={
            {-160,-100},{100,100}})));
end DRACS_demo;
