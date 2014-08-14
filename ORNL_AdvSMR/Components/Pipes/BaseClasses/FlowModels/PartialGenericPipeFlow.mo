within ORNL_AdvSMR.Components.Pipes.BaseClasses.FlowModels;
partial model PartialGenericPipeFlow
  "GenericPipeFlow: Pipe flow pressure loss and gravity with replaceable WallFriction package"
  import aSMR = ORNL_AdvSMR;
  extends PartialStaggeredFlowModel(final Re_turbulent=4000);

  replaceable package WallFriction =
      ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction.Detailed
    constrainedby
    ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction.PartialWallFriction
    "Wall friction model" annotation (
    Dialog(group="Wall friction"),
    choicesAllMatching=true,
    __Dymola_editButton=false);

  input Modelica.SIunits.Length[n - 1] pathLengths_internal
    "pathLengths used internally; to be defined by extending class";

  // Parameters
  parameter Modelica.SIunits.AbsolutePressure dp_nominal
    "Nominal pressure loss (for nominal models)";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Mass flow rate for dp_nominal (for nominal models)";
  parameter Boolean from_dp=momentumDynamics >= Modelica.Fluid.Types.Dynamics.SteadyStateInitial
    " = true, use m_flow = f(dp), otherwise dp = f(m_flow)"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.AbsolutePressure dp_small=system.dp_small
    "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head)"
    annotation (Dialog(enable=from_dp and WallFriction.use_dp_small));
  parameter Modelica.SIunits.MassFlowRate m_flow_small=system.m_flow_small
    "Within regularization if |m_flows| < m_flow_small (may be wider for large discontinuities in static head)"
    annotation (Dialog(enable=not from_dp and WallFriction.use_m_flow_small));

  final parameter Boolean constantPressureLossCoefficient=use_rho_nominal and (
      use_mu_nominal or not WallFriction.use_mu)
    "= true if the pressure loss does not depend on fluid states"
    annotation (Evaluate=true);
  final parameter Boolean continuousFlowReversal=(not useUpstreamScheme) or
      constantPressureLossCoefficient or not allowFlowReversal
    "= true if the pressure loss is continuous around zero flow"
    annotation (Evaluate=true);

  Modelica.SIunits.Length[n - 1] diameters=0.5*(dimensions[1:n - 1] +
      dimensions[2:n]) "mean diameters between segments";

equation
  for i in 1:n - 1 loop
    assert(m_flows[i] > -m_flow_small or allowFlowReversal,
      "Reverting flow occurs even though allowFlowReversal is false");
  end for;

  if continuousFlowReversal then
    // simple regularization
    if from_dp and not WallFriction.dp_is_zero then
      m_flows = WallFriction.massFlowRate_dp(
        dps_fg - {g*dheights[i]*rhos_act[i] for i in 1:n - 1},
        rhos_act,
        rhos_act,
        mus_act,
        mus_act,
        pathLengths_internal,
        diameters,
        (roughnesses[1:n - 1] + roughnesses[2:n])/2,
        dp_small)*nParallel;
    else
      dps_fg = WallFriction.pressureLoss_m_flow(
        m_flows/nParallel,
        rhos_act,
        rhos_act,
        mus_act,
        mus_act,
        pathLengths_internal,
        diameters,
        (roughnesses[1:n - 1] + roughnesses[2:n])/2,
        m_flow_small/nParallel) + {g*dheights[i]*rhos_act[i] for i in 1:n - 1};
    end if;
  else
    // regularization for discontinuous flow reversal and static head
    if from_dp and not WallFriction.dp_is_zero then
      m_flows = WallFriction.massFlowRate_dp_staticHead(
        dps_fg,
        rhos[1:n - 1],
        rhos[2:n],
        mus[1:n - 1],
        mus[2:n],
        pathLengths_internal,
        diameters,
        g*dheights,
        (roughnesses[1:n - 1] + roughnesses[2:n])/2,
        dp_small/n)*nParallel;
    else
      dps_fg = WallFriction.pressureLoss_m_flow_staticHead(
        m_flows/nParallel,
        rhos[1:n - 1],
        rhos[2:n],
        mus[1:n - 1],
        mus[2:n],
        pathLengths_internal,
        diameters,
        g*dheights,
        (roughnesses[1:n - 1] + roughnesses[2:n])/2,
        m_flow_small/nParallel);
    end if;
  end if;

  annotation (Documentation(info="<html>
<p>
This model describes pressure losses due to <b>wall friction</b> in a pipe
and due to <b>gravity</b>.
Correlations of different complexity and validity can be
seleted via the replaceable package <b>WallFriction</b> (see parameter menu below).
The details of the pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2.
</pre>

<p>

By default, the correlations are computed with media data at the actual time instant.
In order to reduce non-linear equation systems, the parameters
<b>use_mu_nominal</b> and <b>use_rho_nominal</b> provide the option
to compute the correlations with constant media values
at the desired operating point. This might speed-up the
simulation and/or might give a more robust simulation.
</p>
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
          arrow={Arrow.Filled,Arrow.Filled}),Text(
          extent={{-32,93},{32,74}},
          lineColor={0,0,255},
          textString="pathLengths")}));
end PartialGenericPipeFlow;
