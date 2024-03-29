within ORNL_AdvSMR.Thermal;
connector DHT "Distributed Heat Terminal"
  // import aSMR;
  parameter Integer N(min=1) = 1 "Number of nodes";
  ORNL_AdvSMR.SIunits.AbsoluteTemperature T[N] "Temperature at the nodes";
  flow Modelica.SIunits.HeatFlux phi[N] "Heat flux at the nodes";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}));
end DHT;
