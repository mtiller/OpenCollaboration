within ORNL_AdvSMR.Interfaces;
model HT_DHT "HT to DHT adaptor"
  parameter Integer N=1 "Number of nodes on DHT side";
  // parameter Modelica.SIunits.Area exchangeSurface "Area of heat transfer surface";

  HT[N] HT_port annotation (Placement(transformation(extent={{-140,-16},{-100,
            24}}, rotation=0)));
  DHT DHT_port(N=N) annotation (Placement(transformation(extent={{100,-40},{120,
            40}}, rotation=0)));

equation
  for i in 1:N loop
    DHT_port.T[i] = HT_port[i].T "Uniform temperature distribution on DHT side";
  end for;
  if N == 1 then
    // Uniform flow distribution
    DHT_port.phi[1] + HT_port[1].phi = 0 "Energy balance";
  else
    // Piecewise linear flow distribution
    sum(DHT_port.phi[1:N] + HT_port[1:N].phi) = 0 "Energy balance";
  end if;
  annotation (Icon(graphics={Polygon(
          points={{-100,100},{-100,-100},{100,100},{-100,100}},
          lineColor={185,0,0},
          fillColor={185,0,0},
          fillPattern=FillPattern.Solid),Polygon(
          points={{100,100},{100,-100},{-100,-100},{100,100}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),Text(
          extent={{-74,10},{24,88}},
          lineColor={255,255,255},
          lineThickness=1,
          textString="HT"),Text(
          extent={{-16,-84},{82,-6}},
          lineColor={255,255,255},
          lineThickness=1,
          textString="DHT"),Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None)}), Diagram(graphics));
end HT_DHT;
