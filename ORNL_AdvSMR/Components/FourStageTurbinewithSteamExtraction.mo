within ORNL_AdvSMR.Components;
model FourStageTurbinewithSteamExtraction
  "Models a four-stage Stodola turbine with steam extraction lines."
  import aSMR = ORNL_AdvSMR;

  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model";

  parameter Boolean explicitIsentropicEnthalpy=true
    "Outlet enthalpy computed by isentropicEnthalpy function";

  parameter Modelica.SIunits.MassFlowRate wstart=wnom
    "Mass flow rate start value" annotation (Dialog(tab="Initialization"));

  parameter Real PRstart "Pressure ratio start value"
    annotation (Dialog(tab="Initialization"));

  // General Parameters
  parameter Real eta_mech=0.995 "Mechanical efficiency at each turbine stage";

  parameter Real eta_iso_nom=0.9794
    "Nominal isentropic efficiency for each turbine stage";

  parameter Modelica.SIunits.Area Kt "Kt coefficient of Stodola's law";

  parameter Real partialArc_nom=1 "Nominal partial arc for each stage";

  parameter Boolean allowFlowReversal=false
    "= true to allow flow reversal, false restricts to design direction";

  // Stage 1
  parameter Modelica.SIunits.Pressure pnom
    "Nominal inlet pressure for the 1st turbine stage"
    annotation (Dialog(tab="General", group="Stage 1"));
  parameter Modelica.SIunits.MassFlowRate wnom
    "Inlet nominal flowrate for the 1st turbine stage"
    annotation (Dialog(tab="General", group="Stage 1"));

  // Stage 2
  parameter Modelica.SIunits.Pressure p_nom2
    "Nominal inlet pressure for the 2nd turbine stage"
    annotation (Dialog(tab="General", group="Stage 2"));
  parameter Modelica.SIunits.MassFlowRate w_tap1
    "Mass flow rate for the 1st steam bypass line"
    annotation (Dialog(tab="General", group="Stage 2"));

  // Stage 3
  parameter Modelica.SIunits.Pressure p_nom3
    "Nominal inlet pressure for the 3rd turbine stage"
    annotation (Dialog(tab="General", group="Stage 3"));
  parameter Modelica.SIunits.MassFlowRate w_tap2
    "Mass flow rate for the 2nd steam bypass line"
    annotation (Dialog(tab="General", group="Stage 3"));

  // Stage 4
  parameter Modelica.SIunits.Pressure p_nom4
    "Nominal inlet pressure for the 4th turbine stage"
    annotation (Dialog(tab="General", group="Stage 4"));
  parameter Modelica.SIunits.MassFlowRate w_tap3
    "Mass flow rate for the 3rd steam bypass line"
    annotation (Dialog(tab="General", group="Stage 4"));

protected
  replaceable ORNL_AdvSMR.Components.StateReader_water stateReader_water(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      allowFlowReversal=false) constrainedby
    ORNL_AdvSMR.Components.StateReader_water(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-90,55})));

  replaceable ORNL_AdvSMR.Components.StateReader_water stateReader_water1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      allowFlowReversal=false) constrainedby
    ORNL_AdvSMR.Components.StateReader_water(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-50,-75})));

  replaceable ORNL_AdvSMR.Components.StateReader_water stateReader_water2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      allowFlowReversal=false) constrainedby
    ORNL_AdvSMR.Components.StateReader_water(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={0,-76})));

  replaceable ORNL_AdvSMR.Components.StateReader_water stateReader_water4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      allowFlowReversal=false) constrainedby
    ORNL_AdvSMR.Components.StateReader_water(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={50,-75})));

  replaceable ORNL_AdvSMR.Components.StateReader_water stateReader_water8(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      allowFlowReversal=false) constrainedby
    ORNL_AdvSMR.Components.StateReader_water(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={90,55})));

public
  SteamTurbineStodola stage1(
    explicitIsentropicEnthalpy=true,
    wnom=wnom,
    pnom=pnom,
    eta_mech=eta_mech,
    allowFlowReversal=false,
    eta_iso_nom=eta_iso_nom,
    Kt=Kt,
    partialArc_nom=partialArc_nom,
    PRstart=pnom/p_nom2)
    annotation (Placement(transformation(extent={{-85,-10},{-65,10}})));

  SteamTurbineStodola stage2(
    explicitIsentropicEnthalpy=true,
    wnom=wnom - w_tap1,
    pnom=p_nom2,
    eta_mech=eta_mech,
    allowFlowReversal=false,
    eta_iso_nom=eta_iso_nom,
    Kt=Kt,
    partialArc_nom=partialArc_nom,
    wstart=wnom - w_tap1,
    PRstart=p_nom2/p_nom3)
    annotation (Placement(transformation(extent={{-35,-10},{-15,10}})));

  SteamTurbineStodola stage3(
    explicitIsentropicEnthalpy=true,
    wnom=wnom - (w_tap1 + w_tap2),
    pnom=p_nom3,
    eta_mech=eta_mech,
    allowFlowReversal=false,
    eta_iso_nom=eta_iso_nom,
    Kt=Kt,
    partialArc_nom=partialArc_nom,
    PRstart=p_nom3/p_nom4)
    annotation (Placement(transformation(extent={{15,-10},{35,10}})));

  SteamTurbineStodola stage4(
    explicitIsentropicEnthalpy=true,
    wnom=wnom - (w_tap1 + w_tap2 + w_tap3),
    pnom=p_nom4,
    eta_mech=eta_mech,
    allowFlowReversal=false,
    eta_iso_nom=eta_iso_nom,
    Kt=Kt,
    partialArc_nom=partialArc_nom,
    PRstart=2) annotation (Placement(transformation(extent={{65,-10},{85,10}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
          extent={{90,-10},{110,10}})));

  ORNL_AdvSMR.Interfaces.FlangeA turbineInlet annotation (Placement(
        transformation(extent={{-60,65},{-50,75}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,98})));

  ORNL_AdvSMR.Interfaces.FlangeB turbineOutlet annotation (Placement(
        transformation(extent={{50,95},{60,105}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-100})));

  ORNL_AdvSMR.Interfaces.FlangeB tap1 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-50,-95.5}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-100})));

  ORNL_AdvSMR.Interfaces.FlangeB tap2 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={0,-95}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100})));

  ORNL_AdvSMR.Interfaces.FlangeB tap3 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={50,-95}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-100})));

  ORNL_AdvSMR.Components.FlowSplit flowSplit(
    allowFlowReversal=false,
    rev_in1=false,
    rev_out1=false,
    rev_out2=false,
    checkFlowDirection=false)
    annotation (Placement(transformation(extent={{-65,4},{-55,14}})));

  ORNL_AdvSMR.Components.FlowSplit flowSplit1(
    allowFlowReversal=false,
    rev_in1=false,
    rev_out1=false,
    rev_out2=false,
    checkFlowDirection=false)
    annotation (Placement(transformation(extent={{-15,4},{-5,14}})));

  ORNL_AdvSMR.Components.FlowSplit flowSplit2(
    allowFlowReversal=false,
    rev_in1=false,
    rev_out1=false,
    rev_out2=false,
    checkFlowDirection=false)
    annotation (Placement(transformation(extent={{35,4},{45,14}})));

equation
  connect(stage1.shaft_b, stage2.shaft_a) annotation (Line(
      points={{-65,0},{-35,0}},
      color={0,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(stage2.shaft_b, stage3.shaft_a) annotation (Line(
      points={{-15,0},{15,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(stage3.shaft_b, stage4.shaft_a) annotation (Line(
      points={{35,0},{65,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(stage1.shaft_a, shaft_a) annotation (Line(
      points={{-85,0},{-100,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(stateReader_water.outlet, turbineInlet) annotation (Line(
      points={{-90,58},{-90,70},{-55,70}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(turbineOutlet, stateReader_water8.outlet) annotation (Line(
      points={{55,100},{55,90},{90,90},{90,58}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stateReader_water.inlet, stage1.inlet) annotation (Line(
      points={{-90,52},{-90,10},{-85,10}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stage1.outlet, flowSplit.in1) annotation (Line(
      points={{-65,-10},{-64,-10},{-64,9},{-63,9}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=1));
  connect(stateReader_water1.outlet, tap1) annotation (Line(
      points={{-50,-78},{-50,-95.5}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit.out2, stateReader_water1.inlet) annotation (Line(
      points={{-57,7},{-50,7},{-50,-72}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stage2.outlet, flowSplit1.in1) annotation (Line(
      points={{-15,-10},{-14,-10},{-14,9},{-13,9}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stateReader_water2.outlet, tap2) annotation (Line(
      points={{-5.51091e-016,-79},{0,-95}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit1.out2, stateReader_water2.inlet) annotation (Line(
      points={{-7,7},{5.51091e-016,7},{5.51091e-016,-73}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit1.out1, stage3.inlet) annotation (Line(
      points={{-7,11},{6,11},{6,10},{15,10}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit2.in1, stage3.outlet) annotation (Line(
      points={{37,9},{36,9},{36,-10},{35,-10}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stateReader_water4.outlet, tap3) annotation (Line(
      points={{50,-78},{50,-95}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit2.out2, stateReader_water4.inlet) annotation (Line(
      points={{43,7},{50,7},{50,-72}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit2.out1, stage4.inlet) annotation (Line(
      points={{43,11},{55,11},{55,10},{65,10}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stage4.outlet, stateReader_water8.inlet) annotation (Line(
      points={{85,-10},{90,-10},{90,52}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  connect(stage4.shaft_b, shaft_b) annotation (Line(
      points={{85,0},{100,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(flowSplit.out1, stage2.inlet) annotation (Line(
      points={{-57,11},{-45,11},{-45,10},{-35,10}},
      color={0,0,255},
      thickness=1,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Bitmap(extent={{-200,100},{200,-100}}, fileName=
              "modelica://ORNL_AdvSMR/../Icons/Turbine-4Stage.png")}));
end FourStageTurbinewithSteamExtraction;
