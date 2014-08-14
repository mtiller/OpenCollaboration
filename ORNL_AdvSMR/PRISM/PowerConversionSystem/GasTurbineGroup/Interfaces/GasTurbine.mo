within ORNL_AdvSMR.PRISM.PowerConversionSystem.GasTurbineGroup.Interfaces;
partial model GasTurbine "Base class for Gas Turbine"
  import aSMR = ORNL_AdvSMR;
  replaceable package FlueGasMedium = ThermoPower3.Media.FlueGas constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  replaceable package AirMedium = ORNL_AdvSMR.Media.Fluids.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  replaceable package FuelMedium = ThermoPower3.Media.NaturalGas constrainedby
    Modelica.Media.Interfaces.PartialMedium;
  ThermoPower3.Gas.FlangeA FuelInlet(redeclare package Medium = FuelMedium)
    annotation (Placement(transformation(extent={{-20,180},{20,220}}, rotation=
            0)));
  ThermoPower3.Gas.FlangeA AirInlet(redeclare package Medium = AirMedium)
    annotation (Placement(transformation(extent={{-220,140},{-180,180}},
          rotation=0)));
  ThermoPower3.Gas.FlangeB FlueGasOutlet(redeclare package Medium =
        FlueGasMedium) annotation (Placement(transformation(extent={{180,140},{
            220,180}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
      Placement(transformation(extent={{180,-20},{220,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
      Placement(transformation(extent={{-220,-20},{-180,20}}, rotation=0)));
  ThermoPower3.PowerPlants.Buses.Sensors SensorsBus annotation (Placement(
        transformation(extent={{180,-120},{220,-80}}, rotation=0)));
  ThermoPower3.PowerPlants.Buses.Actuators ActuatorsBus annotation (Placement(
        transformation(extent={{220,-180},{180,-140}}, rotation=0)));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-200,12},{200,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Ellipse(
          extent={{-30,150},{30,90}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),Polygon(
          points={{-30,30},{-40,30},{-40,120},{-30,120},{-30,30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{30,30},{40,30},{40,120},{30,120},{30,30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{-130,112},{-120,106},{-120,166},{-200,166},{-200,154},{-130,
            154},{-130,112}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{130,112},{120,108},{120,166},{200,166},{200,154},{130,154},{
            130,112}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{-130,120},{-30,40},{-30,-40},{-130,-120},{-130,120}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{130,120},{30,40},{30,-40},{130,-120},{130,-120},{130,120}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255}),Polygon(
          points={{4,150},{-4,150},{-8,200},{8,200},{4,150}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,170,255})}));
end GasTurbine;
