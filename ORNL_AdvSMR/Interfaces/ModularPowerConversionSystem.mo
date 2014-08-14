within ORNL_AdvSMR.Interfaces;
partial model ModularPowerConversionSystem
  "Interface description for power conversion system"

  parameter Integer noSteamLines=3
    "Number of steam lines from intermediate heat transport system";

  replaceable package powerMedium =
      Modelica.Media.Interfaces.PartialTwoPhaseMedium constrainedby
    Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Power conversion system working fluid" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Shell Side"));

  Interfaces.FlangeA[noSteamLines] steamInlet(redeclare package Medium =
        powerMedium) annotation (Placement(transformation(extent={{-210,70},{-190,
            90}}), iconTransformation(extent={{-220,80},{-180,120}})));
  Interfaces.FlangeB condensateReturn(redeclare package Medium = powerMedium)
    annotation (Placement(transformation(extent={{-210,-90},{-190,-70}}),
        iconTransformation(extent={{-220,-120},{-180,-80}})));
  Interfaces.ControlBus controlBus annotation (Placement(transformation(extent=
            {{-40,-190},{40,-110}}), iconTransformation(extent={{-30.5,-175},{
            30,-115}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b rotorShaft annotation (
      Placement(transformation(extent={{180,-20},{220,20}}),iconTransformation(
          extent={{180,-20},{220,20}})));

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-160},{200,160}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-160},{200,160}},
        grid={2,2}), graphics={Rectangle(
          extent={{-200,160},{200,-160}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),Text(
          extent={{-140,-104},{140,-116}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Power Conversion System"),Bitmap(extent={{-180,206},{180,
          -148}}, fileName="modelica://ORNL_AdvSMR/Icons/Steam Turbine.jpg"),
          Text(
          extent={{-13,4},{13,-4}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-196,63},
          rotation=90,
          textString="Steam Inlet"),Text(
          extent={{-20,5},{20,-5}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-195,-56},
          rotation=90,
          textString="Condensate Return"),Text(
          extent={{-20,3},{20,-3}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={189,-32},
          rotation=270,
          textString="Rotor Shaft")}),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-007,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end ModularPowerConversionSystem;
