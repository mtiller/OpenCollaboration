within ORNL_AdvSMR.PowerSystems.HeatExchangers;
model HXGas2Liquid_FEM
  "Counter-flow heat exchanger using the finite element method"
  package Medium = Modelica.Media.Water.WaterIF97OnePhase_ph;

  replaceable package shellMedium = Modelica.Media.Water.WaterIF97OnePhase_ph
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  replaceable package tubeMedium = Modelica.Media.Water.WaterIF97OnePhase_ph
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  // number of Nodes
  parameter Integer Nnodes=20;
  // total length
  parameter Modelica.SIunits.Length Lhex=200;
  // internal diameter
  parameter Modelica.SIunits.Diameter Dihex=0.02;
  // internal radius
  parameter Modelica.SIunits.Radius rhex=Dihex/2;
  // internal perimeter
  parameter Modelica.SIunits.Length omegahex=Modelica.Constants.pi*Dihex;
  // internal cross section
  parameter Modelica.SIunits.Area Ahex=Modelica.Constants.pi*rhex^2;
  // friction coefficient
  parameter Real Cfhex=0.005;
  // nominal (and initial) mass flow rate
  parameter Modelica.SIunits.MassFlowRate whex=0.31;
  // initial pressure
  parameter Modelica.SIunits.Pressure phex=3e5;
  // initial inlet specific enthalpy
  parameter Modelica.SIunits.SpecificEnthalpy hinhex=1e5;
  // initial outlet specific enthalpy
  parameter Modelica.SIunits.SpecificEnthalpy houthex=1e5;

  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{90,80},{110,100}})));
  ThermoPower3.Water.Flow1Dfem shell(
    redeclare package Medium = shellMedium,
    N=Nnodes,
    Nt=1,
    L=Lhex,
    omega=omegahex,
    Dhyd=Dihex,
    A=Ahex,
    wnom=whex,
    Cfnom=Cfhex,
    hstartin=hinhex,
    hstartout=houthex,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    HydraulicCapacitance=ThermoPower3.Choices.Flow1D.HCtypes.Downstream,
    dpnom=10000) annotation (Placement(transformation(extent={{-20,-80},{20,-40}},
          rotation=0)));
  ThermoPower3.Thermal.ConvHT ConvHTc1(N=Nnodes, gamma=400) annotation (
      Placement(transformation(extent={{-20,20},{20,40}},rotation=0)));
  ThermoPower3.Thermal.ConvHT ConvHTe1(N=Nnodes, gamma=400) annotation (
      Placement(transformation(extent={{-20,-40},{20,-20}},rotation=0)));
  ThermoPower3.Water.Flow1Dfem tube(
    redeclare package Medium = tubeMedium,
    N=Nnodes,
    L=Lhex,
    omega=omegahex,
    Dhyd=Dihex,
    A=Ahex,
    wnom=whex,
    Cfnom=Cfhex,
    hstartin=hinhex,
    hstartout=houthex,
    FFtype=ThermoPower3.Choices.Flow1D.FFtypes.Cfnom,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState,
    HydraulicCapacitance=ThermoPower3.Choices.Flow1D.HCtypes.Downstream,
    dpnom=10000) annotation (Placement(transformation(extent={{20,80},{-20,40}},
          rotation=0)));
  ThermoPower3.Thermal.MetalTube MetalWall(
    N=Nnodes,
    L=Lhex,
    lambda=20,
    rint=rhex,
    rext=rhex + 1e-3,
    rhomcm=4.9e6,
    Tstart1=297,
    TstartN=297,
    initOpt=ThermoPower3.Choices.Init.Options.steadyState) annotation (
      Placement(transformation(extent={{-20,0},{20,-20}}, rotation=0)));
  ThermoPower3.Water.SensT SensT_A_in(redeclare package Medium = shellMedium)
    annotation (Placement(transformation(extent={{-70,-66},{-50,-46}}, rotation
          =0)));
  ThermoPower3.Water.SensT SensT_B_in(redeclare package Medium = tubeMedium)
    annotation (Placement(transformation(extent={{70,54},{50,74}}, rotation=0)));
  ThermoPower3.Water.SensT SensT_A_out(redeclare package Medium = shellMedium)
    annotation (Placement(transformation(extent={{50,-66},{70,-46}}, rotation=0)));
  ThermoPower3.Water.SensT SensT_B_out(redeclare package Medium = tubeMedium)
    annotation (Placement(transformation(extent={{-50,54},{-70,74}}, rotation=0)));
  ThermoPower3.Thermal.CounterCurrent CounterCurrent1(N=Nnodes) annotation (
      Placement(transformation(extent={{-20,0},{20,20}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a tubeInlet(redeclare package Medium =
        tubeMedium) annotation (Placement(transformation(extent={{-110,50},{-90,
            70}}), iconTransformation(extent={{-85,80},{-65,100}})));
  Modelica.Fluid.Interfaces.FluidPort_a shellInlet(redeclare package Medium =
        shellMedium) annotation (Placement(transformation(extent={{-110,-70},{-90,
            -50}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b tubeOutlet(redeclare package Medium =
        tubeMedium) annotation (Placement(transformation(extent={{90,50},{110,
            70}}), iconTransformation(extent={{65,80},{85,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b shellOutlet(redeclare package Medium =
        shellMedium) annotation (Placement(transformation(extent={{90,-70},{110,
            -50}}), iconTransformation(extent={{90,-10},{110,10}})));

equation
  connect(SensT_A_in.outlet, shell.infl) annotation (Line(
      points={{-54,-60},{-54,-60},{-20,-60}},
      color={0,0,255},
      thickness=0.5));
  connect(ConvHTc1.side1, tube.wall)
    annotation (Line(points={{0,33},{0,33},{0,50}}, color={255,127,0}));
  connect(shell.wall, ConvHTe1.side2)
    annotation (Line(points={{0,-50},{0,-33.1}}, color={255,127,0}));
  connect(SensT_B_in.outlet, tube.infl) annotation (Line(
      points={{54,60},{36,60},{20,60}},
      color={0,0,255},
      thickness=0.5));
  connect(MetalWall.int, ConvHTe1.side1)
    annotation (Line(points={{0,-13},{0,-13},{0,-27}}, color={255,127,0}));
  connect(ConvHTc1.side2, CounterCurrent1.side1)
    annotation (Line(points={{0,26.9},{0,13}}, color={255,127,0}));
  connect(CounterCurrent1.side2, MetalWall.ext)
    annotation (Line(points={{0,6.9},{0,-6.9}}, color={255,127,0}));
  connect(tubeInlet, SensT_B_out.outlet) annotation (Line(
      points={{-100,60},{-66,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(shellInlet, SensT_A_in.inlet) annotation (Line(
      points={{-100,-60},{-66,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(SensT_A_out.outlet, shellOutlet) annotation (Line(
      points={{66,-60},{100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(SensT_B_in.inlet, tubeOutlet) annotation (Line(
      points={{66,60},{100,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(shell.outfl, SensT_A_out.inlet) annotation (Line(
      points={{20,-60},{54,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(SensT_B_out.inlet, tube.outfl) annotation (Line(
      points={{-54,60},{-20,60}},
      color={0,0,255},
      smooth=Smooth.None));

  annotation (
    Diagram(coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=false,
        grid={1,1}), graphics),
    experiment(StopTime=900, Tolerance=1e-006),
    Documentation(info="<HTML>
<p>The model is designed to test the component  <tt>Flow1Dfem</tt> (fluid side of a heat exchanger, finite element method).<br>
This model represent the two fluid sides of a heat exchanger in counterflow configuration. The two sides are divided by a metal wall. The operating fluid is liquid water. The mass flow rate during the experiment and initial conditions are the same for the two sides. <br>
During the simulation, the inlet specific enthalpy for hexA (\"hot side\") is changed:
<ul>
    <li>t=50 s, Step variation of the specific enthalpy of the fluid entering hexA .</li>
</ul>
The outlet temperature of the hot side changes after the fluid transport time delay and the first order delay due to the wall's thermal inertia. The outlet temperature of the cold side starts changing after the thermal inertia delay. </p>
<p>
Simulation Interval = [0...900] sec <br> 
Integration Algorithm = DASSL <br>
Algorithm Tolerance = 1e-6 
</HTML>", revisions="<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
       New heat transfer components.</li>
    <li><i>1 Oct 2003</i> by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
    First release.</li>
</ul>

</html>"),
    Icon(coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=false,
        grid={1,1}), graphics={Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder),Polygon(
          points={{-60,95},{-60,64.5},{-62,72},{-58,72},{-60,64.5},{-60,95}},
          lineColor={95,95,95},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Polygon(
          points={{60,64.5},{60,95},{58,87.5},{62,87.5},{60,95},{60,64.5}},
          lineColor={95,95,95},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Polygon(
          points={{0,15.25},{0,-15.25},{-2,-7.75},{2,-7.75},{0,-15.25},{0,15.25}},
          lineColor={95,95,95},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          origin={-95,14.75},
          rotation=90),Text(
          extent={{-109,25},{-87,19.5}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          fontSize=16,
          horizontalAlignment=TextAlignment.Left,
          textString="Shell Inlet"),Text(
          extent={{87,17.5},{109,12}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          fontSize=16,
          textString="Shell Outlet",
          horizontalAlignment=TextAlignment.Left),Text(
          extent={{-11,2.75},{11,-2.75}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={-52.5,78.75},
          rotation=270,
          horizontalAlignment=TextAlignment.Left,
          textString="Tube Inlet",
          fontSize=16),Text(
          extent={{-12.5,2.75},{12.5,-2.75}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={52.75,82.5},
          rotation=90,
          fontSize=16,
          horizontalAlignment=TextAlignment.Left,
          textString="Tube Outlet"),Polygon(
          points={{-77.5,80},{-77.5,30},{-67.5,-40},{-52.5,-40},{-42.5,30},{-37.5,
            30},{-27.5,-40},{-12.5,-40},{-2.5,30},{2.5,30},{12.5,-40},{27.5,-40},
            {37.5,29.5},{42.5,29.5},{52.5,-40.5},{67.5,-40.5},{77.5,30},{77.5,
            80},{72.5,80},{72.5,30},{62.5,-35},{57.5,-35},{47.5,35},{32.5,35},{
            23,-35},{17.5,-35},{7.5,35},{-7.5,35},{-17,-35},{-22.5,-35},{-32.5,
            35},{-47.5,35},{-57.5,-35},{-62.5,-35},{-72.5,30},{-72.5,80},{-77.5,
            80}},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          smooth=Smooth.None,
          fillColor={255,85,85},
          pattern=LinePattern.None),Text(
          extent={{-100,-60},{100,-75}},
          lineColor={95,95,95},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          fontSize=24,
          textString="Shell-and-Tube Heat Exchanger")}));
end HXGas2Liquid_FEM;
