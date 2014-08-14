within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model ST_3L_noMixing
  "Base class for Steam Turbine with three pressure levels"
  import aSMR = ORNL_AdvSMR;

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
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));
  //HPT
  parameter Modelica.SIunits.Pressure HPT_pstart_in=steamHPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.Pressure HPT_pstart_out=steamIPNomPressure
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.MassFlowRate HPT_wstart=steamHPNomFlowRate
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));

  //IPT
  parameter Modelica.SIunits.Pressure IPT_pstart_in=steamIPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));
  parameter Modelica.SIunits.Pressure IPT_pstart_out=steamLPNomPressure
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));
  parameter Modelica.SIunits.MassFlowRate IPT_wstart=steamIPNomFlowRate +
      steamHPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));

  //LPT
  parameter Modelica.SIunits.Pressure LPT_pstart_in=steamLPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.Pressure LPT_pstart_out=pcond
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.MassFlowRate LPT_wstart=steamLPNomFlowRate +
      steamIPNomFlowRate + steamHPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));

  //Other parameter
  parameter Modelica.SIunits.Pressure pcond "Condenser pressure";

  ORNL_AdvSMR.Interfaces.FlangeA HPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-180,180},{-140,220}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB HPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-120,180},{-80,220}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA IPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-20,180},{20,220}}, rotation=
            0), iconTransformation(extent={{-40,180},{0,220}})));
  ORNL_AdvSMR.Interfaces.FlangeB IPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{40,180},{80,220}}, rotation=0),
        iconTransformation(extent={{20,180},{60,220}})));
  ORNL_AdvSMR.Interfaces.FlangeA LPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{140,180},{180,220}}, rotation
          =0), iconTransformation(extent={{100,180},{140,220}})));
  ORNL_AdvSMR.Interfaces.FlangeB LPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{120,-220},{160,-180}},
          rotation=0), iconTransformation(extent={{140,-220},{180,-180}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b annotation (
      Placement(transformation(extent={{180,-20},{220,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a annotation (
      Placement(transformation(extent={{-220,-20},{-180,20}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0),
        iconTransformation(extent={{200,-100},{240,-60}})));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus annotation (Placement(
        transformation(extent={{220,-160},{180,-120}}, rotation=0),
        iconTransformation(extent={{240,-160},{200,-120}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-200,14},{200,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(points={{-100,200},{-100,90}}, color={0,
          0,255}),Line(points={{-20,30},{-20,200}}, color={0,0,255}),Line(
          points={{100,30},{100,100},{120,100},{120,200}}, color={0,0,255}),
          Line(points={{160,-90},{160,-200}}, color={0,0,255}),Line(points={{-160,
          30},{-160,120},{-160,146},{-160,204}}, color={0,0,255}),Polygon(
          points={{-166,148},{-154,148},{-160,132},{-166,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-26,148},{-14,148},{-20,132},{-26,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-106,134},{-94,134},{-100,150},{-106,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-8,6},{-8,-6},{8,0},{-8,6}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          origin={40,140},
          rotation=90),Polygon(
          points={{114,148},{126,148},{120,132},{114,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{94,78},{106,78},{100,62},{94,78}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{154,-124},{166,-124},{160,-140},{154,-124}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-160,30},{-160,-30},{-100,-90},{-100,90},{-160,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-20,30},{-20,-30},{40,-90},{40,90},{-20,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{100,30},{100,-30},{160,-90},{160,90},{100,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{40,90},{40,200}}, color=
          {0,0,255})}), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics));

end ST_3L_noMixing;
