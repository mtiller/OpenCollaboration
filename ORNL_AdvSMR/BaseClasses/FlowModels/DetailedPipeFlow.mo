within ORNL_AdvSMR.BaseClasses.FlowModels;
model DetailedPipeFlow
  "DetailedPipeFlow: Pipe wall friction in the laminar and turbulent regime (detailed characteristic)"
  extends ORNL_AdvSMR.BaseClasses.FlowModels.PartialGenericPipeFlow(
    redeclare package WallFriction =
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed,
    pathLengths_internal=pathLengths,
    dp_nominal=1e3*dp_small,
    m_flow_nominal=1e2*m_flow_small);

  annotation (Documentation(info="<html>
<p>
This component defines the complete regime of wall friction.
The details are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
The functional relationship of the friction loss factor &lambda; is
displayed in the next figure. Function massFlowRate_dp() defines the \"red curve\"
(\"Swamee and Jain\"), where as function pressureLoss_m_flow() defines the
\"blue curve\" (\"Colebrook-White\"). The two functions are inverses from
each other and give slightly different results in the transition region
between Re = 1500 .. 4000, in order to get explicit equations without
solving a non-linear equation.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

<p>
Additionally to wall friction, this component properly implements static
head. With respect to the latter, two cases can be distinguished. In the case
shown next, the change of elevation with the path from a to b has the opposite
sign of the change of density.</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFrictionStaticHead_case-a.PNG\">

<p>
In the case illustrated second, the change of elevation with the path from a to
b has the same sign of the change of density.</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFrictionStaticHead_case-b.PNG\">

</html>"), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Rectangle(
          extent={{-100,64},{100,-64}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),Rectangle(
          extent={{-100,50},{100,-49}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(
          points={{-60,-49},{-60,50}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.Filled}),Text(
          extent={{-50,16},{6,-10}},
          lineColor={0,0,255},
          textString="diameters"),Line(
          points={{-100,74},{100,74}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.Filled})}));
end DetailedPipeFlow;
