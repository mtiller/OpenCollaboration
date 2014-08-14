within ORNL_AdvSMR.Thermal;
model DHThtc_DHT "DHThtc to DHT adapter"

  DHT DHT_port(N=N) annotation (Placement(transformation(extent={{100,40},{120,
            -40}}, rotation=0)));
  DHThtc_in DHThtc_port(N=N) annotation (Placement(transformation(
        origin={-110,0},
        extent={{40,-10},{-40,10}},
        rotation=90)));

  parameter Integer N(min=1) = 2 "Number of nodes";

equation
  DHT_port.T = DHThtc_port.T;
  DHT_port.phi + DHThtc_port.phi = zeros(N);
  annotation (Diagram(graphics), Icon(graphics={Text(
          extent={{-90,10},{40,100}},
          lineColor={0,0,0},
          lineThickness=1,
          textString="DHThtc"),Text(
          extent={{-10,-92},{96,-20}},
          lineColor={0,0,0},
          textString="DHT"),Rectangle(extent={{-100,100},{100,-100}}, lineColor
          ={255,128,0}),Line(points={{100,100},{-100,-100}}, color={255,128,0})}));
end DHThtc_DHT;
