within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbines;
model TwoStageSteamTurbine
  "Two-stage Stodola steam turbine with one steam extraction."
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water.StandardWater
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
        transformation(extent={{-120,-70},{-100,-50}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
     Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
     Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB tap1(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-10,
            -110},{10,-90}}, rotation=0)));
  ORNL_AdvSMR.Components.SteamTurbineStodola firstStage(
    redeclare package Medium = FluidMedium,
    wstart=wstart,
    wnom=wn,
    Kt=Kt,
    PRstart=pnom_in/pnom_out,
    pnom=pnom_in) annotation (Placement(transformation(extent={{-90,-40},
            {-10,40}}, rotation=0)));
  ORNL_AdvSMR.Components.SteamTurbineStodola secondStage(
    redeclare package Medium = FluidMedium,
    wstart=wstart,
    wnom=wn,
    Kt=Kt,
    PRstart=pnom_tap/pnom_out,
    pnom=pnom_tap) annotation (Placement(transformation(extent={{10,-40},
            {90,40}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA flangeA(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-110,
            90},{-90,110}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB flangeB(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{90,
            90},{110,110}}, rotation=0)));

equation
  connect(flangeA, flangeA) annotation (Line(
      points={{-100,100},{-100,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(partialArc, firstStage.partialArc) annotation (Line(
      points={{-110,-60},{-90,-60},{-90,-20},{-78,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialArc, secondStage.partialArc) annotation (Line(
      points={{-110,-60},{-10,-60},{-10,-20},{22,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flangeA, firstStage.inlet) annotation (Line(
      points={{-100,100},{-90,100},{-90,40}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(secondStage.outlet, flangeB) annotation (Line(
      points={{90,-40},{80,-40},{80,100},{100,100}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(firstStage.outlet, secondStage.inlet) annotation (Line(
      points={{-10,-40},{-8,-40},{-8,40},{-2,40},{-2,40},{10,40}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(shaft_a, firstStage.shaft_a) annotation (Line(
      points={{-100,0},{-90,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(firstStage.shaft_b, secondStage.shaft_a) annotation (Line(
      points={{-10,0},{-1,0},{-1,0},{10,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(secondStage.shaft_b, shaft_b) annotation (Line(
      points={{90,0},{100,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(tap1, firstStage.outlet) annotation (Line(
      points={{0,-100},{0,-40},{-10,-40}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Polygon(
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
end TwoStageSteamTurbine;
