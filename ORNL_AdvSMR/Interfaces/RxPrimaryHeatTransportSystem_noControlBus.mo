within ORNL_AdvSMR.Interfaces;
partial model RxPrimaryHeatTransportSystem_noControlBus
  "Interface description for reactor and primary heat transport system"

  /* CORE Coolant Channel Paramters */
  replaceable package PrimaryFluid =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="CORE Coolant Channel", group="Coolant Medium"));

  Interfaces.FlangeB toIHX(redeclare package Medium = PrimaryFluid) annotation
    (Placement(transformation(extent={{90,31},{110,51}}), iconTransformation(
          extent={{90,40},{110,60}})));
  Interfaces.FlangeA fromIHX(redeclare package Medium = PrimaryFluid)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-60},{110,-40}})));
  Interfaces.FlangeA fromDRACS(redeclare package Medium = PrimaryFluid)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
        iconTransformation(extent={{-110,40},{-90,60}})));
  Interfaces.FlangeB toDRACS(redeclare package Medium = PrimaryFluid)
    annotation (Placement(transformation(extent={{-110,-49},{-90,-29}}),
        iconTransformation(extent={{-110,-60},{-90,-40}})));

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
          textString="Primary Heat Transport System")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end RxPrimaryHeatTransportSystem_noControlBus;
