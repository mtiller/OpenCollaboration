within ORNL_AdvSMR.BaseClasses.FlowModels;
partial model PartialStaggeredFlowModel
  "Base class for momentum balances in flow models"

  //
  // Internal interface
  // (not exposed to GUI; needs to be hard coded when using this model
  //
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component" annotation (Dialog(tab="Internal Interface",
        enable=false));

  parameter Integer n=2 "Number of discrete flow volumes"
    annotation (Dialog(tab="Internal Interface", enable=false));

  // Inputs
  input Medium.ThermodynamicState[n] states
    "Thermodynamic states along design flow";
  input Modelica.SIunits.Velocity[n] vs "Mean velocities of fluid flow";

  // Geometry parameters and inputs
  parameter Real nParallel "number of identical parallel flow devices"
    annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Geometry"));

  input Modelica.SIunits.Area[n] crossAreas
    "Cross flow areas at segment boundaries";
  input Modelica.SIunits.Length[n] dimensions
    "Characteristic dimensions for fluid flow (diameters for pipe flow)";
  input Modelica.SIunits.Height[n] roughnesses
    "Average height of surface asperities";

  // Static head
  input Modelica.SIunits.Length[n - 1] dheights
    "Height(states[2:n]) - Height(states[1:n-1])";

  parameter Modelica.SIunits.Acceleration g=system.g
    "Constant gravity acceleration" annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Static head"));

  // Assumptions
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (states[1] -> states[n+1])"
    annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Assumptions"), Evaluate=true);
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balance" annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Assumptions"), Evaluate=true);

  // Initialization
  parameter Medium.MassFlowRate m_flow_start=system.m_flow_start
    "Start value of mass flow rates" annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Initialization"));
  parameter Medium.AbsolutePressure p_a_start
    "Start value for p[1] at design inflow" annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Initialization"));
  parameter Medium.AbsolutePressure p_b_start
    "Start value for p[n+1] at design outflow" annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Initialization"));

  //
  // Implementation of momentum balance
  //
  extends Modelica.Fluid.Interfaces.PartialDistributedFlow(final m=n - 1);

  // Advanced parameters
  parameter Boolean useUpstreamScheme=true
    "= false to average upstream and downstream properties across flow segments"
    annotation (Dialog(group="Advanced"), Evaluate=true);

  parameter Boolean use_Ib_flows=momentumDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState
    "= true to consider differences in flow of momentum through boundaries"
    annotation (Dialog(group="Advanced"), Evaluate=true);

  // Variables
  Modelica.SIunits.Density[n] rhos=if use_rho_nominal then fill(rho_nominal, n)
       else Medium.density(states);
  Modelica.SIunits.Density[n - 1] rhos_act "Actual density per segment";

  Modelica.SIunits.DynamicViscosity[n] mus=if use_mu_nominal then fill(
      mu_nominal, n) else Medium.dynamicViscosity(states);
  Modelica.SIunits.DynamicViscosity[n - 1] mus_act
    "Actual viscosity per segment";

  // Variables
  Modelica.SIunits.Pressure[n - 1] dps_fg(each start=(p_a_start - p_b_start)/(n
         - 1)) "pressure drop between states";

  // Reynolds Number
  parameter Modelica.SIunits.ReynoldsNumber Re_turbulent=4000
    "Start of turbulent regime, depending on type of flow device";
  parameter Boolean show_Res=false
    "= true, if Reynolds numbers are included for plotting"
    annotation (Evaluate=true, Dialog(group="Diagnostics"));
  Modelica.SIunits.ReynoldsNumber[n] Res=
      Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      vs,
      rhos,
      mus,
      dimensions) if show_Res "Reynolds numbers";
  Medium.MassFlowRate[n - 1] m_flows_turbulent={nParallel*(Modelica.Constants.pi
      /4)*0.5*(dimensions[i] + dimensions[i + 1])*mus_act[i]*Re_turbulent for i
       in 1:n - 1} if show_Res "Start of turbulent flow";
protected
  parameter Boolean use_rho_nominal=false
    "= true, if rho_nominal is used, otherwise computed from medium"
    annotation (Dialog(group="Advanced"), Evaluate=true);
  parameter Modelica.SIunits.Density rho_nominal=Medium.density_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default)
    "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced",enable=use_rho_nominal));

  parameter Boolean use_mu_nominal=false
    "= true, if mu_nominal is used, otherwise computed from medium"
    annotation (Dialog(group="Advanced"), Evaluate=true);
  parameter Modelica.SIunits.DynamicViscosity mu_nominal=
      Medium.dynamicViscosity(Medium.setState_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default))
    "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)"
    annotation (Dialog(group="Advanced",enable=use_mu_nominal));

equation
  if not allowFlowReversal then
    rhos_act = rhos[1:n - 1];
    mus_act = mus[1:n - 1];
  elseif not useUpstreamScheme then
    rhos_act = 0.5*(rhos[1:n - 1] + rhos[2:n]);
    mus_act = 0.5*(mus[1:n - 1] + mus[2:n]);
  else
    for i in 1:n - 1 loop
      rhos_act[i] = noEvent(if m_flows[i] > 0 then rhos[i] else rhos[i + 1]);
      mus_act[i] = noEvent(if m_flows[i] > 0 then mus[i] else mus[i + 1]);
    end for;
  end if;

  if use_Ib_flows then
    Ib_flows = {rhos[i]*vs[i]*vs[i]*crossAreas[i] - rhos[i + 1]*vs[i + 1]*vs[i
       + 1]*crossAreas[i + 1] for i in 1:n - 1};
    // alternatively use densities rhos_act of actual streams, together with mass flow rates,
    // not conserving momentum if fluid density changes between flow segments:
    //Ib_flows = {((rhos[i]*vs[i])^2*crossAreas[i] - (rhos[i+1]*vs[i+1])^2*crossAreas[i+1])/rhos_act[i] for i in 1:n-1};
  else
    Ib_flows = zeros(n - 1);
  end if;

  Fs_p = nParallel*{0.5*(crossAreas[i] + crossAreas[i + 1])*(Medium.pressure(
    states[i + 1]) - Medium.pressure(states[i])) for i in 1:n - 1};

  // Note: the equation is written for dps_fg instead of Fs_fg to help the translator
  dps_fg = {Fs_fg[i]/nParallel*2/(crossAreas[i] + crossAreas[i + 1]) for i in 1
    :n - 1};

  annotation (Documentation(info="<html>
<p>
This paratial model defines a common interface for <code>m=n-1</code> flow models between <code>n</code> device segments.
The flow models provide a steady-state or dynamic momentum balance using an upwind discretization scheme per default.
Extending models must add pressure loss terms for friction and gravity.
</p>
<p>
The fluid is specified in the interface with the thermodynamic <code>states[n]</code> for a given <code>Medium</code> model.
The geometry is specified with the <code>pathLengths[n-1]</code> between the device segments as well as
with the <code>crossAreas[n]</code> and the <code>roughnesses[n]</code> of the device segments.
Moreover the fluid flow is characterized for different types of devices by the characteristic <code>dimensions[n]</code>
and the average velocities <code>vs[n]</code> of fluid flow in the device segments.
See <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>
for examplary definitions.
</p>
<p>
The parameter <code>Re_turbulent</code> can be specified for the least mass flow rate of the turbulent regime.
It defaults to 4000, which is appropriate for pipe flow.
The <code>m_flows_turbulent[n-1]</code> resulting from <code>Re_turbulent</code> can optionally be calculated together with the Reynolds numbers
<code>Res[n]</code> of the device segments (<code>show_Res=true</code>).
</p>
<p>
Using the thermodynamic states[n] of the device segments, the densities rhos[n] and the dynamic viscosities mus[n]
of the segments as well as the actual densities rhos_act[n-1] and the actual viscosities mus_act[n-1] of the flows are predefined
in this base model. Note that no events are raised on flow reversal. This needs to be treated by an extending model,
e.g., with numerical smoothing or by raising events as appropriate.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Line(
          points={{-80,-50},{-80,50},{80,-50},{80,50}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=1),Text(
          extent={{-40,-50},{40,-90}},
          lineColor={0,0,0},
          textString="%name")}));
end PartialStaggeredFlowModel;
