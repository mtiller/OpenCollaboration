within ORNL_AdvSMR.Interfaces;
partial model RxPrimaryHeatTransportSystem
  "Interface description for reactor and primary heat transport system"

  /* CORE Coolant Channel Paramters */
  replaceable package PrimaryFluid =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Primary coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Coolant Channel", group="Coolant Medium"));

  Interfaces.FlangeB toIHX(redeclare package Medium = PrimaryFluid)
    "Primary coolant exiting the reactor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,40}), iconTransformation(extent={{90,40},{110,60}})));
  Interfaces.FlangeA fromIHX(redeclare package Medium = PrimaryFluid)
    "Primary coolant entering the reactor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-40}), iconTransformation(extent={{90,-60},{110,-40}})));
  Interfaces.FlangeA fromDRACS(redeclare package Medium = PrimaryFluid)
    "DRACS coolant entering the reactor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,40}), iconTransformation(extent={{-110,40},{-90,60}})));
  Interfaces.FlangeB toDRACS(redeclare package Medium = PrimaryFluid)
    "DRACS coolant exiting the reactor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-40}), iconTransformation(extent={{-110,-60},{-90,-40}})));
  ControlBus controlBus "Local PHTS bus for sensor and actuator communications"
    annotation (Placement(transformation(extent={{-10,-104},{10,-84}}),
        iconTransformation(extent={{-10,-104},{10,-84}})));

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),
        Rectangle(
          extent={{-80,80},{80,-60}},
          lineColor={175,175,175},
          fillColor={223,220,216},
          fillPattern=FillPattern.Solid,
          radius=1),
        Text(
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
end RxPrimaryHeatTransportSystem;
