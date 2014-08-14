within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbines;
model SteamTurbine_1tapping "Turbine with one tapping"

  replaceable package FluidMedium = ThermoPower3.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;

  //Turbines parameters
  parameter Modelica.SIunits.MassFlowRate wn "Inlet nominal flowrate";
  parameter Modelica.SIunits.Area Kt "Coefficient of Stodola's law";
  parameter Modelica.SIunits.Pressure pnom_in "Nominal inlet pressure";
  parameter Modelica.SIunits.Pressure pnom_tap "Nominal tapping pressure";
  parameter Modelica.SIunits.Pressure pnom_out "Nominal outlet pressure";

  //Start Value
  parameter Modelica.SIunits.MassFlowRate wstart=wn
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization"));

  Modelica.Blocks.Interfaces.RealInput partialArc annotation (Placement(
        transformation(extent={{-68,-48},{-48,-28}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
     Placement(transformation(extent={{-76,-10},{-56,10}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
     Placement(transformation(extent={{56,-10},{76,10}}, rotation=0)));
  ThermoPower3.Water.FlangeB tap1(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-6,-88},
            {12,-70}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_firstStages(
    redeclare package Medium = FluidMedium,
    wstart=wstart,
    wnom=wn,
    Kt=Kt,
    PRstart=pnom_in/pnom_out,
    pnom=pnom_in) annotation (Placement(transformation(extent={{-44,-18},
            {-8,18}}, rotation=0)));
  ThermoPower3.Water.SteamTurbineStodola ST_secondStages(
    redeclare package Medium = FluidMedium,
    wstart=wstart,
    wnom=wn,
    Kt=Kt,
    PRstart=pnom_tap/pnom_out,
    pnom=pnom_tap) annotation (Placement(transformation(extent={{18,-18},
            {56,18}}, rotation=0)));
  ThermoPower3.Water.FlangeA flangeA(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-90,
            62},{-56,96}}, rotation=0)));
  ThermoPower3.Water.FlangeB flangeB(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{62,
            62},{96,96}}, rotation=0)));

equation
  connect(shaft_b, ST_secondStages.shaft_b) annotation (Line(
      points={{66,0},{49.16,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_secondStages.shaft_a, ST_firstStages.shaft_b) annotation (
      Line(
      points={{24.46,0},{-14.48,0}},
      color={0,0,0},
      thickness=0.5));
  connect(flangeA, ST_firstStages.inlet) annotation (Line(
      points={{-73,79},{-40.4,79},{-40.4,14.4}},
      color={0,0,255},
      thickness=0.5));
  connect(flangeB, ST_secondStages.outlet) annotation (Line(
      points={{79,79},{52.2,79},{52.2,14.4}},
      color={0,0,255},
      thickness=0.5));
  connect(partialArc, ST_firstStages.partialArc) annotation (Line(
        points={{-58,-38},{-36,-38},{-36,-26},{-52,-26},{-52,-7.2},{-35,
          -7.2}}, color={0,0,127}));
  connect(ST_firstStages.shaft_a, shaft_a) annotation (Line(
      points={{-37.88,0},{-66,0}},
      color={0,0,0},
      thickness=0.5));
  connect(ST_firstStages.outlet, ST_secondStages.inlet) annotation (
      Line(
      points={{-11.6,14.4},{-3.25,14.4},{-3.25,14.4},{5.1,14.4},{5.1,
          14.4},{21.8,14.4}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ST_firstStages.outlet, tap1) annotation (Line(
      points={{-11.6,14.4},{3,14.4},{3,-79}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Polygon(
                  points={{-26,76},{-26,28},{-20,28},{-20,82},{-58,82},
            {-58,76},{-26,76}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{28,56},{34,56},{34,76},{62,76},{62,82},{28,
            82},{28,56}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-58,8},{62,-8}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Sphere,
                  fillColor={160,160,164}),Polygon(
                  points={{-26,28},{-26,-26},{34,-60},{34,60},{-26,28}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Text(extent={{-126,136},
          {132,96}}, textString="%name"),Polygon(
                  points={{2,-78},{4,-78},{4,-42},{2,-42},{2,-78}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  fillColor={0,0,255})}));
end SteamTurbine_1tapping;
