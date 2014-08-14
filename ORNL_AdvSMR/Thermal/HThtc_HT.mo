within ORNL_AdvSMR.Thermal;
model HThtc_HT "HThtc to HT adaptor"

  HT HT_port annotation (Placement(transformation(extent={{100,-20},{140,20}},
          rotation=0)));
  HThtc_in HThtc_port annotation (Placement(transformation(extent={{-140,-20},{
            -100,20}}, rotation=0)));
equation
  HT_port.T = HThtc_port.T;
  HT_port.Q_flow = HThtc_port.Q_flow;
  annotation (Diagram(graphics), Icon(graphics={Text(
          extent={{-86,-4},{32,96}},
          lineColor={0,0,0},
          lineThickness=1,
          textString="HThtc"),Text(
          extent={{-10,-92},{96,-20}},
          lineColor={0,0,0},
          textString="HT"),Rectangle(extent={{-100,100},{100,-100}}, lineColor=
          {255,0,0}),Line(points={{100,100},{-100,-100}}, color={255,0,0})}));
end HThtc_HT;
