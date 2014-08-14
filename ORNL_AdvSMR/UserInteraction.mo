within ORNL_AdvSMR;
package UserInteraction "Visual objects for user interaction"
  extends Modelica.Icons.Package;

  package ParameterInputs
    extends Modelica.Icons.Package;
    model NumericParameterIO
      parameter String label="";
      parameter Integer precision=3;
      parameter Real max=1;
      parameter Real min=0;
      parameter Real Value=0 annotation (DDE);
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  extent={{-100,-40},{100,40}},
                  lineColor={192,192,192},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Sunken),Text(extent={{-90,-46},{
              90,34}}, textString=DynamicSelect("0.0", realString(
                  Value,
                  1,
                  integer(precision)))),Text(extent={{-100,40},{100,100}},
              textString="%label")},
          interaction={OnMouseDownEditReal(
                  Value,
                  min,
                  max)}));
    end NumericParameterIO;

    model ParameterSlider
      extends UserInteraction.Internal.ScalingParameter(unScaled=pos);
      parameter Real pos annotation (DDE);

      parameter Real Value=scaled;

      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  extent={{0,-100},{100,100}},
                  lineColor={160,160,164},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Sunken),Rectangle(
                  extent={{0,DynamicSelect(-10, pos*200 - 100 - 10)},{100,
                DynamicSelect(10, pos*200 - 100 + 10)}},
                  lineColor={0,0,255},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Raised),Text(
                  extent={{-100,70},{0,130}},
                  lineColor={0,0,255},
                  textString="%max"),Text(
                  extent={{-100,-130},{0,-70}},
                  lineColor={0,0,255},
                  textString="%min")},
          interaction={OnMouseMoveYSetReal(
                  pos,
                  0,
                  1)}));
    end ParameterSlider;

    model ParameterKnob
      extends UserInteraction.Internal.ScalingParameter(unScaled=(if angle >= 0
             then angle else angle + 2*Modelica.Constants.pi)/(2*Modelica.Constants.pi));

      final parameter Real Value=scaled;
      final parameter Real angle=Modelica.Math.atan2(y, x);

      parameter Real x(start=1) annotation (DDE);
      parameter Real y(start=0) annotation (DDE);

      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(
                  points=DynamicSelect({{0,0},{100,0}}, {{0,0},{100*cos(
                Modelica.Math.atan2(y, x)),100*sin(Modelica.Math.atan2(y, x))}}),
                  color={0,0,255},
                  thickness=2),Line(points={{0,100},{0,80}}, color={0,0,255}),
              Line(points={{0,-80},{0,-100}}, color={0,0,255}),Line(points={{-80,
              0},{-100,0}}, color={0,0,255}),Line(points={{100,0},{80,0}},
              color={0,0,255})},
          interaction={OnMouseMoveXSetReal(
                  x,
                  -100,
                  100),OnMouseMoveYSetReal(
                  y,
                  -100,
                  100)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics));
    end ParameterKnob;

    model NumericStateIO
      parameter String label="";
      parameter Integer precision=3;
      parameter Real max=1;
      parameter Real min=0;
      Modelica.Blocks.Interfaces.RealInput Value(start=0);
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  extent={{-100,-40},{100,40}},
                  lineColor={192,192,192},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Sunken),Text(extent={{-90,-46},{
              90,34}}, textString=DynamicSelect("0.0", realString(
                  Value,
                  1,
                  integer(precision)))),Text(extent={{-100,40},{100,100}},
              textString="%label")},
          interaction={OnMouseDownEditReal(
                  Value,
                  min,
                  max)}));
    end NumericStateIO;

  end ParameterInputs;

  package Inputs
    extends Modelica.Icons.Package;
    model NumericInputIO
      parameter String label="";
      parameter Integer precision=3;
      parameter Real max=0;
      parameter Real min=0;
      Modelica.Blocks.Interfaces.RealOutput Value annotation (DDE, Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  extent={{-100,-40},{100,40}},
                  lineColor={192,192,192},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Sunken),Text(extent={{-90,-46},{
              90,34}}, textString=DynamicSelect("0.0", realString(
                  Value,
                  1,
                  integer(precision)))),Text(extent={{-100,40},{100,100}},
              textString="%label")},
          interaction={OnMouseDownEditReal(
                  Value,
                  min,
                  max)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics));
    end NumericInputIO;

    model Slider
      extends UserInteraction.Internal.Scaling;
      Real pos annotation (DDE);

      Modelica.Blocks.Interfaces.RealOutput Value=scaled annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
    equation
      unScaled = pos;
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  extent={{0,-100},{100,100}},
                  lineColor={192,192,192},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Sunken),Rectangle(
                  extent=[0, DynamicSelect(-10, unScaled*200 - 100 - 10); 100,
                DynamicSelect(10, unScaled*200 - 100 + 10)],
                  lineColor={0,0,255},
                  fillColor={236,233,216},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Raised),Text(
                  extent={{-100,70},{0,130}},
                  lineColor={0,0,255},
                  textString="%max"),Text(
                  extent={{-100,-130},{0,-70}},
                  lineColor={0,0,255},
                  textString="%min")},
          interaction={OnMouseMoveYSetReal(
                  unScaled,
                  0,
                  1)}));
    end Slider;

    model Knob
      extends UserInteraction.Internal.Scaling;

      Modelica.Blocks.Interfaces.RealOutput Value annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Real angle;
    protected
      Real x(start=1) annotation (DDE);
      Real y(start=0) annotation (DDE);
    equation
      angle = Modelica.Math.atan2(y, x);
      unScaled = (if angle >= 0 then angle else angle + 2*Modelica.Constants.pi)
        /(2*Modelica.Constants.pi);
      Value = scaled;
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(
                  points=DynamicSelect({{0,0},{100,0}}, {{0,0},{100*cos(angle),
                100*sin(angle)}}),
                  color={0,0,255},
                  thickness=2),Line(points={{0,100},{0,80}}, color={0,0,255}),
              Line(points={{0,-80},{0,-100}}, color={0,0,255}),Line(points={{-80,
              0},{-100,0}}, color={0,0,255}),Line(points={{100,0},{80,0}},
              color={0,0,255})},
          interaction={OnMouseMoveXSetReal(
                  x,
                  -100,
                  100),OnMouseMoveYSetReal(
                  y,
                  -100,
                  100)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics));
    end Knob;

    model TrigButton
      parameter String label="";

      Modelica.Blocks.Interfaces.BooleanOutput buttonOutput annotation (
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    protected
      Boolean buttonState annotation (Hide=false);
    equation
      // annotation (DDE);
      when pre(buttonState) then
        buttonState = false;
      end when;
      buttonOutput = pre(buttonState);
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  borderPattern=BorderPattern.Raised,
                  extent={{-100,-100},{100,100}},
                  fillColor=DynamicSelect({192,192,192}, if buttonState > 0.5
                 then {255,0,0} else {192,192,192}),
                  fillPattern=FillPattern.Solid,
                  lineColor={128,128,128},
                  lineThickness=2),Text(
                  extent={{-80,-40},{80,40}},
                  lineColor={0,0,255},
                  textString="%label")},
          interaction={OnMouseDownSetBoolean(buttonState, true)}));
    end TrigButton;

    model ToggleButton
      parameter String label="";
      Modelica.Blocks.Interfaces.BooleanOutput buttonState annotation (
        DDE,
        Hide=false,
        Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  fillColor=DynamicSelect({192,192,192}, if buttonState > 0.5
                 then {255,0,0} else {192,192,192}),
                  borderPattern=BorderPattern.Raised,
                  fillPattern=FillPattern.Solid,
                  lineColor={128,128,128},
                  lineThickness=4),Text(
                  extent={{-80,-40},{80,40}},
                  lineColor={0,0,255},
                  textString="%label")},
          interaction={OnMouseDownSetBoolean(buttonState, not buttonState > 0.5)}));

    end ToggleButton;

  end Inputs;

  package Outputs
    extends Modelica.Icons.Package;
    model NumericValue
      parameter Integer precision(min=0) = 3;
      parameter Boolean hideConnector=true;
      input Real input_Value=fromConnector
        annotation (Dialog(enable=hideConnector));
      Modelica.Blocks.Interfaces.RealInput Value if not hideConnector
        annotation (Placement(iconTransformation(extent={{-120,-10},{-100,10}}),
            transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=input_Value) if
        hideConnector
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Real y=internalNode;
    protected
      constant Real fromConnector=0 "Dummy introduced to get nice dialogs";
      Modelica.Blocks.Interfaces.RealOutput internalNode annotation (Placement(
            transformation(extent={{60,-10},{80,10}}), iconTransformation(
              extent={{90,-10},{110,10}}, rotation=0)));
    equation
      connect(Value, internalNode) annotation (Line(
          points={{-120,0},{70,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realExpression.y, internalNode) annotation (Line(
          points={{1,-30},{20,-30},{20,0},{70,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(extent={{-90,-46},{90,34}},
                textString=DynamicSelect("0.0", realString(
                      y,
                      1,
                      integer(precision))))}), Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics));
    end NumericValue;

    model IndicatorRectangle
      parameter Boolean hideConnector=false;

      Modelica.Blocks.Interfaces.BooleanInput status if not hideConnector
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));

      input Boolean input_Value=fromConnector
        annotation (Dialog(enable=hideConnector));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=input_Value)
        if hideConnector
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Boolean y=internalNode;
    protected
      constant Boolean fromConnector=false
        "Dummy introduced to get nice dialogs";
      Modelica.Blocks.Interfaces.BooleanOutput internalNode annotation (
          Placement(transformation(extent={{60,-10},{80,10}}),
            iconTransformation(extent={{90,-10},{110,10}}, rotation=0)));
    equation
      connect(status, internalNode) annotation (Line(
          points={{-100,0},{70,0}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(booleanExpression.y, internalNode) annotation (Line(
          points={{1,-30},{20,-30},{20,0},{70,0}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor=DynamicSelect({0,0,255}, if y > 0.5 then {255,0,0}
                 else {192,192,192}),
                  fillColor=DynamicSelect({192,192,192}, if y > 0.5 then {255,0,
                0} else {192,192,192}),
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Raised)}), Diagram(
            coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics));
    end IndicatorRectangle;

    model IndicatorLamp
      parameter Boolean hideConnector=false;

      Modelica.Blocks.Interfaces.BooleanInput status if not hideConnector
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));

      input Boolean input_Value=fromConnector
        annotation (Dialog(enable=hideConnector));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=input_Value)
        if hideConnector
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Boolean y=internalNode;
    protected
      constant Boolean fromConnector=false
        "Dummy introduced to get nice dialogs";
      Modelica.Blocks.Interfaces.BooleanOutput internalNode annotation (
          Placement(transformation(extent={{60,-10},{80,10}}),
            iconTransformation(extent={{90,-10},{110,10}}, rotation=0)));
    equation
      connect(status, internalNode) annotation (Line(
          points={{-100,0},{70,0}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(booleanExpression.y, internalNode) annotation (Line(
          points={{1,-30},{20,-30},{20,0},{70,0}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-100,-100},{100,100}},
                  fillColor=DynamicSelect({192,192,192}, if y > 0.5 then {255,0,
                0} else {192,192,192}),
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Sphere)}));
    end IndicatorLamp;

    model PolyLine
      input Real x[:]={1} annotation (Dialog);
      input Real y[size(x, 1)]={1} annotation (Dialog);

      parameter Internal.Color color={255,0,0} annotation (Hide=false);

      extends UserInteraction.Internal.ScalingXYVectors(scaledX=x, scaledY=y);

      final Real[size(x, 1), 2] points=transpose({unScaledX,unScaledY})
        annotation (Hide=false);

      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{0,0},{1,1}},
            grid={0.01,0.01}), graphics={Line(
              points=DynamicSelect({{0,0},{0.4,0.7},{0.6,0.4},{1,1}}, points),
              color=color,
              pattern=LinePattern.None)}));
    end PolyLine;

    model Polygon
      input Real x[:]={1} annotation (Dialog);
      input Real y[size(x, 1)]={1} annotation (Dialog);

      parameter Internal.Color color={255,0,0} annotation (Hide=false);
      parameter Internal.Color fillColor={0,0,255} annotation (Hide=false);

      extends UserInteraction.Internal.ScalingXYVectors(scaledX=x, scaledY=y);

      final Real[size(x, 1), 2] points=transpose({unScaledX,unScaledY})
        annotation (Hide=false);

      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{0,0},{1,1}},
            grid={0.01,0.01}), graphics={Polygon(
                  points=DynamicSelect({{0.1,0.1},{0.4,0.7},{0.6,0.4},{0.9,0.9}},
                points),
                  lineColor=color,
                  fillColor=fillColor,
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Solid)}));
    end Polygon;

    model Bar
      extends UserInteraction.Internal.Scaling;

      parameter Boolean hideConnector=false;

      input Real input_Value=fromConnector
        annotation (Dialog(enable=hideConnector));
      Modelica.Blocks.Interfaces.RealInput Value if not hideConnector
        annotation (Placement(iconTransformation(extent={{-120,-10},{-100,10}}),
            transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=input_Value) if
        hideConnector
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Real y=internalNode;
    protected
      constant Real fromConnector=0 "Dummy introduced to get nice dialogs";
      Modelica.Blocks.Interfaces.RealOutput internalNode annotation (Placement(
            transformation(extent={{60,-10},{80,10}}), iconTransformation(
              extent={{90,-10},{110,10}}, rotation=0)));
    equation
      connect(Value, internalNode) annotation (Line(
          points={{-120,0},{70,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realExpression.y, internalNode) annotation (Line(
          points={{1,-30},{20,-30},{20,0},{70,0}},
          color={0,0,127},
          smooth=Smooth.None));
      scaled = internalNode;
      annotation (
        structurallyIncomplete,
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
                  extent={{0,-100},{100,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent=[0, -100; 100, DynamicSelect(0, min(max(unScaled, 0),
                1)*200 - 100)],
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})));
    end Bar;

    model SpatialPlot "Polyline with coordinate system"
      input Real x[:]={1} "Horizontal values for curve" annotation (Dialog);
      input Real y[size(x, 1)]={1} "Vertical values for curve"
        annotation (Dialog);
      parameter Real minX=0;
      parameter Real maxX=1;
      parameter Real minY=0;
      parameter Real maxY=1;
      parameter Internal.Color color={255,0,0} "Color (RGB) of curve";

      PolyLine PolyLine1(
        x=x,
        y=y,
        minX=minX,
        maxX=maxX,
        minY=minY,
        maxY=maxY,
        color=color) annotation (layer="icon", Placement(transformation(extent=
                {{-80,-80},{80,80}}, rotation=0)));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(extent={{-80,80},{80,-80}},
              lineColor={0,0,255}),Text(
                  extent={{-100,76},{-74,84}},
                  lineColor={0,0,255},
                  textString="%maxY"),Text(
                  extent={{-100,-84},{-74,-76}},
                  lineColor={0,0,255},
                  textString="%minY"),Text(
                  extent={{-94,-94},{-64,-86}},
                  lineColor={0,0,255},
                  textString="%minX"),Text(
                  extent={{66,-94},{96,-86}},
                  lineColor={0,0,255},
                  textString="%maxX")}));
    end SpatialPlot;

    model SpatialPlotWithBackground

      input Real x[:]={1} "Horizontal values for curve" annotation (Dialog);
      input Real y[size(x, 1)]={1} "Vertical values for curve"
        annotation (Dialog);
      parameter Real minX=0;
      parameter Real maxX=1;
      parameter Real minY=0;
      parameter Real maxY=1;
      parameter Internal.Color color={255,0,0} "Color (RGB) of curve";
      parameter String bitmapName="";
      parameter Integer bitmapSizeX=100 annotation (Hide=false);
      parameter Integer bitmapSizeY=100 annotation (Hide=false);
      parameter Integer bitmapMinX=0 annotation (Hide=false);
      parameter Integer bitmapMaxX=bitmapSizeX annotation (Hide=false);
      parameter Integer bitmapMinY=0 annotation (Hide=false);
      parameter Integer bitmapMaxY=bitmapSizeY annotation (Hide=false);

    protected
      parameter Integer bitmapOffsetX=0 annotation (Hide=false);
      parameter Integer bitmapOffsetY=0 annotation (Hide=false);
    protected
      PolyLine PolyLine1(
        x=x,
        y=y,
        minX=minX,
        maxX=maxX,
        minY=minY,
        maxY=maxY,
        color=color) annotation (layer="icon", Placement(transformation(extent=
                {{DynamicState(-100, -100 + 200*(bitmapOffsetX + bitmapMinX)/
                bitmapSizeX),DynamicState(-100, -100 + 200*(bitmapOffsetY +
                bitmapMinY)/bitmapSizeY)},{DynamicState(100, -100 + 200*(
                bitmapOffsetX + bitmapMaxX)/bitmapSizeX),DynamicState(100, -100
                 + 200*(bitmapOffsetY + bitmapMaxY)/bitmapSizeY)}}, rotation=0)));
    public
      PolyLine PolyLine2(
        x=x,
        y=y,
        minX=minX,
        maxX=maxX,
        minY=minY,
        maxY=maxY,
        color=color) annotation (Placement(transformation(extent={{DynamicState(
                -100, -100 + 200*(bitmapOffsetX + bitmapMinX)/bitmapSizeX),
                DynamicState(-100, -100 + 200*(bitmapOffsetY + bitmapMinY)/
                bitmapSizeY)},{DynamicState(100, -100 + 200*(bitmapOffsetX +
                bitmapMaxX)/bitmapSizeX),DynamicState(100, -100 + 200*(
                bitmapOffsetY + bitmapMaxY)/bitmapSizeY)}}, rotation=0)));
    equation

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Bitmap(
                  __Dymola_preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  fileName=bitmapName)}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Bitmap(
                  __Dymola_preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  fileName=bitmapName)}));
    end SpatialPlotWithBackground;

    model SpatialPlot2 "Two polylines with coordinate systems"
      input Real x1[:]={1} "Horizontal values for first curve"
        annotation (Dialog);
      input Real y1[size(x1, 1)]={1} "Vertical values for first curve"
        annotation (Dialog);
      input Real x2[:]=x1 "Horizontal values for second curve"
        annotation (Dialog);
      input Real y2[size(x2, 1)] "Vertical values for second curve"
        annotation (Dialog);
      parameter Real minX1=0;
      parameter Real maxX1=1;
      parameter Real minY1=0;
      parameter Real maxY1=1;
      parameter Real minX2=minX1;
      parameter Real maxX2=maxX1;
      parameter Real minY2=minY1;
      parameter Real maxY2=maxY1;
      parameter Internal.Color color1={255,0,0} "Color (RGB) of first curve"
        annotation (Hide=false);
      parameter Internal.Color color2={0,0,255} "Color (RGB) of second curve"
        annotation (Hide=false);

      PolyLine PolyLine1(
        x=x1,
        y=y1,
        minX=minX1,
        maxX=maxX1,
        minY=minY1,
        maxY=maxY1,
        color=color1) annotation (layer="icon", Placement(transformation(extent
              ={{-80,-80},{80,80}}, rotation=0), iconTransformation(extent={{-100,
                -100},{100,100}})));
      PolyLine PolyLine2(
        x=x2,
        y=y2,
        minX=minX2,
        maxX=maxX2,
        minY=minY2,
        maxY=maxY2,
        color=color2) annotation (layer="icon", Placement(transformation(extent
              ={{-80,-80},{80,80}}, rotation=0), iconTransformation(extent={{-100,
                -100},{100,100}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
            Text(
              extent={{-104,-108},{-76,-100}},
              lineColor={0,0,255},
              textString="%minX1"),
            Text(
              extent={{76,-108},{106,-100}},
              lineColor={0,0,255},
              textString="%maxX1"),
            Text(
              extent={{-104,-116},{-76,-108}},
              lineColor={0,0,255},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              textString="%minX2"),
            Text(
              extent={{76,-116},{106,-108}},
              lineColor={0,0,255},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              textString="%maxX2"),
            Text(
              extent={{-116,-102},{-90,-94}},
              lineColor={0,0,255},
              textString="%minY1"),
            Text(
              extent={{-116,92},{-90,100}},
              lineColor={0,0,255},
              textString="%maxY1"),
            Text(
              extent={{98,-100},{124,-92}},
              lineColor={0,0,255},
              textString="%minY2"),
            Text(
              extent={{98,94},{124,102}},
              lineColor={0,0,255},
              textString="%maxY2"),
            Line(points={{-100,-100},{-100,100}}, color={0,0,255}),
            Line(points={{100,-100},{100,100}}, color={0,0,255})}));

    end SpatialPlot2;

  protected
    model ColorBar
      // This output widget is not finished.
      input Real Values[50] "Values" annotation (Dialog);
      parameter Real minValues=0;
      parameter Real maxValues=1;
      parameter Integer n=50;

      Real val[size(Values, 1)]=Values - fill(minValues, size(Values, 1))/(
          maxValues - minValues);
    protected
      parameter Real width=200/n;

      model Cell
        parameter Integer i;
        parameter Real width;
        input Real Value;

        UserInteraction.Internal.Color col;

      equation
        //        , outerViewport
        when sample(0, 0.05) then
          col = UserInteraction.Internal.rgb({integer(360*Value),0.7,1});
        end when;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                      extent=DynamicSelect({{-100,-100},{100,100}}, {{integer(-100
                   + i*width),-100},{integer(-100 + (i + 1)*width),100}}),
                      lineColor={0,0,0},
                      pattern=LinePattern.None,
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid)}));
      end Cell;

      Cell Cell1(
        i=1,
        Value=val[1],
        width=width) annotation (Placement(transformation(extent={{-100,60},{-80,
                80}}, rotation=0)));
      Cell Cell2(
        i=2,
        Value=val[2],
        width=width) annotation (Placement(transformation(extent={{-80,60},{-60,
                80}}, rotation=0)));
      Cell Cell3(
        i=3,
        Value=val[3],
        width=width) annotation (Placement(transformation(extent={{-60,60},{-40,
                80}}, rotation=0)));
      Cell Cell4(
        i=4,
        Value=val[4],
        width=width) annotation (Placement(transformation(extent={{-40,60},{-20,
                80}}, rotation=0)));
      Cell Cell5(
        i=5,
        Value=val[5],
        width=width) annotation (Placement(transformation(extent={{-20,60},{0,
                80}}, rotation=0)));
      Cell Cell6(
        i=6,
        Value=val[6],
        width=width) annotation (Placement(transformation(extent={{0,60},{20,80}},
              rotation=0)));
      Cell Cell7(
        i=7,
        Value=val[7],
        width=width) annotation (Placement(transformation(extent={{20,60},{40,
                80}}, rotation=0)));
      Cell Cell8(
        i=8,
        Value=val[8],
        width=width) annotation (Placement(transformation(extent={{40,60},{60,
                80}}, rotation=0)));
      Cell Cell9(
        i=9,
        Value=val[9],
        width=width) annotation (Placement(transformation(extent={{60,60},{80,
                80}}, rotation=0)));
      Cell Cell10(
        i=10,
        Value=val[10],
        width=width) annotation (Placement(transformation(extent={{80,60},{100,
                80}}, rotation=0)));
      Cell Cell11(
        i=11,
        Value=val[11],
        width=width) annotation (Placement(transformation(extent={{-100,20},{-80,
                40}}, rotation=0)));
      Cell Cell12(
        i=12,
        Value=val[12],
        width=width) annotation (Placement(transformation(extent={{-80,20},{-60,
                40}}, rotation=0)));
      Cell Cell13(
        i=13,
        Value=val[13],
        width=width) annotation (Placement(transformation(extent={{-60,20},{-40,
                40}}, rotation=0)));
      Cell Cell14(
        i=14,
        Value=val[14],
        width=width) annotation (Placement(transformation(extent={{-40,20},{-20,
                40}}, rotation=0)));
      Cell Cell15(
        i=15,
        Value=val[15],
        width=width) annotation (Placement(transformation(extent={{-20,20},{0,
                40}}, rotation=0)));
      Cell Cell16(
        i=16,
        Value=val[16],
        width=width) annotation (Placement(transformation(extent={{0,20},{20,40}},
              rotation=0)));
      Cell Cell17(
        i=17,
        Value=val[17],
        width=width) annotation (Placement(transformation(extent={{20,20},{40,
                40}}, rotation=0)));
      Cell Cell18(
        i=18,
        Value=val[18],
        width=width) annotation (Placement(transformation(extent={{40,20},{60,
                40}}, rotation=0)));
      Cell Cell19(
        i=19,
        Value=val[19],
        width=width) annotation (Placement(transformation(extent={{60,20},{80,
                40}}, rotation=0)));
      Cell Cell20(
        i=20,
        Value=val[20],
        width=width) annotation (Placement(transformation(extent={{80,20},{100,
                40}}, rotation=0)));
      Cell Cell21(
        i=21,
        Value=val[21],
        width=width) annotation (Placement(transformation(extent={{-100,-20},{-80,
                0}}, rotation=0)));
      Cell Cell22(
        i=22,
        Value=val[22],
        width=width) annotation (Placement(transformation(extent={{-80,-20},{-60,
                0}}, rotation=0)));
      Cell Cell23(
        i=23,
        Value=val[23],
        width=width) annotation (Placement(transformation(extent={{-60,-20},{-40,
                0}}, rotation=0)));
      Cell Cell24(
        i=24,
        Value=val[24],
        width=width) annotation (Placement(transformation(extent={{-40,-20},{-20,
                0}}, rotation=0)));
      Cell Cell25(
        i=25,
        Value=val[25],
        width=width) annotation (Placement(transformation(extent={{-20,-20},{0,
                0}}, rotation=0)));
      Cell Cell26(
        i=26,
        Value=val[26],
        width=width) annotation (Placement(transformation(extent={{0,-20},{20,0}},
              rotation=0)));
      Cell Cell27(
        i=27,
        Value=val[27],
        width=width) annotation (Placement(transformation(extent={{20,-20},{40,
                0}}, rotation=0)));
      Cell Cell28(
        i=28,
        Value=val[28],
        width=width) annotation (Placement(transformation(extent={{40,-20},{60,
                0}}, rotation=0)));
      Cell Cell29(
        i=29,
        Value=val[29],
        width=width) annotation (Placement(transformation(extent={{60,-20},{80,
                0}}, rotation=0)));
      Cell Cell30(
        i=30,
        Value=val[30],
        width=width) annotation (Placement(transformation(extent={{80,-20},{100,
                0}}, rotation=0)));
      Cell Cell31(
        i=31,
        Value=val[31],
        width=width) annotation (Placement(transformation(extent={{-100,-60},{-80,
                -40}}, rotation=0)));
      Cell Cell32(
        i=32,
        Value=val[32],
        width=width) annotation (Placement(transformation(extent={{-80,-60},{-60,
                -40}}, rotation=0)));
      Cell Cell33(
        i=33,
        Value=val[33],
        width=width) annotation (Placement(transformation(extent={{-60,-60},{-40,
                -40}}, rotation=0)));
      Cell Cell34(
        i=34,
        Value=val[34],
        width=width) annotation (Placement(transformation(extent={{-40,-60},{-20,
                -40}}, rotation=0)));
      Cell Cell35(
        i=35,
        Value=val[35],
        width=width) annotation (Placement(transformation(extent={{-20,-60},{0,
                -40}}, rotation=0)));
      Cell Cell36(
        i=36,
        Value=val[36],
        width=width) annotation (Placement(transformation(extent={{0,-60},{20,-40}},
              rotation=0)));
      Cell Cell37(
        i=37,
        Value=val[37],
        width=width) annotation (Placement(transformation(extent={{20,-60},{40,
                -40}}, rotation=0)));
      Cell Cell38(
        i=38,
        Value=val[38],
        width=width) annotation (Placement(transformation(extent={{40,-60},{60,
                -40}}, rotation=0)));
      Cell Cell39(
        i=39,
        Value=val[39],
        width=width) annotation (Placement(transformation(extent={{60,-60},{80,
                -40}}, rotation=0)));
      Cell Cell40(
        i=40,
        Value=val[40],
        width=width) annotation (Placement(transformation(extent={{80,-60},{100,
                -40}}, rotation=0)));
      Cell Cell41(
        i=41,
        Value=val[41],
        width=width) annotation (Placement(transformation(extent={{-100,-100},{
                -80,-80}}, rotation=0)));
      Cell Cell42(
        i=42,
        Value=val[42],
        width=width) annotation (Placement(transformation(extent={{-80,-100},{-60,
                -80}}, rotation=0)));
      Cell Cell43(
        i=43,
        Value=val[43],
        width=width) annotation (Placement(transformation(extent={{-60,-100},{-40,
                -80}}, rotation=0)));
      Cell Cell44(
        i=44,
        Value=val[44],
        width=width) annotation (Placement(transformation(extent={{-40,-100},{-20,
                -80}}, rotation=0)));
      Cell Cell45(
        i=45,
        Value=val[45],
        width=width) annotation (Placement(transformation(extent={{-20,-100},{0,
                -80}}, rotation=0)));
      Cell Cell46(
        i=46,
        Value=val[46],
        width=width) annotation (Placement(transformation(extent={{0,-100},{20,
                -80}}, rotation=0)));
      Cell Cell47(
        i=47,
        Value=val[47],
        width=width) annotation (Placement(transformation(extent={{20,-100},{40,
                -80}}, rotation=0)));
      Cell Cell48(
        i=48,
        Value=val[48],
        width=width) annotation (Placement(transformation(extent={{40,-100},{60,
                -80}}, rotation=0)));
      Cell Cell49(
        i=49,
        Value=val[49],
        width=width) annotation (Placement(transformation(extent={{60,-100},{80,
                -80}}, rotation=0)));
      Cell Cell50(
        i=50,
        Value=val[50],
        width=width) annotation (Placement(transformation(extent={{80,-100},{
                100,-80}}, rotation=0)));

      //  Cell cell[n](i=1:n) annotation (extent=[-100, 0; -80, 20]);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={255,255,255},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid)}));
    end ColorBar;

  public
    block DynamicDiagram
      extends DynamicObject;
      // built-in base class
      output Real y;
      parameter String label="%name";
      Modelica.Blocks.Interfaces.RealInput Value annotation (Dialog, Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    equation
      y = Value;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(extent={{-100,100},{
              100,-100}}),Line(points={{-70,10},{-58.7,44.2},{-51.5,63.1},{-45.1,
              76.4},{-39.4,84.6},{-33.8,89.1},{-28.2,89.8},{-22.6,86.6},{-16.9,
              79.7},{-11.3,69.4},{-4.9,54.1},{3.17,31.2},{20.1,-20.8},{27.3,-40.2},
              {33.7,-54.2},{39.3,-63.1},{45,-68.4},{50.6,-70},{56.2,-67.6},{
              61.9,-61.5},{67.5,-51.9},{73.9,-37.2},{82,-14.8},{90,10}}, color=
              {0,0,0})}));
    end DynamicDiagram;

    block DynamicTrace
      extends DynamicObject;
      // built-in base class
      parameter Real xmin=-100;
      parameter Real xmax=100;
      parameter Real ymin=-100;
      parameter Real ymax=100;
      output Real x(min=xmin, max=xmax);
      output Real y(min=ymin, max=ymax);
      parameter Real sizeOfMarker=10;
      parameter Real traceInterval=1 "seconds";
      parameter Real numberOfTraces=10;
      Modelica.Blocks.Interfaces.RealInput Valuey annotation (Dialog, Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput Valuex annotation (Dialog, Placement(
            transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
    equation
      x = Valuex;
      y = Valuey;
      annotation (
        structurallyIncomplete,
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
                  extent={{100,100},{-100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(extent={{-100,100},{
              100,-100}}),Ellipse(
                  extent={{0,40},{10,50}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  lineThickness=2,
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{18,24},{26,32}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  lineThickness=2,
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{28,10},{34,16}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  lineThickness=2,
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{36,-2},{40,2}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  lineThickness=2,
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{40,-12},{42,-10}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  lineThickness=2,
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid)}));
    end DynamicTrace;

  protected
    partial block DynamicObject

    end DynamicObject;

  end Outputs;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model TestInteraction

      UserInteraction.Inputs.NumericInputIO NumericValueIO1(
        label="Numeric input",
        max=10,
        min=0) annotation (Placement(transformation(extent={{-100,50},{-80,70}},
              rotation=0)));
      UserInteraction.Inputs.Slider Slider1(min=-10, max=10) annotation (
          Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=0)));
      UserInteraction.Inputs.Knob Knob1(max=100) annotation (Placement(
            transformation(extent={{-100,-90},{-80,-70}}, rotation=0)));
      UserInteraction.Outputs.NumericValue NumericValue1(hideConnector=false)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}},
              rotation=0)));
      UserInteraction.Outputs.Bar Bar1(max=10) annotation (Placement(
            transformation(extent={{-20,70},{0,90}}, rotation=0)));
      UserInteraction.Outputs.DynamicDiagram DynamicDiagram1 annotation (
          Placement(transformation(extent={{20,50},{40,70}}, rotation=0)));
      UserInteraction.Outputs.NumericValue NumericValue2(hideConnector=false)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}},
              rotation=0)));
      UserInteraction.Outputs.Bar Bar2(min=-10, max=10) annotation (Placement(
            transformation(extent={{-20,10},{0,30}}, rotation=0)));
      UserInteraction.Outputs.DynamicDiagram DynamicDiagram2 annotation (
          Placement(transformation(extent={{20,-40},{100,40}}, rotation=0)));
      UserInteraction.Outputs.NumericValue NumericValue3 annotation (Placement(
            transformation(extent={{-60,-80},{-40,-60}}, rotation=0)));
      UserInteraction.Outputs.Bar Bar3(max=100) annotation (Placement(
            transformation(extent={{-20,-70},{0,-50}}, rotation=0)));
      UserInteraction.Outputs.DynamicDiagram DynamicDiagram3 annotation (
          Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
    equation
      connect(NumericValueIO1.Value, NumericValue1.Value) annotation (Line(
            points={{-80,60},{-70,60},{-70,70},{-61,70}}, color={127,0,255}));
      connect(Knob1.Value, NumericValue3.Value) annotation (Line(points={{-80,-80},
              {-70,-80},{-70,-70},{-61,-70}}, color={127,0,255}));
      connect(DynamicDiagram1.Value, NumericValueIO1.Value) annotation (Line(
          points={{20,60},{-80,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(DynamicDiagram2.Value, Slider1.Value) annotation (Line(
          points={{20,0},{-80,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(DynamicDiagram3.Value, Knob1.Value) annotation (Line(
          points={{20,-80},{-80,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Bar1.Value, NumericValueIO1.Value) annotation (Line(
          points={{-21,80},{-70,80},{-70,60},{-80,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Bar2.Value, Slider1.Value) annotation (Line(
          points={{-21,20},{-70,20},{-70,0},{-80,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Bar3.Value, Knob1.Value) annotation (Line(
          points={{-21,-60},{-70,-60},{-70,-80},{-80,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NumericValue2.Value, Slider1.Value) annotation (Line(
          points={{-61,10},{-70,10},{-70,0},{-80,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics));
    end TestInteraction;

    model TestBooleanInteraction

      UserInteraction.Inputs.ToggleButton ToggleButton1(label="On/Off")
        annotation (Placement(transformation(extent={{-40,60},{-20,80}},
              rotation=0)));
      UserInteraction.Inputs.TrigButton TrigButton1(label="On") annotation (
          Placement(transformation(extent={{-100,4},{-80,24}}, rotation=0)));
      UserInteraction.Inputs.TrigButton TrigButton2(label="Off") annotation (
          Placement(transformation(extent={{-100,-36},{-80,-16}}, rotation=0)));
      UserInteraction.Outputs.IndicatorLamp IndicatorLamp1 annotation (
          Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
      UserInteraction.Outputs.IndicatorLamp IndicatorLamp2 annotation (
          Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));

      Logical.Or Or1 annotation (Placement(transformation(extent={{40,0},{60,20}},
              rotation=0)));
      Logical.Pre Pre1 annotation (Placement(transformation(extent={{-30,-80},{
                -10,-60}}, rotation=0)));
      Logical.And And1 annotation (Placement(transformation(extent={{10,-40},{
                30,-20}},rotation=0)));
      Logical.Not Not1 annotation (Placement(transformation(extent={{-60,-36},{
                -40,-16}}, rotation=0)));
    equation
      connect(ToggleButton1.buttonState, IndicatorLamp2.status)
        annotation (Line(points={{-20,70},{0,70}}, color={127,0,255}));
      connect(TrigButton1.buttonOutput, Or1.u1)
        annotation (Line(points={{-80,14},{40,14}}, color={127,0,255}));
      connect(Or1.y, IndicatorLamp1.status)
        annotation (Line(points={{60,10},{80,10}}, color={127,0,255}));
      connect(TrigButton2.buttonOutput, Not1.u)
        annotation (Line(points={{-80,-26},{-60,-26}}, color={127,0,255}));
      connect(Pre1.y, And1.u2) annotation (Line(points={{-10,-70},{0,-70},{0,-34},
              {10,-34}}, color={127,0,255}));
      connect(Not1.y, And1.u1)
        annotation (Line(points={{-40,-26},{10,-26}}, color={127,0,255}));
      connect(And1.y, Or1.u2) annotation (Line(points={{30,-30},{36,-30},{36,6},
              {40,6}}, color={127,0,255}));
      connect(Or1.y, Pre1.u) annotation (Line(points={{60,10},{68,10},{68,-90},
              {-40,-90},{-40,-70},{-30,-70}}, color={127,0,255}));
    end TestBooleanInteraction;

    model TestFilter

      Modelica.Blocks.Continuous.FirstOrder FirstOrder1(T=InputT.Value, k=
            InputK.Value) annotation (Placement(transformation(extent={{-40,0},
                {-20,20}}, rotation=0)));
      Inputs.Slider Slider1 annotation (Placement(transformation(extent={{-100,
                0},{-80,20}},rotation=0)));
      Outputs.DynamicDiagram DynamicDiagram1 annotation (Placement(
            transformation(extent={{20,-30},{100,50}}, rotation=0)));
      ParameterInputs.NumericParameterIO InputT(
        label="T",
        Value=1,
        max=10,
        min=0.1) annotation (Placement(transformation(extent={{-60,30},{-40,50}},
              rotation=0)));
      ParameterInputs.NumericStateIO Inputy(label="Filter state") annotation (
          Placement(transformation(extent={{-20,30},{0,50}}, rotation=0)));
      ParameterInputs.ParameterSlider InputK(max=10) annotation (Placement(
            transformation(extent={{-40,-40},{-20,-20}}, rotation=0)));
    equation
      Inputy.Value = FirstOrder1.y;
      connect(Slider1.Value, FirstOrder1.u)
        annotation (Line(points={{-80,10},{-42,10}}, color={0,0,127}));
      connect(FirstOrder1.y, DynamicDiagram1.Value)
        annotation (Line(points={{-19,10},{20,10}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Text(
                  extent={{-36,-18},{-14,-12}},
                  lineColor={0,0,255},
                  textString="K")}));
    end TestFilter;

    model TestPolygon

      Outputs.Polygon Polygon1(
        minY=-1,
        x=0:0.1:10,
        y=sin(time)*sin(0:0.1:10),
        maxX=10,
        maxY=1,
        color={255,65,65},
        fillColor={0,0,200}) annotation (Placement(transformation(extent={{-100,
                -100},{100,100}}, rotation=0)));
    end TestPolygon;

    model TestSpatialPlot

      Outputs.SpatialPlot SpatialPlot1(
        minY=-1,
        x=0:0.1:10,
        y=sin(time)*sin(0:0.1:10),
        maxX=10,
        maxY=1) annotation (Placement(transformation(extent={{-100,-100},{100,
                100}}, rotation=0)));
    end TestSpatialPlot;

    model TestSpatialPlotWithBackground

      Outputs.SpatialPlotWithBackground SpatialPlotWithBackground1(
        bitmapName="phR134a.png",
        maxX=500,
        bitmapSizeX=1201,
        bitmapSizeY=901,
        bitmapMinX=156,
        bitmapMaxX=1086,
        minY=0,
        maxY=50,
        bitmapMinY=901 - 802,
        bitmapMaxY=901 - 69,
        minX=150,
        x=150:3.5:500,
        y=(0.5 + 0.5*sin(time/5))*(0:0.5:50)) annotation (Placement(
            transformation(extent={{-100,-100},{100,100}}, rotation=0)));
    end TestSpatialPlotWithBackground;

    model TestSpatialPlot2

      Outputs.SpatialPlot2 SpatialPlot21(
        maxX1=10,
        maxY1=1,
        minY1=-1,
        minY2=-1000,
        maxY2=1000,
        x1=0:0.1:10,
        y1=sin(time)*sin(0:0.1:10),
        x2=0:0.25:25,
        y2=1000*cos(2*time)*cos(0:0.25:25),
        maxX2=25,
        color2={0,255,0}) annotation (Placement(transformation(extent={{-100,-100},
                {100,100}}, rotation=0)));

    end TestSpatialPlot2;

  protected
    model TestColorBar

      Outputs.ColorBar ColorBar1(Values={mod(i/50 + 10*time/60, 1) for i in 1:
            50}) annotation (Placement(transformation(extent={{-100,-20},{100,
                20}}, rotation=0)));
    end TestColorBar;

  public
    model TestDynamicObjects

      Outputs.DynamicDiagram DynamicDiagram1(label="Sine functions")
        annotation (Placement(transformation(extent={{-60,0},{-20,40}},
              rotation=0)));
      Outputs.DynamicTrace DynamicTrace1(
        xmin=-1,
        xmax=1,
        ymin=-1,
        ymax=1,
        sizeOfMarker=15,
        traceInterval=1.5,
        numberOfTraces=200) annotation (Placement(transformation(extent={{20,0},
                {60,40}}, rotation=0)));
    equation
      DynamicDiagram1.Value = sin(time) + 0.25*sin(3*time + 1);
      DynamicTrace1.Valuex = sin(time);
      DynamicTrace1.Valuey = sin(3*time + 1);
    end TestDynamicObjects;

    model Meter

    protected
      model VoltageMeter
        input Real angle annotation (Dialog);
        Outputs.PolyLine PolyLine1(
          x={40 - 20*cos(angle),40 - 100*cos(angle)},
          y={-36 + 20*sin(angle),-36 + 100*sin(angle)},
          minX=-100,
          maxX=100,
          minY=-100,
          maxY=100) annotation (layer="icon", Placement(transformation(extent={
                  {-100,-100},{100,100}}, rotation=0)));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Bitmap(
                      __Dymola_preserveAspectRatio=false,
                      extent={{-100,-100},{100,100}},
                      fileName="voltage meter.bmp")}));
      end VoltageMeter;

      VoltageMeter Meter1(PolyLine1(color={0,0,0}), angle=(300 - 280*cos(time/6)
             + 20*sin(15*time))/600*4*arctan(1)/2) annotation (Placement(
            transformation(extent={{-40,-40},{40,40}}, rotation=0)));

    end Meter;

    model RoundTankLevel

    protected
      function roundTankShapePoint
        import Modelica.Math.*;
        constant Real PI=4*arctan(1);
        input Real ymax;
        input Real theta;
        output Real[2] point;
      protected
        Real x;
        Real y;
        Real x1;
        Real y1;
      algorithm
        y1 := sin(theta);
        y := if y1 >= ymax then ymax else y1;
        x1 := cos(arcsin(y));
        x := if theta < PI/2 or theta > 3*PI/2 then x1 else -x1;
        point := {x,y};
      end roundTankShapePoint;

      function roundTankShape
        import Modelica.Math.*;
        input Real ymax;
        input Integer n=30;
      protected
        Real theta[n]=linspace(
                  0,
                  2*4*arctan(1),
                  n);
        Real point[2];
      public
        output Real[n, 2] points;
      algorithm
        for i in 1:n loop
          point := roundTankShapePoint(ymax, theta[i]);
          points[i, 1:2] := point;
        end for;
      end roundTankShape;

      Real x(start=1);
      Outputs.Polygon Polygon1(
        x=100*roundTankShape(ymax=2*x - 1)*{1,0},
        y=100*roundTankShape(ymax=2*x - 1)*{0,1},
        minX=-100,
        maxX=100,
        minY=-100,
        maxY=100) annotation (Placement(transformation(extent={{-60,-60},{60,60}},
              rotation=0)));
    equation
      der(x) = -0.1*x;

    end RoundTankLevel;

    model PieChart

    protected
      model Slices
        Real fractions[4];
      protected
        Real allFractions[5]=cat(
                  1,
                  fractions,
                  {1 - sum(fractions)});
        Real endAngle[5]={{if i <= j then 1 else 0 for i in 1:5} for j in 1:5}*
            allFractions*2*4*arctan(1) annotation (Hide=false);
        Real startAngle[5]=cat(
                  1,
                  {0},
                  endAngle[1:4]) annotation (Hide=false);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Polygon(
                      points=DynamicSelect({{-44,-8},{46,10},{12,60},{-44,-8}},
                  100*transpose({cat(
                        1,
                        {0},
                        cos(startAngle[1]:0.01:endAngle[1])),cat(
                        1,
                        {0},
                        sin(startAngle[1]:0.01:endAngle[1]))})),
                      lineColor={255,0,0},
                      pattern=LinePattern.None,
                      fillColor={255,0,0},
                      fillPattern=FillPattern.Solid),Polygon(
                      points=DynamicSelect({{-44,-8},{46,10},{12,60},{-44,-8}},
                  100*transpose({cat(
                        1,
                        {0},
                        cos(startAngle[2]:0.01:endAngle[2])),cat(
                        1,
                        {0},
                        sin(startAngle[2]:0.01:endAngle[2]))})),
                      lineColor={0,255,0},
                      pattern=LinePattern.None,
                      fillColor={0,255,0},
                      fillPattern=FillPattern.Solid),Polygon(
                      points=DynamicSelect({{-44,-8},{46,10},{12,60},{-44,-8}},
                  100*transpose({cat(
                        1,
                        {0},
                        cos(startAngle[3]:0.01:endAngle[3])),cat(
                        1,
                        {0},
                        sin(startAngle[3]:0.01:endAngle[3]))})),
                      lineColor={0,0,255},
                      pattern=LinePattern.None,
                      fillColor={0,0,255},
                      fillPattern=FillPattern.Solid),Polygon(
                      points=DynamicSelect({{-44,-8},{46,10},{12,60},{-44,-8}},
                  100*transpose({cat(
                        1,
                        {0},
                        cos(startAngle[4]:0.01:endAngle[4])),cat(
                        1,
                        {0},
                        sin(startAngle[4]:0.01:endAngle[4]))})),
                      lineColor={0,255,255},
                      pattern=LinePattern.None,
                      fillColor={0,255,255},
                      fillPattern=FillPattern.Solid),Polygon(
                      points=DynamicSelect({{-44,-8},{46,10},{12,60},{-44,-8}},
                  100*transpose({cat(
                        1,
                        {0},
                        cos(startAngle[5]:0.01:endAngle[5])),cat(
                        1,
                        {0},
                        sin(startAngle[5]:0.01:endAngle[5]))})),
                      lineColor={255,0,255},
                      pattern=LinePattern.None,
                      fillColor={255,0,255},
                      fillPattern=FillPattern.Solid)}));

      end Slices;
    protected
      Slices Slices1 annotation (Placement(transformation(extent={{-100,-100},{
                100,100}}, rotation=0)));
    equation
      Slices1.fractions = {abs(0.5*sin(time/4)),abs(0.25*cos(time/4)),0.2,0.05};
    end PieChart;

    package Fractal
      extends Modelica.Icons.ExamplesPackage;
    protected
      function fractal
        input Real x[:, 2];
        input Real generator[:, 2]=[0, 0; 1/3, 0; 0.5, sqrt(3)/6; 1 - 1/3, 0; 1,
            0];
        input Integer levels=3;
        output Real[sizeFractal(
                size(x, 1),
                size(generator, 1),
                levels), 2] points;
      protected
        Real tempt[sizeFractal(
                size(x, 1),
                size(generator, 1),
                levels - 1), 2];
        Integer sz=size(generator, 1) - 1;
        Real generatorExtended[size(generator, 1), 3]=[generator, ones(size(
            generator, 1))];
      algorithm
        if (levels == 0) then
          points := x;
        else
          tempt := fractal(
                  x,
                  generator,
                  levels - 1);
          for i in 1:size(tempt, 1) - 1 loop
            points[(i - 1)*sz + 1:(i - 1)*sz + sz + 1, 1:2] :=
              generatorExtended*transpose([tempt[i + 1, 1] - tempt[i, 1], tempt[
              i + 1, 2] - tempt[i, 2], tempt[i, 1]; tempt[i + 1, 2] - tempt[i,
              2], tempt[i, 1] - tempt[i + 1, 1], tempt[i, 2]]);
          end for;
        end if;
      end fractal;

      function sizeFractal
        input Integer sizeX;
        input Integer sizeGen;
        input Integer levels;
        output Integer nPoints;
      algorithm
        nPoints := integer((sizeX - 1)*(sizeGen - 1)^levels) + 1;
      end sizeFractal;

    public
      model TestFractal
        Integer levels(start=1) annotation (Hide=false);

        Outputs.Polygon Polygon1(
          x=fractal({{0,0},{60,20},{20,60},{0,0}},
                    {{0,0},{1/3,0},{0.5,sqrt(3)/6},{1 - 1/3,0},{1,0}},
                    4)*{1,0},
          y=fractal({{0,0},{60,20},{20,60},{0,0}},
                    {{0,0},{1/3,0},{0.5,sqrt(3)/6},{1 - 1/3,0},{1,0}},
                    4)*{0,1},
          minX=-100,
          maxX=100,
          minY=-100,
          maxY=100) annotation (Placement(transformation(extent={{-100,-100},{0,
                  0}}, rotation=0)));
      equation

        when sample(0, 2) then
          levels = if pre(levels) >= 5 then 1 else pre(levels) + 1;
        end when;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics={Polygon(points=
                DynamicSelect([0, 0; 60, 20; 20, 60; 0, 0],
                UserInteraction.Examples.Fractal.fractal(
                      {{0,0},{60,20},{20,60},{0,0}},
                      {{0,0},{1/3,0},{0.5,sqrt(3)/6},{1 - 1/3,0},{1,0}},
                      integer(levels))), lineColor={0,0,255})}));
      end TestFractal;
    end Fractal;

    model TemperatureConverter

      // Celsius slider does not work.

      Boolean NewCgiven;
      Boolean NewFgiven;
      Real C;
      Real F;
      Real preC;
      Real prenewC;
      Real prenewF;

    protected
      model NumericDiscreteIO
        output Real Value;
        discrete Real newValue annotation (DDE);
        annotation (Icon(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}),
            graphics={Text(extent={{-100,-40},{100,40}}, textString=
                DynamicSelect("Value", realString(
                      Value,
                      1,
                      1)))},
            interaction={OnMouseDownEditReal(
                      newValue,
                      0,
                      200)}));
      end NumericDiscreteIO;

    public
      NumericDiscreteIO NumericValueC annotation (Placement(transformation(
              extent={{-60,56},{-20,70}}, rotation=0)));
      NumericDiscreteIO NumericValueF annotation (Placement(transformation(
              extent={{20,56},{60,70}}, rotation=0)));
      Outputs.Bar Bar1(
        max=200,
        hideConnector=true,
        input_Value=C) annotation (interaction={OnMouseMoveYSetReal(
                NumericValueC.newValue,
                0,
                200)}, Placement(transformation(extent={{-80,-100},{-60,100}},
              rotation=0)));
      Outputs.Bar Bar2(
        max=200,
        hideConnector=true,
        input_Value=F) annotation (interaction={OnMouseMoveYSetReal(
                NumericValueF.newValue,
                0,
                200)}, Placement(transformation(extent={{60,-100},{80,100}},
              rotation=0)));
    equation
      C = NumericValueC.Value;
      F = NumericValueF.Value;
      NewCgiven = abs(NumericValueC.newValue - pre(prenewC)) > 1e-10;
      NewFgiven = abs(NumericValueF.newValue - pre(prenewF)) > 1e-10;
      0 = if NewCgiven then C - NumericValueC.newValue else if NewFgiven then F
         - NumericValueF.newValue else C - pre(preC);
      F = 32 + 1.8*C;
      when {NewCgiven,NewFgiven} then
        preC = C;
      end when;
      when NewFgiven then
        prenewF = F;
      end when;
      when NewCgiven then
        prenewC = C;
      end when;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(extent={{-70,70},{-10,80}}, textString="Celsius"),
              Text(extent={{8,70},{68,80}}, textString="Fahrenheit")}));
    end TemperatureConverter;

    package Logical
      extends Modelica.Icons.Package;
      model And

        Modelica.Blocks.Interfaces.BooleanInput u1 annotation (Placement(
              transformation(extent={{-110,30},{-90,50}}, rotation=0)));
        Modelica.Blocks.Interfaces.BooleanInput u2 annotation (Placement(
              transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
        Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(
              transformation(extent={{90,-10},{110,10}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle1 annotation (layer="icon",
            Placement(transformation(extent={{-120,20},{-80,60}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle2 annotation (layer="icon",
            Placement(transformation(extent={{-120,-60},{-80,-20}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle3 annotation (layer="icon",
            Placement(transformation(extent={{80,-20},{122,20}}, rotation=0)));
      equation
        IndicatorRectangle1.status = u1;
        IndicatorRectangle2.status = u2;
        IndicatorRectangle3.status = y;
        y = u1 and u2;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,255},
                      fillPattern=FillPattern.None),Text(extent={{-90,50},{90,-50}},
                textString="And")}));
      end And;

      model Or

        Modelica.Blocks.Interfaces.BooleanInput u1 annotation (Placement(
              transformation(extent={{-110,30},{-90,50}}, rotation=0)));
        Modelica.Blocks.Interfaces.BooleanInput u2 annotation (Placement(
              transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
        Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(
              transformation(extent={{90,-10},{110,10}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle1 annotation (layer="icon",
            Placement(transformation(extent={{-120,20},{-80,60}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle2 annotation (layer="icon",
            Placement(transformation(extent={{-120,-60},{-80,-20}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle3 annotation (layer="icon",
            Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      equation
        IndicatorRectangle1.status = u1;
        IndicatorRectangle2.status = u2;
        IndicatorRectangle3.status = y;
        y = u1 or u2;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,255},
                      fillPattern=FillPattern.None),Text(extent={{-90,50},{90,-50}},
                textString="Or")}));
      end Or;

      model Not

        Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
              transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
        Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(
              transformation(extent={{90,-10},{110,10}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle1 annotation (layer="icon",
            Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle2 annotation (layer="icon",
            Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      equation
        IndicatorRectangle1.status = u;
        IndicatorRectangle2.status = y;
        y = not u;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,255},
                      fillPattern=FillPattern.None),Text(extent={{-90,50},{90,-50}},
                textString="Not")}));
      end Not;

      model Pre

        Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
              transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
        Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(
              transformation(extent={{90,-10},{110,10}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle1 annotation (layer="icon",
            Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
        Outputs.IndicatorRectangle IndicatorRectangle2 annotation (layer="icon",
            Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      equation
        IndicatorRectangle1.status = u;
        IndicatorRectangle2.status = y;
        y = pre(u);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,255},
                      fillPattern=FillPattern.None),Text(extent={{-90,50},{90,-50}},
                textString="Pre")}), Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics));
      end Pre;
    end Logical;
  end Examples;

  package BlockAdaptors
    "Components to send signals to the bus or receive signals from the bus"

    extends Modelica.Icons.Library;

    connector Port = ObsoleteModelica3.Blocks.Interfaces.RealSignal annotation
      (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Polygon(
                points={{110,110},{-90,10},{110,-90},{110,110}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Polygon(
                points={{-90,110},{110,10},{-90,-90},{-90,110}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
                points={{-100,100},{100,0},{-100,-100},{-100,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-100,-120},{100,-220}},
                lineColor={0,0,255},
                textString="%name"),Polygon(
                points={{100,100},{-100,0},{100,-100},{100,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid)}),
      Terminal(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100], style(
              color=3, fillColor=3))));

    connector ConnectorReal = Real "'output Real' variable as connector"
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={127,0,255},
                fillColor={127,0,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-132,-100},{132,-198}},
                lineColor={127,0,255},
                textString="%name")}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={127,0,255},
                fillColor={127,0,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-132,-100},{132,-198}},
                lineColor={127,0,255},
                textString="%name")}));

    connector InputReal = input Real "'input Real' variable as connector"
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={127,0,255},
                fillColor={127,0,255},
                fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={127,0,255},
                fillColor={127,0,255},
                fillPattern=FillPattern.Solid)}));

    model Convert "Send Real signal to bus"
      ConnectorReal connectorReal annotation (Placement(transformation(extent={
                {100,-10},{120,10}}, rotation=0)));
      Port port annotation (Placement(transformation(extent={{-140,-20},{-100,
                20}}, rotation=0)));
    equation

      connectorReal = port;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-144,96},{144,46}},
                  lineColor={0,0,0},
                  textString=""),Text(
                  extent={{-100,30},{100,-30}},
                  lineColor={0,0,255},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="Convert")}), Documentation(info="<HTML>
<p>
Converts an InPort connector to a signal which can be connected to an InputReal or OutputReal.
</p>
</HTML>
"));
    end Convert;

    annotation (obsolete="Use Modelica.Blocks directly");
  end BlockAdaptors;

  package Internal
    extends Modelica.Icons.Package;

    partial model Scaling
      parameter Real min=0;
      parameter Real max=1;
      Real unScaled(min=0, max=1);
      Real scaled=unScaled*(max - min) + min;
    end Scaling;

    partial model ScalingParameter
      parameter Real min=0;
      parameter Real max=1;
      parameter Real unScaled(min=0, max=1);
      parameter Real scaled=unScaled*(max - min) + min;
    end ScalingParameter;

    partial model ScalingXY
      parameter Real minX=0;
      parameter Real maxX=1;
      parameter Real minY=0;
      parameter Real maxY=1;
      Real unScaledX(min=0, max=1);
      Real unScaledY(min=0, max=1);
      Real scaledX;
      Real scaledY;
    equation
      scaledX = unScaledX*(maxX - minX) + minX;
      scaledY = unScaledY*(maxY - minY) + minY;
    end ScalingXY;

    partial model ScalingXYVectors
      parameter Real minX=0;
      parameter Real maxX=1;
      parameter Real minY=0;
      parameter Real maxY=1;
      input Real scaledX[:]={1};
      input Real scaledY[size(scaledX, 1)];
      Real unScaledX[size(scaledX, 1)](min=0, max=1);
      Real unScaledY[size(scaledX, 1)](min=0, max=1);
    equation
      scaledX = unScaledX*(maxX - minX) + fill(minX, size(scaledX, 1));
      scaledY = unScaledY*(maxY - minY) + fill(minY, size(scaledY, 1));
    end ScalingXYVectors;

    type Color = Integer[3] (min=0, max=255) "RGB representation of color"
      annotation (preferedView="text", choices(
        choice={255,0,0} "{255,0,0 }    \"red\"",
        choice={255,255,0} "{255,255,0}   \"yellow\"",
        choice={0,255,0} "{0,255,0}     \"green\"",
        choice={0,255,255} "{0,255,255}   \"cyan\"",
        choice={0,0,255} "{0,0,255}     \"blue\"",
        choice={255,0,255} "{255,0,255}   \"magenta\"",
        choice={0,0,0} "{0,0,0}       \"black\"",
        choice={95,95,95} "{95,95,95} \"dark grey\"",
        choice={175,175,175} "{175,175,175} \"grey\"",
        choice={255,255,255} "{255,255,255} \"white\""));

    type HSVColor = Real[3] "HSV representation of color";

    function rgb
      input HSVColor hsv;
      output Color rgb;
    protected
      Real RGB[3];
      Real h=hsv[1];
      Real s=hsv[2];
      Real v=hsv[3];
      Real i;
      Real f;
      Real p;
      Real q;
      Real t;
    algorithm
      if s == 0 then
        RGB := {v,v,v};
      else
        if h == 360 then
          h := 0;
        end if;
        h := h/60;
        i := floor(h);
        f := h - i;
        p := v*(1 - s);
        q := v*(1 - s*f);
        t := v*(1 - s*(1 - f));
        if i == 0 then
          RGB := {v,t,p};
        elseif i == 1 then
          RGB := {q,v,p};
        elseif i == 2 then
          RGB := {p,v,t};
        elseif i == 3 then
          RGB := {p,q,v};
        elseif i == 4 then
          RGB := {t,p,v};
        elseif i == 5 then
          RGB := {v,p,q};

        end if;
        rgb := integer(255*RGB);
      end if;

    end rgb;

  end Internal;

  annotation (
    versionDate="2010-11-05",
    Documentation(info="<html>
<p><b><font style=\"font-size: 12pt; color: #008000; \">Introduction</font></b></p>
<p>This new library for user interaction enables animation of simulation results in the diagram layer in various ways (numbers, bar graphs, plots, etc.). Furthermore, it enables changing parameters and inputs by number, sliders, etc. See the following set of pictures which shows some of the capabilites. </p>
<p><img src=\"../Images/UserInteraction.Examples.TestInteractionD.png\"/> </p>
<p><img src=\"../Images/UserInteraction.Examples.TestFilterD.png\"/> </p>
<p><img src=\"../Images/UserInteraction.Examples.MeterD.png\"/> </p>
<p><img src=\"../Images/UserInteraction.Examples.TestSpatialPlotWithBackgroundD.png\"/> </p>
<p>The basic elements are built into Dymola, for example, the ability to change the appearance of graphical annotations based on simulation results. The exact layout and functionality of the GUI elements is then defined in Modelica code. </p>
<p>The library is not finished. It should be viewed as a prototype, i.e. names and functionality will not be exactely the same in upcoming versions. The documentation is also missing. </p>
<p>By this early distribution we want to show the capabilites that are coming and inspire you to think about how such functionality might be included in Modelica libraries and demos. We should also think about what user input elements we might include in the Modelica specification. </p>
<p>There are plenty of examples in the Examples directory. We think it&apos;s quite obvious how to interact. Go to Simulation mode and push the diagram button to see the Diagram also in Simulation mode (new feature). You should enable Synchronize with realtime in the Experiment Setup / Realtime tab. Set the simulation time to 60 seconds. Otherwise the examples run too fast for you to have time to interact! Set &QUOT;Load result interval&QUOT; to 0.1 and outputInterval=0.05 to get smooth animation. You need to set compiler to MS Visual C++ with DDE. File/Export/Animation supports export of AVI files from the diagram or icon layers, if user interaction objects have been used. </p>
<p><br/><h4>Acknowledgements:</h4></p>
<p><ul>
<li>The design of this library is based on work carried out in the EU RealSim project (Real-time Simulation for Design of Multi-physics Systems) funded by the European Commission within the Information Societies Technology (IST) programme under contract number IST 1999-11979. </li>
</ul></p>
</html>", revisions="<html>
<p><ul>
<li>2004-05-20 Hilding Elmqvist, version 0.5 (first beta version) </li>
<li>2004-06-23 Hilding Elmqvist, version 0.51 (for inclusion in Dymola 5.2b distribution) </li>
<li>2004-11-02 Hans Olsson, version 0.52 (converted to Modelica 2.1 for inclusion in Dymola 5.3a distribution) </li>
<li>2007-11-26 Martin Malmheden, Ulf Nordstr&ouml;m, Hans Olsson, version 0.60 (converted to Modelica 3.0 for inclusion in Dymola 6.2 Beta 6) </li>
<li>2008-07-06 Martin Malmheden, version 0.61 (maintenance update for inclusion in Dymola 6.3 Beta 2) </li>
<li>2010-11-05 Ulf Nordstr&ouml;m, version 0.62 (updated to MSL 3.2)</li>
</ul></p>
</html>"),
    conversion(
      noneFromVersion="0.60",
      from(version="0.51", script="ConvertFromUserInteraction_0.52.mos"),
      from(version="0.52", script="ConvertFromUserInteraction_0.52.mos"),
      from(version="0.53", script="ConvertFromUserInteraction_0.53.mos")));
end UserInteraction;
