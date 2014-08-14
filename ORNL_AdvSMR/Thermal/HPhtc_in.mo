within ORNL_AdvSMR.Thermal;
connector HPhtc_in "Heat Port with heat transfer coefficient input"
  extends HP;
  input Modelica.SIunits.CoefficientOfHeatTransfer gamma
    "Heat transfer coefficient";
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}));
end HPhtc_in;
