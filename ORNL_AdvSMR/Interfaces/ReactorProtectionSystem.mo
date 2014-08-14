within ORNL_AdvSMR.Interfaces;
partial model ReactorProtectionSystem
  "Interface for reactor protection system (RPS)"
  ControlBus controlBus
    annotation (Placement(transformation(extent={{-20,70},{20,110}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),Text(
          extent={{-98,20},{98,-14}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control System",
          lineColor={0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics));
end ReactorProtectionSystem;
