within ORNL_AdvSMR.Interfaces;
partial model SteamGenerator "Interface definition for steam generator"

  // Shell Side
  replaceable package shellMedium =
      ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Shell fluid"
    annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Shell Side"));

  // Tube Side
  replaceable package tubeMedium =
      ORNL_AdvSMR.Media.Interfaces.PartialTwoPhaseMedium constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialTwoPhaseMedium "Tube fluid" annotation
    (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry", group="Tube Side"));

  Interfaces.FlangeA shellInlet(redeclare package Medium = shellMedium)
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}}),
        iconTransformation(extent={{-100,35},{-80,55}})));
  Interfaces.FlangeB shellOutlet(redeclare package Medium = shellMedium)
    annotation (Placement(transformation(extent={{-90,90},{-70,110}}),
        iconTransformation(extent={{80,-50},{100,-30}})));
  Interfaces.FlangeA tubeInlet(redeclare package Medium = tubeMedium)
    annotation (Placement(transformation(extent={{70,90},{90,110}}),
        iconTransformation(extent={{-10,100},{10,120}})));
  Interfaces.FlangeB tubeOutlet(redeclare package Medium = tubeMedium)
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{-10,-120},{10,-100}})));

  ControlBus controlBus annotation (Placement(transformation(extent={{75,-100},
            {95,-80}}), iconTransformation(extent={{75,-100},{95,-80}})));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Bitmap(
          extent={{-99.875,99.875},{99.875,-99.875}},
          origin={-0.125,-0.125},
          rotation=180,
          fileName="modelica://ORNL_AdvSMR/Icons/HelicalCoilSteamGenerator.png")}));

end SteamGenerator;
