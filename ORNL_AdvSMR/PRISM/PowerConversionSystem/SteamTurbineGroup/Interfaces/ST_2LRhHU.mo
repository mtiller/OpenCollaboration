within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model ST_2LRhHU
  "Base class for Steam Turbine with two pressure levels, reheat and with coupling Heat Usage"

  replaceable package FluidMedium = ThermoPower3.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;

  //Turbines parameter
  parameter Modelica.SIunits.MassFlowRate steamHPNomFlowRate
    "Nominal HP steam flow rate";
  parameter Modelica.SIunits.MassFlowRate steamLPNomFlowRate
    "Nominal LP steam flowr rate";
  parameter Modelica.SIunits.Pressure steamHPNomPressure
    "Nominal HP steam pressure";
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
  parameter Modelica.SIunits.Pressure HPT_pstart_out=steamLPNomPressure
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.MassFlowRate HPT_wstart=steamHPNomFlowRate
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));

  //LPT
  parameter Modelica.SIunits.Pressure LPT_pstart_in=steamLPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.Pressure LPT_pstart_out=pcond
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.MassFlowRate LPT_wstart=steamLPNomFlowRate
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));

  //other parameter
  parameter Modelica.SIunits.Pressure pcond "Condenser pressure";

  ThermoPower3.Water.FlangeB SteamForHU(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-60,-220},{-20,-180}},
          rotation=0)));
  ThermoPower3.Water.FlangeB LPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{60,-220},{100,-180}},
          rotation=0)));
  ThermoPower3.Water.FlangeA HPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-180,180},{-140,220}},
          rotation=0)));
  ThermoPower3.Water.FlangeB HPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-120,180},{-80,220}},
          rotation=0)));
  ThermoPower3.Water.FlangeA LPT_In_Rh(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-60,180},{-20,220}}, rotation
          =0)));
  ThermoPower3.Water.FlangeA LPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{60,180},{100,220}}, rotation=
            0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b annotation (
      Placement(transformation(extent={{180,-20},{220,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a annotation (
      Placement(transformation(extent={{-220,-20},{-180,20}}, rotation=0)));
  ThermoPower3.PowerPlants.Buses.Sensors SensorsBus annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0)));
  ThermoPower3.PowerPlants.Buses.Actuators ActuatorsBus annotation (Placement(
        transformation(extent={{220,-160},{180,-120}}, rotation=0)));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{76,136},{84,128}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Line(points={{-98,132},{140,132},{140,
          -140},{-40,-140},{-40,-198}}, color={0,0,255}),Line(points={{80,132},
          {80,192}}, color={0,0,255}),Line(points={{-160,198},{-160,30}}, color
          ={0,0,255}),Line(points={{-100,200},{-100,88}}, color={0,0,255}),Line(
          points={{-40,200},{-40,30}}, color={0,0,255}),Rectangle(
          extent={{-200,14},{200,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(points={{80,-90},{80,-198}}, color={0,0,
          255}),Ellipse(
          extent={{-104,136},{-96,128}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-74,138},{-74,126},{-58,132},{-74,138}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-166,128},{-154,128},{-160,112},{-166,128}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{104,138},{104,126},{120,132},{104,138}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{74,170},{86,170},{80,154},{74,170}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-46,106},{-34,106},{-40,90},{-46,106}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{74,-152},{86,-152},{80,-168},{74,-152}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-106,152},{-94,152},{-100,168},{-106,152}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-160,30},{-160,-30},{-100,-90},{-100,90},{-160,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-40,30},{-40,-30},{80,-90},{80,90},{-40,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics));
end ST_2LRhHU;
