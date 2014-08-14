within ThermoPower3;
model System "System wide properties"
  // Assumptions
  parameter Boolean allowFlowReversal=true
    "= false to restrict to design flow direction (flangeA -> flangeB)"
    annotation (Evaluate=true);
  parameter ThermoPower3.Choices.System.Dynamics Dynamics=Choices.System.Dynamics.DynamicFreeInitial;
  annotation (
    defaultComponentName="system",
    defaultComponentPrefixes="inner",
    Icon(graphics={Polygon(
          points={{-100,60},{-60,100},{60,100},{100,60},{100,-60},{60,-100},{-60,
              -100},{-100,-60},{-100,60}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-80,40},{80,-20}},
          lineColor={0,0,255},
          textString="system")}));
end System;
