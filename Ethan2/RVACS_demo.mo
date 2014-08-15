within Ethan2;
model RVACS_demo
  import Ethan = Ethan2;
  parameter Modelica.SIunits.Length Dint=3.5 "Internal diameter of each tube";
  parameter Modelica.SIunits.Length Dext=3.75 "External diameter of each tube";
  parameter Modelica.SIunits.Length L = 3 "length of annulus";
  constant Real pi = Modelica.Constants.pi;
  constant Integer Nnodes = 5;
  Real decay;
  parameter Real P0 = 59e6;
  Boolean overtemp;
  parameter Modelica.SIunits.Temperature tmax = 1100+273.15;

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.Thermal.MetalTube vessel(
    rext=Dint/2,
    L=L,
    rhomcm=4000000,
    rint=Dint/2 - 0.025,
    N=Nnodes,
    lambda=25,
    Tstartbar=573.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,0})));
  Ethan.RVACS rvacs(N=Nnodes, L=L,
    Di=Dint,
    Do=Dext,
    A=6,
    height=20,
    C=0.75,
    ksi=2.1,
    Ntr=1,
    To=290.15)
    annotation (Placement(transformation(extent={{68,20},{92,50}})));
  ThermoPower3.Thermal.CounterCurrent counterCurrent(N=Nnodes) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,0})));
  ThermoPower3.Thermal.ConvHT convHT(           N=Nnodes, gamma=1000)
                                                          annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,0})));
  Ethan.Core                     core(
    Sext=L*pi*(Dint - 0.05),
    N=Nnodes,
    M=40000,
    cm=290,
    Tstartbar=573.15)        annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={-26,0})));
  UserInteraction.Outputs.NumericValue numericValue1(input_Value=rvacs.T[5] - 273.15,
      precision=2)
    annotation (Placement(transformation(extent={{70,54},{90,74}})));
  UserInteraction.Outputs.NumericValue numericValue2(input_Value=decay/1e6)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  UserInteraction.Outputs.NumericValue numericValue3(input_Value=rvacs.rvacspower/1e6)
    annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
  UserInteraction.Outputs.Bar bar(
    hideConnector=true,
    input_Value=core.Tbar - 273.15,
    min=280,
    max=1200) annotation (Placement(transformation(extent={{-116,-22},{-70,24}})));
  UserInteraction.Outputs.IndicatorLamp indicatorLamp(hideConnector=true, input_Value=
        overtemp) annotation (Placement(transformation(extent={{-90,42},{-70,62}})));
  UserInteraction.Outputs.NumericValue numericValue4(precision=1, input_Value=time/3600)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  UserInteraction.Outputs.NumericValue numericValue5(input_Value=core.Tbar - 273.15,
      precision=2)
    annotation (Placement(transformation(extent={{-94,-58},{-74,-38}})));
equation
  overtemp = if core.Tbar > tmax then true else false;
  decay = P0*0.066*(max(time,1)^(-0.02));
  core.p_in=decay;
  connect(counterCurrent.side1, vessel.ext) annotation (Line(
      points={{57,0},{43.1,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(counterCurrent.side2, rvacs.side1) annotation (Line(
      points={{63.1,-2.22045e-016},{80,-2.22045e-016},{80,21.5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(convHT.side2, vessel.int) annotation (Line(
      points={{23.1,-2.22045e-016},{26,-2.22045e-016},{26,0},{37,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(core.ext, convHT.side1) annotation (Line(
      points={{-16.7,-6.66134e-016},{10,-6.66134e-016},{10,0},{17,0}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-30,44},{-20,30}},
          lineColor={0,0,255},
          fontSize=24,
          textString="°C"),
        Text(
          extent={{90,70},{100,56}},
          lineColor={0,0,0},
          fontSize=24,
          textString="°C"),
        Text(
          extent={{-110,-26},{-58,-42}},
          lineColor={0,0,0},
          fontSize=18,
          textString="Core Avg Temp (°C)"),
        Text(
          extent={{54,82},{106,66}},
          lineColor={0,0,0},
          fontSize=18,
          textString="Exhaust Temp"),
        Text(
          extent={{-30,-34},{-14,-48}},
          lineColor={0,0,0},
          fontSize=24,
          textString="MW"),
        Text(
          extent={{90,-18},{106,-32}},
          lineColor={0,0,0},
          fontSize=24,
          textString="MW"),
        Text(
          extent={{-106,76},{-54,60}},
          lineColor={0,0,0},
          fontSize=18,
          textString="Max Temp Exceeded"),
        Text(
          extent={{-74,-42},{-64,-56}},
          lineColor={0,0,0},
          fontSize=24,
          textString="°C"),
        Text(
          extent={{12,-72},{30,-88}},
          lineColor={0,0,0},
          fontSize=18,
          textString="hours")}));
end RVACS_demo;
