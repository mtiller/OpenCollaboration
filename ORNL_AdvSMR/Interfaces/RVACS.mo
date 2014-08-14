within ORNL_AdvSMR.Interfaces;
partial model RVACS
  "Interface description for reactor vessel auxiliary cooling system (RVACS)"

  /* CORE Coolant Channel Paramters */
  replaceable package DRACSFluid =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "DRACS coolant"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="DRACS", group="Coolant Media"));
  replaceable package Air =
      Modelica.Media.Interfaces.PartialSimpleIdealGasMedium constrainedby
    Modelica.Media.Interfaces.PartialSimpleIdealGasMedium "Air" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="DRACS", group="Coolant Media"));

  Interfaces.FlangeB toPHTS(redeclare package Medium = DRACSFluid) annotation (
      Placement(transformation(extent={{90,31},{110,51}}), iconTransformation(
          extent={{95,40},{115,60}})));
  Interfaces.FlangeA fromPHTS(redeclare package Medium = DRACSFluid)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{95,-60},{115,-40}})));
  ControlBus controlBus annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={0,-95})));

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
          extent={{-105,100},{105,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),Rectangle(
          extent={{-90,90},{90,-60}},
          lineColor={175,175,175},
          fillColor={223,220,216},
          fillPattern=FillPattern.Solid,
          radius=1),Text(
          extent={{-100,-65.5},{100,-75.5}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="DRACS")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end RVACS;
