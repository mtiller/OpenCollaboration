within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model ST_2LHU
  "Base class for Steam Turbine with two pressure levels and with coupling Heat Usage"
  import aSMR = ORNL_AdvSMR;
  replaceable package FluidMedium = Modelica.Media.Water
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
  parameter Modelica.SIunits.Pressure HPT_pstart_in=
      steamHPNomPressure "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.Pressure HPT_pstart_out=
      steamLPNomPressure "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.MassFlowRate HPT_wstart=
      steamHPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));

  //LPT
  parameter Modelica.SIunits.Pressure LPT_pstart_in=
      steamLPNomPressure "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.Pressure LPT_pstart_out=pcond
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.MassFlowRate LPT_wstart=
      steamHPNomFlowRate "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));

  //other parameter
  parameter Modelica.SIunits.Pressure pcond "Condenser pressure";

  ORNL_AdvSMR.Interfaces.FlangeB SteamForHU(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-80,
            -220},{-40,-180}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB LPT_Out(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{28,
            -220},{68,-180}}, rotation=0)));

  ORNL_AdvSMR.Interfaces.FlangeA HPT_In(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-140,
            180},{-100,220}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA LPT_In(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-20,
            180},{20,220}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b
    annotation (Placement(transformation(extent={{180,-20},{220,20}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus
                                         annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus
                                             annotation (Placement(
        transformation(extent={{220,-160},{180,-120}}, rotation=0)));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
                    extent={{-200,200},{200,-200}},
                    lineColor={170,170,255},
                    fillColor={230,230,230},
                    fillPattern=FillPattern.Solid),Ellipse(
                    extent={{-20,134},{-12,126}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Line(points={{-60,
          -198},{-60,-140},{140,-140},{140,130},{0,130}}, color={0,0,
          255}),Line(points={{-60,90},{-60,130},{0,130}}, color={0,0,
          255}),Line(points={{0,130},{0,198}}, color={0,0,255}),
          Rectangle(extent={{-200,14},{200,-14}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={135,135,135}),Line(points={{-120,28},{
          -120,200}}, color={0,0,255}),Line(points={{48,-90},{48,-192}},
          color={0,0,255}),Line(points={{-12,130},{-12,120},{-12,30}},
          color={0,0,255}),Polygon(
                    points={{-50,136},{-50,124},{-34,130},{-50,136}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-126,148},{-114,148},{-120,132},{-126,
            148}},  lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-6,168},{6,168},{0,152},{-6,168}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{42,-152},{54,-152},{48,-168},{42,-152}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-18,102},{-6,102},{-12,86},{-18,102}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{26,136},{26,124},{42,130},{26,136}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Ellipse(
                    extent={{0,134},{8,126}},
                    lineColor={0,0,255},
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{-16,134},{4,126}},
                    lineColor={0,0,255},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,255}),Polygon(
                    points={{-120,30},{-120,-30},{-60,-90},{-60,90},{
            -120,30}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid),Polygon(
                    points={{-12,30},{-12,-30},{48,-90},{48,90},{-12,
            30}},   lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics));
end ST_2LHU;
