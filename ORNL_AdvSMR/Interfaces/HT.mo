within ORNL_AdvSMR.Interfaces;
connector HT "Heat Terminal"
  ORNL_AdvSMR.SIunits.AbsoluteTemperature T "Temperature at the nodes";
  flow Modelica.SIunits.HeatFlux phi "Heat flux at the nodes";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}));
end HT;
