within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model ST_3LRh_7t
  "Base class for Steam Turbine with two pressure levels, reheat and seven tappings"

  replaceable package FluidMedium = ThermoPower3.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;

  //Turbines parameter
  parameter Modelica.SIunits.MassFlowRate steamHPNomFlowRate
    "Nominal HP steam flow rate";
  parameter Modelica.SIunits.MassFlowRate steamIPNomFlowRate
    "Nominal IP steam flow rate";
  parameter Modelica.SIunits.MassFlowRate steamLPNomFlowRate
    "Nominal LP steam flowr rate";
  parameter Modelica.SIunits.Pressure steamHPNomPressure
    "Nominal HP steam pressure";
  parameter Modelica.SIunits.Pressure steamIPNomPressure
    "Nominal IP steam pressure";
  parameter Modelica.SIunits.Pressure steamLPNomPressure
    "Nominal LP steam pressure";
  parameter Modelica.SIunits.Area HPT_Kt "Flow coefficient"
    annotation (Dialog(group="HP Turbine"));
  parameter Real HPT_eta_mech=0.98 "Mechanical efficiency"
    annotation (Dialog(group="HP Turbine"));
  parameter Real HPT_eta_iso_nom=0.92 "Nominal isentropic efficiency"
    annotation (Dialog(group="HP Turbine"));
  parameter Modelica.SIunits.Area IPT_Kt "Flow coefficient"
    annotation (Dialog(group="IP Turbine"));
  parameter Real IPT_eta_mech=0.98 "Mechanical efficiency"
    annotation (Dialog(group="IP Turbine"));
  parameter Real IPT_eta_iso_nom=0.92 "Nominal isentropic efficiency"
    annotation (Dialog(group="IP Turbine"));
  parameter Modelica.SIunits.Area LPT_Kt "Flow coefficient"
    annotation (Dialog(group="LP Turbine"));
  parameter Real LPT_eta_mech=0.98 "Mechanical efficiency"
    annotation (Dialog(group="LP Turbine"));
  parameter Real LPT_eta_iso_nom=0.92 "Nominal isentropic efficiency"
    annotation (Dialog(group="LP Turbine"));

  //Start value
  //HPT
  parameter Modelica.SIunits.Pressure HPT_pstart_in=
      steamHPNomPressure "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.Pressure HPT_pstart_out=
      steamIPNomPressure "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.MassFlowRate HPT_wstart=
      steamHPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));

  //IPT
  parameter Modelica.SIunits.Pressure IPT_pstart_in=
      steamIPNomPressure "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));
  parameter Modelica.SIunits.Pressure IPT_pstart_out=
      steamLPNomPressure "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));
  parameter Modelica.SIunits.MassFlowRate IPT_wstart=
      steamIPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));

  //LPT
  parameter Modelica.SIunits.Pressure LPT_pstart_in=
      steamLPNomPressure "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.Pressure LPT_pstart_out=pcond
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.MassFlowRate LPT_wstart=
      steamLPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));

  //other parameter
  parameter Modelica.SIunits.Pressure pcond "Condenser pressure";

  ThermoPower3.Water.FlangeB Tap1(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-180,
            -210},{-160,-190}}, rotation=0)));
  ThermoPower3.Water.FlangeB Tap2(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-140,
            -210},{-120,-190}}, rotation=0)));
  ThermoPower3.Water.FlangeB Tap3(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-100,
            -210},{-80,-190}}, rotation=0)));
  ThermoPower3.Water.FlangeB Tap4(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-60,
            -210},{-40,-190}}, rotation=0)));
  ThermoPower3.Water.FlangeB Tap5(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-20,
            -210},{0,-190}}, rotation=0)));
  ThermoPower3.Water.FlangeB Tap6(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{20,
            -210},{40,-190}}, rotation=0)));
  ThermoPower3.Water.FlangeB Tap7(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{60,
            -210},{80,-190}}, rotation=0)));

  ThermoPower3.Water.FlangeA HPT_In(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-180,
            180},{-140,220}}, rotation=0)));
  ThermoPower3.Water.FlangeB HPT_Out(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-120,
            180},{-80,220}}, rotation=0)));
  ThermoPower3.Water.FlangeA IPT_In(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-60,
            180},{-20,220}}, rotation=0)));
  ThermoPower3.Water.FlangeB LPT_In(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{60,
            180},{100,220}}, rotation=0)));
  ThermoPower3.Water.FlangeB LPT_Out(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{
            120,-220},{160,-180}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b
    annotation (Placement(transformation(extent={{180,-20},{220,20}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}},
          rotation=0)));
  ThermoPower3.PowerPlants.Buses.Sensors SensorsBus annotation (
      Placement(transformation(extent={{180,-100},{220,-60}},
          rotation=0)));
  ThermoPower3.PowerPlants.Buses.Actuators ActuatorsBus annotation (
      Placement(transformation(extent={{220,-160},{180,-120}},
          rotation=0)));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
                    extent={{-200,200},{200,-200}},
                    lineColor={170,170,255},
                    fillColor={230,230,230},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{-202,14},{200,-14}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Line(points={{-100,200},
          {-100,88}}, color={0,0,255}),Line(points={{-40,30},{-40,200}},
          color={0,0,255}),Line(points={{80,30},{80,200}}, color={0,0,
          255}),Line(points={{20,84},{20,130},{80,130}}, color={0,0,
          255}),Ellipse(
                    extent={{76,134},{84,126}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Line(points={{140,
          -84},{140,-200}}, color={0,0,255}),Line(points={{-160,30},{
          -160,120},{-160,146},{-160,204}}, color={0,0,255}),Line(
                    points={{-170,-200},{-170,-108},{-140,-108},{-140,
            -44}},  color={0,0,255},
                    pattern=LinePattern.Dash),Line(
                    points={{-130,-200},{-130,-120},{-120,-120},{-120,
            -58}},  color={0,0,255},
                    pattern=LinePattern.Dash),Line(
                    points={{-50,-196},{-50,-120},{0,-120},{0,-60}},
                    color={0,0,255},
                    pattern=LinePattern.Dash),Line(
                    points={{-90,-198},{-90,-108},{-20,-108},{-20,-40}},
                    color={0,0,255},
                    pattern=LinePattern.Dash),Line(
                    points={{70,-198},{70,-150},{124,-150},{124,-64}},
                    color={0,0,255},
                    pattern=LinePattern.Dash),Line(
                    points={{30,-194},{30,-140},{110,-140},{110,-52}},
                    color={0,0,255},
                    pattern=LinePattern.Dash),Line(
                    points={{-10,-198},{-10,-130},{92,-130},{92,-36}},
                    color={0,0,255},
                    pattern=LinePattern.Dash),Polygon(
                    points={{-160,30},{-160,-30},{-100,-90},{-100,90},
            {-160,30}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{-40,30},{-40,-30},{20,-90},{20,90},{-40,
            30}},   lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{80,30},{80,-30},{140,-90},{140,90},{80,
            30}},   lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{-166,148},{-154,148},{-160,132},{-166,
            148}},  lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-106,134},{-94,134},{-100,150},{-106,134}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-46,148},{-34,148},{-40,132},{-46,148}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{134,-134},{146,-134},{140,-150},{134,-134}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{40,136},{40,124},{56,130},{40,136}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{74,166},{86,166},{80,150},{74,166}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{74,106},{86,106},{80,90},{74,106}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255})}));
end ST_3LRh_7t;
