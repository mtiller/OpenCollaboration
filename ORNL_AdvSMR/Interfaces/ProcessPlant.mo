within ORNL_AdvSMR.Interfaces;
partial model ProcessPlant "Interface description for a process heat plant"

  /* CORE Coolant Channel Paramters */
  replaceable package PrimaryFluid =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="CORE Coolant Channel", group="Coolant Medium"));

  Interfaces.FlangeA toPHP(redeclare package Medium = PrimaryFluid) annotation
    (Placement(transformation(extent={{-110,30},{-90,50}}), iconTransformation(
          extent={{-110,40},{-90,60}})));
  Interfaces.FlangeB fromPHP(redeclare package Medium = PrimaryFluid)
    annotation (Placement(transformation(extent={{-110,-49},{-90,-29}}),
        iconTransformation(extent={{-110,-60},{-90,-40}})));
  ControlBus controlBus annotation (Placement(transformation(
        extent={{30,30},{-30,-30}},
        rotation=180,
        origin={-60,-90}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={0,-90})));

  annotation (
    __Dymola_Images(Parameters(
        tab="CORE Coolant Channel",
        group="Flow Geometry",
        source="C:/Users/mfc/SkyDrive/Documents/Icons/TriangularPitch.png")),
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
          radius=2),Rectangle(
          extent={{-80,80},{80,-60}},
          lineColor={175,175,175},
          fillColor={223,220,216},
          fillPattern=FillPattern.Solid,
          radius=1),Text(
          extent={{-100,-66},{100,-74}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Process Heat Plant")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end ProcessPlant;
