within ORNL_AdvSMR.Thermal;
connector DHThtc
  "Distributed Heat Terminal with heat transfer coefficient output"
  extends DHT;
  output Modelica.SIunits.CoefficientOfHeatTransfer gamma[N]
    "Heat transfer coefficient";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}));
end DHThtc;
