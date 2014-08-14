within ORNL_AdvSMR.Interfaces;
connector HeatPorts_b
  "HeatPort connector with filled, large icon to be used for vectors of HeatPorts (vector dimensions must be added after dragging)"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
  annotation (defaultComponentName="heatPorts_b", Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-50},{200,50}},
        grid={1,1},
        initialScale=0.2), graphics={
        Rectangle(
          extent={{-200,51},{200,-50}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-170,30},{-80,-30}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,30},{40,-30}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{81,30},{170,-30}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end HeatPorts_b;
