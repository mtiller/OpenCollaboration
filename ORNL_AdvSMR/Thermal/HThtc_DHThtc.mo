within ORNL_AdvSMR.Thermal;
model HThtc_DHThtc "HThtc to DHThtc adaptor"
  parameter Integer N=1 "Number of nodes on DHT side";
  parameter Modelica.SIunits.Area exchangeSurface "Heat exchange surface";
  HThtc_in HT_port annotation (Placement(transformation(extent={{-140,-20},{-100,
            22}}, rotation=0)));
  DHThtc DHT_port(final N=1) annotation (Placement(transformation(extent={{100,
            -40},{120,40}}, rotation=0)));
equation
  for i in 1:N loop
    DHT_port.T[i] = HT_port.T "Uniform temperature distribution on DHT side";
    DHT_port.gamma[i] = HT_port.G/exchangeSurface
      "Uniform h.t.c. distribution on DHT side";
  end for;
  sum(DHT_port.phi)*exchangeSurface/N + HT_port.Q_flow = 0 "Energy balance";
  annotation (Icon(graphics={Polygon(
          points={{-100,100},{-100,-100},{100,100},{-100,100}},
          lineColor={185,0,0},
          fillColor={185,0,0},
          fillPattern=FillPattern.Solid),Polygon(
          points={{100,100},{100,-100},{-100,-100},{100,100}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),Text(
          extent={{-92,16},{30,90}},
          lineColor={255,255,255},
          lineThickness=1,
          textString="HT_htc"),Text(
          extent={{-40,-100},{94,-30}},
          lineColor={255,255,255},
          lineThickness=1,
          textString="DHT_htc"),Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None)}), Diagram(graphics));
end HThtc_DHThtc;
