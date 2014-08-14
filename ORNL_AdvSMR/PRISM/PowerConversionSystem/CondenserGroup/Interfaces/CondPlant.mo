within ORNL_AdvSMR.PRISM.PowerConversionSystem.CondenserGroup.Interfaces;
partial model CondPlant "Base class for Condensation Plant"
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance;

  //Nominal parameter
  parameter Modelica.SIunits.MassFlowRate condNomFlowRate
    "Nominal flow rate through the condensing fluid side";
  parameter Modelica.SIunits.MassFlowRate coolNomFlowRate
    "Nominal flow rate through the cooling fluid side";
  parameter Modelica.SIunits.Pressure condNomPressure
    "Nominal pressure in the condensing fluid side inlet";
  parameter Modelica.SIunits.Pressure coolNomPressure
    "Nominal pressure in the cooling fluid side inlet";

  //Physical Parameter
  parameter Integer N_cool=2 "Number of node of the cooling fluid side";
  parameter Modelica.SIunits.Area condExchSurface
    "Exchange surface between condensing fluid - metal";
  parameter Modelica.SIunits.Area coolExchSurface
    "Exchange surface between metal - cooling fluid";
  parameter Modelica.SIunits.Volume condVol "Condensing fluid volume";
  parameter Modelica.SIunits.Volume coolVol "Cooling fluid volume";
  parameter Modelica.SIunits.Volume metalVol
    "Volume of the metal part in the tubes";
  parameter Modelica.SIunits.SpecificHeatCapacity cm
    "Specific heat capacity of metal";
  parameter Modelica.SIunits.Density rhoMetal "Density of metal";

  //Initialization
  parameter Modelica.SIunits.Pressure pstart_cond=condNomPressure
    "Condensing fluid pressure start value"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Volume Vlstart_cond=condVol*0.15
    "Start value of the liquid water volume, condensation side"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization Conditions"));

  ORNL_AdvSMR.Interfaces.FlangeA SteamIn(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-20,80},{20,120}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB WaterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-20,-120},{
            20,-80}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus annotation (Placement(
        transformation(extent={{88,-50},{108,-30}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus annotation (Placement(
        transformation(extent={{108,-82},{88,-62}}, rotation=0)));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(
          points={{40,30},{-40,30},{38,0},{-40,-30},{40,-30}},
          color={0,0,255},
          thickness=0.5),Line(points={{0,60},{0,100}}, color={0,0,255}),Line(
          points={{0,-60},{0,-100}}, color={0,0,255})}));

end CondPlant;
