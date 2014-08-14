within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.CondenserGroup.Interfaces;
partial model CondPlantHU_base
  "Base class for Condensation Plant with coupling Heat Usage (simplified version)"
  import aSMR = ORNL_AdvSMR;

  replaceable package FluidMedium = Modelica.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;

  parameter Modelica.SIunits.Pressure p "Pressure of condesation";
  parameter Modelica.SIunits.Volume Vtot "Total volume condensing fluid side";
  parameter Modelica.SIunits.Volume Vlstart "Start value of the liquid volume"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));
  ORNL_AdvSMR.Interfaces.FlangeA CondensatedFromHU(redeclare package Medium =
        FluidMedium)        annotation (Placement(transformation(
          extent={{-70,80},{-30,120}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeA SteamIn(redeclare package Medium = FluidMedium)
                     annotation (Placement(transformation(extent={{30,
            80},{70,120}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB WaterOut(redeclare package Medium =
        FluidMedium) annotation (Placement(transformation(extent={{-20,
            -120},{20,-80}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Sensors SensorsBus
                                         annotation (Placement(
        transformation(extent={{88,-50},{108,-30}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.Actuators ActuatorsBus
                                             annotation (Placement(
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
                    thickness=0.5),Line(points={{0,-60},{0,-98}},
          color={0,0,255}),Line(points={{-60,0},{-80,0},{-80,70},{-50,
          70},{-50,102}}, color={0,0,255}),Line(points={{0,60},{0,70},
          {50,70},{50,88}}, color={0,0,255})}));

end CondPlantHU_base;
