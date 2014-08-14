within ORNL_AdvSMR.Interfaces;
connector HeatPorts_a
  "HeatPort connector with filled, large icon to be used for vectors of HeatPorts (vector dimensions must be added after dragging)"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
  annotation (defaultComponentName="heatPorts_a", Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-50},{200,50}},
        grid={1,1},
        initialScale=0.2), graphics={Rectangle(
          extent={{-201,50},{200,-50}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-171,45},{-83,-45}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-45,45},{43,-45}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{82,45},{170,-45}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid)}));
end HeatPorts_a;
