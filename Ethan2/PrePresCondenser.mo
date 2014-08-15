within Ethan2;
model PrePresCondenser
  parameter Real wop = 12 "nominal mass flow";
  parameter Modelica.SIunits.Pressure pset = 0.08e5 "set pressure";
  Real rhop = 998 "nominal density";
  Real qop = wop/rhop;
  parameter Modelica.SIunits.Length hop = 293 "nominal meters of head";
  inner ThermoPower3.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  PrescribedPressureCondenser Condenser(p=pset)
    annotation (Placement(transformation(extent={{-36,-16},{-16,4}})));
  ThermoPower3.Water.Pump pump(
    n0=100,
    wstart=wop,
    redeclare function flowCharacteristic =
        ThermoPower3.Functions.PumpCharacteristics.quadraticFlow (q_nom={0.5*qop,
            qop,1.5*qop}, head_nom={2*hop,hop,0}),
    w0=wop,
    dp0=100000)
    annotation (Placement(transformation(extent={{28,-42},{48,-22}})));
  Modelica.Blocks.Continuous.PI PI(
    k=0.85,
    T=0.25,
    x_start=-59,
    y_start=100)
    annotation (Placement(transformation(extent={{-6,18},{4,28}})));
  ThermoPower3.Water.FlangeA flangeA
    annotation (Placement(transformation(extent={{-6,90},{14,110}}),
        iconTransformation(extent={{-6,90},{14,110}})));
  ThermoPower3.Water.FlangeB flangeB
    annotation (Placement(transformation(extent={{-6,-110},{14,-90}}),
        iconTransformation(extent={{-6,-110},{14,-90}})));
equation
  connect(Condenser.waterOut, pump.infl) annotation (Line(
      points={{-26,-16},{-12,-16},{-12,-30},{30,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Condenser.y, PI.u) annotation (Line(
      points={{-15,-6},{-10,-6},{-10,23},{-7,23}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PI.y, pump.in_n) annotation (Line(
      points={{4.5,23},{4.5,21.5},{35.4,21.5},{35.4,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Condenser.steamIn, flangeA) annotation (Line(
      points={{-26,4},{-58,4},{-58,100},{4,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flangeB, pump.outfl) annotation (Line(
      points={{4,-100},{66,-100},{66,-25},{44,-25}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                   Ellipse(
              extent={{-86,98},{94,-82}},
              lineColor={0,0,255},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
                             Rectangle(
              extent={{-44,-68},{52,-102}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
        Text(
          extent={{-42,10},{50,-96}},
          lineColor={0,0,255},
          textString="C
")}));
end PrePresCondenser;
