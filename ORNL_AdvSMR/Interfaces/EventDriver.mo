within ORNL_AdvSMR.Interfaces;
partial model EventDriver "Interface for plant operations and fault injection"
  ControlBus controlBus annotation (Placement(transformation(extent={{-20,76},{
            20,116}}), iconTransformation(extent={{-20,70},{20,110}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),Text(
          extent={{-80,20},{80,-20}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          textString="Event Driver")}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end EventDriver;
