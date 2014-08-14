within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
model SecondarySide
  import aSMR = ORNL_AdvSMR;

  ORNL_AdvSMR.SIInterfaces.SILengthInput L annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,80},{
            -90,90}})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,65},{
            -90,75}})));
  Modelica.Blocks.Interfaces.RealInput u2 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,50},{
            -90,60}})));
  Modelica.Blocks.Interfaces.RealInput u3 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,35},{
            -90,45}})));
  Modelica.Blocks.Interfaces.RealInput u4 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,20},{
            -90,30}})));
  Modelica.Blocks.Interfaces.RealInput u5 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,5},{-90,
            15}})));
  Modelica.Blocks.Interfaces.RealInput u6 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,-15},
            {-90,-5}})));
  Modelica.Blocks.Interfaces.RealInput u7 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,-30},
            {-90,-20}})));
  Modelica.Blocks.Interfaces.RealInput u8 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,-45},
            {-90,-35}})));
  Modelica.Blocks.Interfaces.RealInput u9 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,-60},
            {-90,-50}})));
  Modelica.Blocks.Interfaces.RealInput u10 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,-75},
            {-90,-65}})));
  Modelica.Blocks.Interfaces.RealInput u11 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(extent={{-100,-90},
            {-90,-80}})));
  Modelica.Blocks.Interfaces.RealInput u12 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-55,95})));
  Modelica.Blocks.Interfaces.RealInput u13 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-35,95})));
  Modelica.Blocks.Interfaces.RealInput u14 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-15,95})));
  Modelica.Blocks.Interfaces.RealInput u15 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={55,95})));
  Modelica.Blocks.Interfaces.RealInput u16 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={15,95})));
  Modelica.Blocks.Interfaces.RealInput u17 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={35,95})));
  Modelica.Blocks.Interfaces.RealInput u18 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-55,-95})));
  Modelica.Blocks.Interfaces.RealInput u19 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-35,-95})));
  Modelica.Blocks.Interfaces.RealInput u20 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-15,-95})));
  Modelica.Blocks.Interfaces.RealInput u21 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={15,-95})));
  Modelica.Blocks.Interfaces.RealInput u22 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={35,-95})));
  Modelica.Blocks.Interfaces.RealInput u23 annotation (Placement(transformation(
          extent={{-110,85},{-90,105}}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={55,-95})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,90},{100,
            100}})));
  Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,75},{100,
            85}})));
  Modelica.Blocks.Interfaces.RealOutput y2 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,45},{100,
            55}})));
  Modelica.Blocks.Interfaces.RealOutput y3 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,60},{100,
            70}})));
  Modelica.Blocks.Interfaces.RealOutput y4 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,-10},{100,
            0}})));
  Modelica.Blocks.Interfaces.RealOutput y5 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,0},{100,
            10}})));
  Modelica.Blocks.Interfaces.RealOutput y6 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,30},{100,
            40}})));
  Modelica.Blocks.Interfaces.RealOutput y7 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,15},{100,
            25}})));
  Modelica.Blocks.Interfaces.RealOutput y8 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,-100},{
            100,-90}})));
  Modelica.Blocks.Interfaces.RealOutput y9 annotation (Placement(transformation(
          extent={{80,80},{100,100}}), iconTransformation(extent={{90,-85},{100,
            -75}})));
  Modelica.Blocks.Interfaces.RealOutput y10 annotation (Placement(
        transformation(extent={{80,80},{100,100}}), iconTransformation(extent={
            {90,-55},{100,-45}})));
  Modelica.Blocks.Interfaces.RealOutput y11 annotation (Placement(
        transformation(extent={{80,80},{100,100}}), iconTransformation(extent={
            {90,-70},{100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput y12 annotation (Placement(
        transformation(extent={{80,80},{100,100}}), iconTransformation(extent={
            {90,-40},{100,-30}})));
  Modelica.Blocks.Interfaces.RealOutput y13 annotation (Placement(
        transformation(extent={{80,80},{100,100}}), iconTransformation(extent={
            {90,-25},{100,-15}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Bitmap(extent={{-95,95},{95,-95}}, fileName=
          "modelica://aSMR/Icons/HelicalCoilSteamGenerator.png")}), Diagram(
        coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics));
end SecondarySide;
