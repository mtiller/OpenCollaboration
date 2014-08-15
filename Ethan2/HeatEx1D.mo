within Ethan2;
model HeatEx1D "1D Co flow heat exchanger"
  replaceable package WaterMedium = ThermoPower3.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium;
    import Modelica.SIunits;
    parameter Integer Nnodes = 2 "No. of Nodes in heat exchanger";
    parameter Integer Nt = 1 "No. of tubes in parallel";
    parameter Real L = 1 "HX length";
    parameter SIunits.Length dtube=19e-3 "Diameter of tubes";
    parameter SIunits.Length ttube=3e-3 "thickness of tubes";
    parameter SIunits.Length Dshell=0.5 "Shroud Diameter";
    parameter SIunits.ThermalConductivity lambda=17;
    parameter Boolean DynamicMomentum = false;
    constant Real pi = Modelica.Constants.pi;

    //Initialization
    parameter SIunits.Pressure pstarttube=1e5 "Pressure start value";
    parameter SIunits.SpecificEnthalpy hstarttubein=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Inlet enthalpy start value";
    parameter SIunits.SpecificEnthalpy hstarttubeout=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Outlet enthalpy start value";
    parameter SIunits.Pressure pstartshell=1e5 "Pressure start value";
    parameter SIunits.SpecificEnthalpy hstartshellin=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Inlet enthalpy start value";
    parameter SIunits.SpecificEnthalpy hstartshellout=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Outlet enthalpy start value";
  ThermoPower3.Water.FlangeA flangetin(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  ThermoPower3.Water.FlangeA flangesin(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  ThermoPower3.Water.FlangeB flangetout(redeclare package Medium =
        WaterMedium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  ThermoPower3.Water.FlangeB flangesout(redeclare package Medium =
        WaterMedium)
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}}),
        iconTransformation(extent={{-70,-110},{-50,-90}})));
  ThermoPower3.Water.Flow1DDB tubeside(
    N=Nnodes,
    wnom=1,
    e=0.001,
    DynamicMomentum=DynamicMomentum,
    Nt=Nt,
    L=L,
    A=0.25*pi*(dtube)^2,
    omega=pi*dtube,
    Dhyd=dtube,
    pstart=pstarttube,
    hstartin=hstarttubein,
    hstartout=hstarttubeout,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    dpnom=100000000)
    annotation (Placement(transformation(extent={{-18,100},{18,64}})));
  ThermoPower3.Water.Flow1DDB shellside(
    N=Nnodes,
    L=L,
    wnom=1,
    Nt=1,
    A=0.25*pi*(Dshell^2 - Nt*(dtube + 2*ttube)^2),
    omega=Nt*pi*(dtube + 2*ttube),
    Dhyd=pi*Dshell + Nt*pi*(dtube + 2*ttube),
    e=0.001,
    DynamicMomentum=DynamicMomentum,
    pstart=pstartshell,
    hstartin=hstartshellin,
    hstartout=hstartshellout,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.NoFriction,
    dpnom=1000)
    annotation (Placement(transformation(extent={{18,-104},{-18,-68}})));
  ThermoPower3.Thermal.ConvHT_htc convHT_htc(N=Nnodes)
    annotation (Placement(transformation(extent={{-20,32},{16,64}})));
  ThermoPower3.Thermal.ConvHT_htc convHT_htc1(N=Nnodes)
    annotation (Placement(transformation(extent={{-20,-34},{20,-70}})));
  ThermoPower3.Thermal.CounterCurrent counterCurrent(N=Nnodes, counterCurrent=
        false)
    annotation (Placement(transformation(extent={{-18,-28},{18,4}})));
  ThermoPower3.Thermal.MetalTube metalTube(
    N=Nnodes,
    rhomcm=5000,
    rint=dtube/2,
    rext=dtube/2 + ttube,
    lambda=lambda,
    L=L) annotation (Placement(transformation(extent={{-20,0},{18,26}})));
equation
  connect(flangetin, tubeside.infl) annotation (Line(
      points={{-100,0},{-58,0},{-58,82},{-18,82}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(tubeside.outfl, flangetout) annotation (Line(
      points={{18,82},{60,82},{60,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flangesin, shellside.infl) annotation (Line(
      points={{60,100},{42,100},{42,-86},{18,-86}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(shellside.outfl, flangesout) annotation (Line(
      points={{-18,-86},{-38,-86},{-38,-100},{-60,-100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(convHT_htc.fluidside, tubeside.wall) annotation (Line(
      points={{-2,52.8},{-2,73},{0,73}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(shellside.wall, convHT_htc1.fluidside) annotation (Line(
      points={{0,-77},{0,-57.4}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrent.side2, convHT_htc1.otherside) annotation (Line(
      points={{0,-16.96},{0,-46.6}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT_htc.otherside, metalTube.int) annotation (Line(
      points={{-2,43.2},{-2,16.9},{-1,16.9}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(metalTube.ext, counterCurrent.side1) annotation (Line(
      points={{-1,8.97},{-1,-4.515},{0,-4.515},{0,-7.2}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-100,60},{40,60},{40,100},{80,100},{80,60},{100,60},{100,-60},
              {-40,-60},{-40,-100},{-80,-100},{-80,-60},{-100,-60},{-100,60}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{-100,60},{-100,60}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{12,44},{-8,44},{-8,52},{-18,44},{-8,36},{-8,44}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-16,0},{4,0},{4,8},{14,0},{4,-8},{4,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{16,-44},{-4,-44},{-4,-36},{-14,-44},{-4,-52},{-4,-44}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}));
end HeatEx1D;
