within ORNL_AdvSMR.Interfaces;
package EventDriver_package
  partial model PHTS "Interface class for PHTS transient definitions"
    ControlBus controlBus annotation (Placement(transformation(extent={{-10,86},
              {10,106}}), iconTransformation(extent={{-20,70},{20,110}})));
    replaceable Transient1 transient1_1
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    replaceable Transient2 transient2_1
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  equation
    connect(transient1_1.controlBus, controlBus) annotation (Line(
        points={{-70,39},{-70,60},{0,60},{0,96}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(transient2_1.controlBus, controlBus) annotation (Line(
        points={{-30,39},{-30,60},{0,60},{0,96}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,20},{82,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="PHTS")}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end PHTS;

  partial model IHX "Interface class for IHX transient definitions"
    ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
              {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
    annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,20},{82,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="IHX")}));
  end IHX;

  partial model IHTS "Interface class for IHTS transient definitions"
    ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
              {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
    annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,20},{82,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="IHTS")}));
  end IHTS;

  partial model Transient1 "Interface class for transient #1"
    ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
              {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
    annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,20},{82,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="Transient #1")}));
  end Transient1;

  partial model Transient2 "Interface class for transient #2"
    ControlBus controlBus annotation (Placement(transformation(extent={{60,-100},
              {80,-80}}), iconTransformation(extent={{-20,70},{20,110}})));
    annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={128,128,128},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,20},{82,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0},
              textString="Transient #2")}));
  end Transient2;
end EventDriver_package;
