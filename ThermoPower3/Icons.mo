within ThermoPower3;
package Icons "Icons for ThermoPower3 library"
  extends Modelica.Icons.Library;
  package Water "Icons for component using water/steam as working fluid"
    extends Modelica.Icons.Library;
    partial model SourceP

      annotation (Icon(graphics={
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-20,34},{28,-26}},
              lineColor={255,255,255},
              textString="P"),
            Text(extent={{-100,-78},{100,-106}}, textString="%name")}));
    end SourceP;

    partial model SourceW

      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,40},{80,-40}},
              lineColor={0,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-12,-20},{66,0},{-12,20},{34,0},{-12,-20}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,-52},{100,-80}}, textString="%name")}));

    end SourceW;

    partial model Tube

      annotation (Icon(graphics={Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder)}), Diagram(graphics));
    end Tube;

    partial model Mixer

      annotation (Icon(graphics={Ellipse(
              extent={{80,80},{-80,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}), Text(extent={{-100,-84},{100,-110}},
                textString="%name")}), Diagram(graphics));
    end Mixer;

    partial model Tank

      annotation (Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-80}},
              lineColor={0,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-54,60},{54,12}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(extent={{-54,12},{54,-72}}, lineColor={0,0,255})}));
    end Tank;

    partial model Valve

      annotation (Icon(graphics={
            Line(
              points={{0,40},{0,0}},
              color={0,0,0},
              thickness=0.5),
            Polygon(
              points={{-80,40},{-80,-40},{0,0},{-80,40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Polygon(
              points={{80,40},{0,0},{80,-40},{80,40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Rectangle(
              extent={{-20,60},{20,40}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));
    end Valve;

    model FlowJoin

      annotation (Diagram(graphics), Icon(graphics={Polygon(
              points={{-40,60},{0,20},{40,20},{40,-20},{0,-20},{-40,-60},{-40,-20},
                  {-20,0},{-40,20},{-40,60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255})}));
    end FlowJoin;

    model FlowSplit

      annotation (Diagram(graphics), Icon(graphics={Polygon(
              points={{40,60},{0,20},{-40,20},{-40,-20},{0,-20},{40,-60},{40,-20},
                  {22,0},{40,20},{40,60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255})}));
    end FlowSplit;

    model SensThrough

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,-20},{40,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Line(points={{0,20},{0,-20}}, color={0,0,0}),
            Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
            Line(points={{40,60},{60,60}}),
            Text(extent={{-100,-76},{100,-100}}, textString="%name")}));

    end SensThrough;

    model SensP

      annotation (Icon(graphics={
            Line(points={{0,20},{0,-20}}, color={0,0,0}),
            Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
            Line(points={{40,60},{60,60}}),
            Text(extent={{-100,-52},{100,-86}}, textString="%name")}));
    end SensP;

    model Drum

      annotation (Icon(graphics={
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,0},{-60,-6},{-58,-16},{-52,-30},{-44,-42},{-38,-46},
                  {-32,-50},{-22,-56},{-16,-58},{-8,-60},{-6,-60},{0,-60},{6,-60},
                  {12,-58},{22,-56},{30,-52},{36,-48},{42,-42},{48,-36},{52,-28},
                  {58,-18},{60,-8},{60,0},{-60,0}},
              lineColor={128,128,128},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Polygon(
              points={{-60,0},{-58,16},{-50,34},{-36,48},{-26,54},{-16,58},{-6,
                  60},{0,60},{10,60},{20,56},{30,52},{36,48},{46,40},{52,30},{
                  56,22},{58,14},{60,6},{60,0},{-60,0}},
              lineColor={128,128,128},
              fillColor={159,191,223},
              fillPattern=FillPattern.Solid)}));
    end Drum;

    partial model Pump

      annotation (Icon(graphics={
            Polygon(
              points={{-40,-24},{-60,-60},{60,-60},{40,-24},{-40,-24}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,191},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,80},{60,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere),
            Polygon(
              points={{-30,52},{-30,-8},{48,20},{-30,52}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255}),
            Text(extent={{-100,-64},{100,-90}}, textString="%name")}));
    end Pump;

    partial model Accumulator

      annotation (Icon(graphics={
            Rectangle(
              extent={{-60,80},{60,-40}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,100},{60,60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,-20},{60,-60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-52,94},{52,64}},
              lineColor={0,0,191},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-52,22},{52,-40}},
              lineColor={0,0,191},
              fillColor={0,0,191},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-52,80},{52,20}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-52,-24},{52,-54}},
              lineColor={0,0,191},
              pattern=LinePattern.None,
              fillColor={0,0,191},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-4,-58},{4,-86}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-26,-86},{26,-94}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(extent={{-62,-100},{64,-122}}, textString="%name"),
            Polygon(
              points={{-74,86},{-60,72},{-54,78},{-68,92},{-74,86}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));
    end Accumulator;

    partial model PumpMech

      annotation (Icon(graphics={
            Rectangle(
              extent={{54,28},{80,12}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-40,-24},{-60,-60},{60,-60},{40,-24},{-40,-24}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,191},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,80},{60,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere),
            Polygon(
              points={{-30,52},{-30,-8},{48,20},{-30,52}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255}),
            Text(extent={{-100,-64},{100,-90}}, textString="%name")}));
    end PumpMech;

    partial model PressDrop

      annotation (Icon(graphics={Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder), Polygon(
              points={{-80,40},{-42,40},{-20,12},{20,12},{40,40},{80,40},{80,-40},
                  {40,-40},{20,-12},{-20,-12},{-40,-40},{-80,-40},{-80,40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,0,255})}), Diagram(graphics));

    end PressDrop;

    partial model SteamTurbineUnit

      annotation (Icon(graphics={
            Line(
              points={{14,20},{14,42},{38,42},{38,20}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{-100,8},{100,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-14,48},{-14,-48},{14,-20},{14,20},{-14,48}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{38,20},{38,-20},{66,-46},{66,48},{38,20}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-66,20},{-66,-20},{-40,-44},{-40,48},{-66,20}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,70},{-100,70},{-66,70},{-66,20}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-40,46},{-40,70},{26,70},{26,42}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-14,-46},{-14,-70},{66,-70},{66,-46}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{66,-70},{100,-70}},
              color={0,0,255},
              thickness=0.5)}), Diagram(graphics));
    end SteamTurbineUnit;

    partial model Header

      annotation (Icon(graphics={
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{70,70},{-70,-70}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Text(extent={{-100,-84},{100,-110}}, textString="%name")}), Diagram(
            graphics));
    end Header;
  end Water;

  package Gas "Icons for component using water/steam as working fluid"
    extends Modelica.Icons.Library;
    partial model SourceP

      annotation (Icon(graphics={
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-20,34},{28,-26}},
              lineColor={255,255,255},
              textString="P"),
            Text(extent={{-100,-78},{100,-106}}, textString="%name")}));
    end SourceP;

    partial model SourceW

      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,40},{80,-40}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-12,-20},{66,0},{-12,20},{34,0},{-12,-20}},
              lineColor={128,128,128},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,-52},{100,-80}}, textString="%name")}));
    end SourceW;

    partial model Tube

      annotation (Icon(graphics={Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={159,159,223})}), Diagram(graphics));
    end Tube;

    partial model Mixer

      annotation (Icon(graphics={Ellipse(
              extent={{80,80},{-80,-80}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid), Text(extent={{-100,-84},{100,-110}},
                textString="%name")}), Diagram(graphics));
    end Mixer;

    partial model Valve

      annotation (Icon(graphics={
            Line(
              points={{0,40},{0,0}},
              color={0,0,0},
              thickness=0.5),
            Polygon(
              points={{-80,40},{-80,-40},{0,0},{-80,40}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{80,40},{0,0},{80,-40},{80,40}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,60},{20,40}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));
    end Valve;

    model FlowJoin

      annotation (Diagram(graphics), Icon(graphics={Polygon(
              points={{-40,60},{0,20},{40,20},{40,-20},{0,-20},{-40,-60},{-40,-20},
                  {-20,0},{-40,20},{-40,60}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}));
    end FlowJoin;

    model FlowSplit

      annotation (Diagram(graphics), Icon(graphics={Polygon(
              points={{40,60},{0,20},{-40,20},{-40,-20},{0,-20},{40,-60},{40,-20},
                  {22,0},{40,20},{40,60}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}));
    end FlowSplit;

    model SensThrough

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,-20},{40,-60}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Line(points={{0,20},{0,-20}}, color={0,0,0}),
            Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
            Line(points={{40,60},{60,60}}),
            Text(extent={{-100,-76},{100,-100}}, textString="%name")}));
    end SensThrough;

    model SensP

      annotation (Icon(graphics={
            Line(points={{0,20},{0,-20}}, color={0,0,0}),
            Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
            Line(points={{40,60},{60,60}}),
            Text(extent={{-130,-80},{132,-124}}, textString="%name")}));
    end SensP;

    partial model Compressor

      annotation (Icon(graphics={
            Polygon(
              points={{24,26},{30,26},{30,76},{60,76},{60,82},{24,82},{24,26}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-30,76},{-30,56},{-24,56},{-24,82},{-60,82},{-60,76},{-30,
                  76}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,8},{60,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-30,60},{-30,-60},{30,-26},{30,26},{-30,60}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));

    end Compressor;

    partial model Turbine

      annotation (Icon(graphics={
            Polygon(
              points={{-28,76},{-28,28},{-22,28},{-22,82},{-60,82},{-60,76},{-28,
                  76}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{26,56},{32,56},{32,76},{60,76},{60,82},{26,82},{26,56}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,8},{60,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-28,28},{-28,-26},{32,-60},{32,60},{-28,28}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));

    end Turbine;

    partial model GasTurbineUnit

      annotation (Icon(graphics={
            Line(
              points={{-22,26},{-22,48},{22,48},{22,28}},
              color={0,0,0},
              thickness=2.5),
            Rectangle(
              extent={{-100,8},{100,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-80,60},{-80,-60},{-20,-26},{-20,26},{-80,60}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,28},{20,-26},{80,-60},{80,60},{20,28}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-16,64},{16,32}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,0,0})}), Diagram(graphics));
    end GasTurbineUnit;

    partial model Fan

      annotation (Icon(graphics={
            Polygon(
              points={{-38,-24},{-58,-60},{62,-60},{42,-24},{-38,-24}},
              lineColor={95,95,95},
              lineThickness=1,
              fillColor={170,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,80},{60,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={170,170,255}),
            Polygon(
              points={{-30,52},{-30,-8},{48,20},{-30,52}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255}),
            Text(
              extent={{-100,-64},{100,-90}},
              lineColor={95,95,95},
              textString="%name")}));
    end Fan;
  end Gas;

  partial model HeatFlow

    annotation (Icon(graphics={Rectangle(
            extent={{-80,20},{80,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward)}));
  end HeatFlow;

  partial model MetalWall

    annotation (Icon(graphics={Rectangle(
            extent={{-80,20},{80,-20}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid)}));
  end MetalWall;

end Icons;
