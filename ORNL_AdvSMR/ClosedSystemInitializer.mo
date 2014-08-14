within ORNL_AdvSMR;
model ClosedSystemInitializer
  "Used for unique initialization of closed-loop systems"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;

  parameter Medium.AbsolutePressure p_start=71e5;
  final parameter Medium.MassFlowRate w_b(fixed=false) = 0;
  Modelica.Fluid.Interfaces.FluidPort_a port(
    redeclare package Medium = Medium,
    m_flow(min=0),
    p(start=p_start)) annotation (Placement(transformation(extent={{-10,-110},{
            10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput initialConditionResidual annotation (
      Placement(transformation(extent={{-100,-20},{-60,20}}),
        iconTransformation(extent={{-100,-10},{-80,10}})));

equation
  0 = port.m_flow + w_b;
  // Mass balance
  port.h_outflow = 0;
  port.Xi_outflow = zeros(Medium.nXi);
initial equation
  0 = homotopy(actual=initialConditionResidual, simplified=port.p - p_start);
  // 0 = initialConditionResidual;
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Polygon(
          points={{-80,50},{-40,90},{40,90},{80,50},{80,-30},{40,-70},{-40,-70},
              {-80,-30},{-80,50}},
          lineColor={255,170,85},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,170,85}),
        Ellipse(
          extent={{70,80},{-70,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,70},{60,-50}},
          lineColor={255,255,170},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="INIT"),
        Text(
          extent={{-40,100},{40,90}},
          lineColor={0,0,0},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid,
          textString="name"),
        Rectangle(
          extent={{-10,-50},{10,-100}},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics));
end ClosedSystemInitializer;
