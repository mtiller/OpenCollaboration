within ORNL_AdvSMR.Components.Pipes;
model StaticPipe "Basic pipe flow model without storage of mass or energy"

  // extending PartialStraightPipe
  extends Implementations.PowerConversionSystem.BaseClasses.PartialStraightPipe;

  // Initialization
  parameter Medium.AbsolutePressure p_a_start=system.p_start
    "Start value of pressure at port a"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
    "Start value of pressure at port b"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.MassFlowRate m_flow_start=system.m_flow_start
    "Start value for mass flow rate"
    annotation (Evaluate=true, Dialog(tab="Initialization"));

  FlowModel flowModel(
    redeclare final package Medium = Medium,
    final n=2,
    states={Medium.setState_phX(
        port_a.p,
        inStream(port_a.h_outflow),
        inStream(port_a.Xi_outflow)),Medium.setState_phX(
        port_b.p,
        inStream(port_b.h_outflow),
        inStream(port_b.Xi_outflow))},
    vs={port_a.m_flow/Medium.density(flowModel.states[1])/flowModel.crossAreas[
        1],-port_b.m_flow/Medium.density(flowModel.states[2])/flowModel.crossAreas[
        2]}/nParallel,
    final momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final allowFlowReversal=allowFlowReversal,
    final p_a_start=p_a_start,
    final p_b_start=p_b_start,
    final m_flow_start=m_flow_start,
    final nParallel=nParallel,
    final pathLengths={length},
    final crossAreas={crossArea,crossArea},
    final dimensions={4*crossArea/perimeter,4*crossArea/perimeter},
    final roughnesses={roughness,roughness},
    final dheights={height_ab},
    final g=system.g) "Flow model" annotation (Placement(transformation(extent=
            {{-38,-18},{38,18}}, rotation=0)));
equation
  // Mass balance
  port_a.m_flow = flowModel.m_flows[1];
  0 = port_a.m_flow + port_b.m_flow;
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  // Energy balance, considering change of potential energy
  // Wb_flow = v*A*dpdx + v*F_fric
  //         = m_flow/d/A * (A*dpdx + A*pressureLoss.dp_fg - F_grav)
  //         = m_flow/d/A * (-A*g*height_ab*d)
  //         = -m_flow*g*height_ab
  port_b.h_outflow = inStream(port_a.h_outflow) - system.g*height_ab;
  port_a.h_outflow = inStream(port_b.h_outflow) + system.g*height_ab;

  annotation (
    defaultComponentName="pipe",
    Documentation(info="<html>
<p>Model of a straight pipe with constant cross section and with steady-state mass, momentum and energy balances, i.e., the model does not store mass or energy.
There exist two thermodynamic states, one at each fluid port. The momentum balance is formulated for the two states, taking into account
momentum flows, friction and gravity. The same result can be obtained by using <a href=\"modelica://Modelica.Fluid.Pipes.DynamicPipe\">DynamicPipe</a> with
steady-state dynamic settings. The intended use is to provide simple connections of vessels or other devices with storage, as it is done in:
<ul>
<li><a href=\"modelica://Modelica.Fluid.Examples.Tanks.EmptyTanks\">Examples.Tanks.EmptyTanks</a></li>
<li><a href=\"modelica://Modelica.Fluid.Examples.InverseParameterization\">Examples.InverseParameterization</a></li>
</ul>

<h4>Numerical Issues</h4>
With the stream connectors the thermodynamic states on the ports are generally defined by models with storage or by sources placed upstream and downstream of the static pipe.
Other non storage components in the flow path may yield to state transformation. Note that this generally leads to nonlinear equation systems if multiple static pipes,
or other flow models without storage, are directly connected.
<br><br><br><br>

</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics));
end StaticPipe;
