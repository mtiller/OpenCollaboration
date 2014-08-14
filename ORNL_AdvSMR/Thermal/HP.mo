within ORNL_AdvSMR.Thermal;
connector HP "Heat Port"
  ORNL_AdvSMR.SIunits.AbsoluteTemperature T "Temperature";
  flow Modelica.SIunits.HeatFlux phi "Heat flux";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}));
end HP;
