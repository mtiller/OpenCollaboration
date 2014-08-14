within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbines;
model PrescribedSpeed "Constant speed, not dependent on torque"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  Modelica.SIunits.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  Modelica.Blocks.Interfaces.RealInput w_fixed annotation (Placement(
        transformation(extent={{-116,44},{-84,76}}, rotation=0)));
equation
  w = der(phi);
  w = w_fixed;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{0,-100},{0,100}}, color={0,0,255}),
          Text(
          extent={{-116,-16},{128,-40}},
          lineColor={0,0,0},
          textString="%w_fixed")}),
    Documentation(info="<HTML>
<p>
Model of <b>fixed</b> angular verlocity of flange, not dependent on torque.
</p>
</HTML>"));
end PrescribedSpeed;
