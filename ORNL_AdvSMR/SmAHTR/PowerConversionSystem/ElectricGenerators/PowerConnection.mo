within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
connector PowerConnection "Electrical power connector"
  flow Modelica.SIunits.Power W "Active power";
  Modelica.SIunits.Frequency f "Frequency";
  annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  lineThickness=0.5,
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid)}));
end PowerConnection;
