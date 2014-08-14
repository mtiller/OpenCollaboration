within ORNL_AdvSMR.Interfaces;
partial model PowerConversionSystem
  "Interface description for power conversion system"

  replaceable package powerFluid =
      Modelica.Media.Interfaces.PartialTwoPhaseMedium constrainedby
    Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Power conversion system working fluid" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Shell Side"));

  Interfaces.FlangeA steamInlet(redeclare package Medium = powerFluid)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,60}), iconTransformation(extent={{-110,50},{-90,70}})));
  Interfaces.FlangeB condensateReturn(redeclare package Medium = powerFluid)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-60}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b rotorShaft annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0}), iconTransformation(extent={{90,-10},{110,10}})));

  ControlBus controlBus annotation (Placement(transformation(extent={{-10,-108},
            {10,-88}}), iconTransformation(extent={{-10,-104},{10,-84}})));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),Text(
          extent={{-140,-50},{140,-62}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Power Conversion System"),Bitmap(extent={{-80,136},{80,-92}},
          fileName="modelica://ORNL_AdvSMR/Icons/Steam Turbine.jpg"),Text(
          extent={{-13,4},{13,-4}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-86,61},
          rotation=90,
          textString="Steam Inlet",
          fontSize=12),Text(
          extent={{-20,5},{20,-5}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-85,-60},
          rotation=90,
          textString="Condensate Return",
          fontSize=12),Text(
          extent={{-20,3},{20,-3}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={87,0},
          rotation=270,
          textString="Rotor Shaft",
          fontSize=12)}),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-007,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end PowerConversionSystem;
