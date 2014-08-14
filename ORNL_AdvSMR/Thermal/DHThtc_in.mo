within ORNL_AdvSMR.Thermal;
connector DHThtc_in
  "Distributed Heat Terminal with heat transfer coefficient input"
  extends DHT;
  input Modelica.SIunits.CoefficientOfHeatTransfer gamma[N]
    "Heat transfer coefficient";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}));
end DHThtc_in;
