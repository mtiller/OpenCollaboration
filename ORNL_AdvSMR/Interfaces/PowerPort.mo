within ORNL_AdvSMR.Interfaces;
connector PowerPort "Expandable thermal power connector"
  parameter Integer N(min=1) = 2 "Number of nodes";
  flow Modelica.SIunits.HeatFlowRate[N] q "Volumetric heat generation rate (W)";

  annotation (
    defaultComponentName="ports_a",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-50,-200},{50,200}},
        grid={1,1},
        initialScale=0.2), graphics={Text(extent={{-30,170},{30,150}},
          textString="%name"),Rectangle(
          extent={{20,-140},{-20,140}},
          lineColor={200,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-10,20},{10,-20}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-10,80},{10,60}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-10,130},{10,120}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-10,-120},{10,-130}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-10,-60},{10,-80}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-50,-200},{50,200}},
        grid={1,1},
        initialScale=0.2), graphics={Rectangle(
          extent={{50,-200},{-50,200}},
          lineColor={200,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-20,40},{20,-40}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-20,-80},{20,-120}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-20,120},{20,80}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-20,180},{20,160}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-20,-160},{20,-180}},
          lineColor={200,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid)}));
end PowerPort;
