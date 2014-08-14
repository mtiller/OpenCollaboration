within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.CondenserGroup.Interfaces;
partial model Condenser "Base class for condenser"
  import aSMR = ORNL_AdvSMR;
  replaceable package FluidMedium = ORNL_AdvSMR.StandardWater constrainedby
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
  parameter Integer N_cool=2 "Number of nodes of the cooling fluid side";
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

  //Initialization conditions
  parameter Modelica.SIunits.Pressure pstart_cond=condNomPressure
    "Condensing fluid pressure start value"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Volume Vlstart_cond=condVol*0.15
    "Start value of the liquid water volume, condensation side"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));

  ORNL_AdvSMR.Interfaces.FlangeB waterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-30,
            -120},{10,-80}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA coolingIn(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{80,
            -60},{120,-20}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB coolingOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{80,
            40},{120,80}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA steamIn(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{-30,
            80},{10,120}}, rotation=0)));

  annotation (Diagram(graphics), Icon(graphics={Rectangle(
                    extent={{-100,100},{80,-60}},
                    lineColor={0,0,255},
                    fillColor={230,230,230},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{-90,-60},{70,-100}},
                    lineColor={0,0,255},
                    fillColor={230,230,230},
                    fillPattern=FillPattern.Solid),Line(
                    points={{100,-40},{-60,-40},{10,10},{-60,60},{100,
            60}},   color={0,0,255},
                    thickness=0.5),Text(
                    extent={{-100,-113},{100,-143}},
                    lineColor={85,170,255},
                    textString="%name")}));
end Condenser;
