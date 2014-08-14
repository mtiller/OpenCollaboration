within ORNL_AdvSMR.Interfaces;
partial model IntermediateHeatTransportSystem

  //   replaceable package IntermediateFluid =
  //       ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium constrainedby
  //     ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Intermediate fluid" annotation (
  //     Evaluate=true,
  //     choicesAllMatching=true,
  //     Dialog(tab="Geometry", group="Shell Side"));
  //
  replaceable package IntermediateFluid = ORNL_AdvSMR.Media.Fluids.Na
    constrainedby ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium
    "Intermediate fluid" annotation (
    Evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Geometry"));

  Interfaces.FlangeA fromIHX(redeclare package Medium = IntermediateFluid)
    annotation (Placement(transformation(extent={{-110,20},{-90,40}}),
        iconTransformation(extent={{-105,25},{-90,40}})));
  Interfaces.FlangeB toIHX(redeclare package Medium = IntermediateFluid)
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}}),
        iconTransformation(extent={{-105,-35},{-90,-20}})));
  Interfaces.FlangeA fromSG(redeclare package Medium = IntermediateFluid)
    annotation (Placement(transformation(extent={{90,-40},{110,-20}}),
        iconTransformation(extent={{95,-35},{110,-20}})));
  Interfaces.FlangeB toSG(redeclare package Medium = IntermediateFluid)
    annotation (Placement(transformation(extent={{90,20},{110,40}}),
        iconTransformation(extent={{90,45},{105,60}})));

  ControlBus controlBus annotation (Placement(transformation(extent={{-10,-107.5},
            {10,-87.5}}),iconTransformation(extent={{-10,-107.5},{10,-87.5}})));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          radius=2),Rectangle(
          extent={{-85,85},{85,-55}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Text(
          extent={{-100,-64},{100,-74}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Intermediate Heat Transport System")}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-006,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end IntermediateHeatTransportSystem;
