within ORNL_AdvSMR.SIInterfaces;
connector SIPowerDensityOutput = output ORNL_AdvSMR.SIunits.PowerDensity
  "Power density output connector (W/m3)" annotation (Icon(graphics={Polygon(
        points={{-100,100},{-100,-100},{100,0},{-100,100}},
        smooth=Smooth.None,
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}), Text(
        extent={{-100,20},{100,-20}},
        pattern=LinePattern.None,
        fillColor={85,170,255},
        fillPattern=FillPattern.Solid,
        lineColor={0,0,255},
        horizontalAlignment=TextAlignment.Left,
        textString="Power")}));
