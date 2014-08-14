within ORNL_AdvSMR.BaseClasses.FlowModels;
model NominalTurbulentPipeFlow
  "NominalTurbulentPipeFlow: Quadratic turbulent pressure loss for nominal values"
  extends ORNL_AdvSMR.BaseClasses.FlowModels.PartialGenericPipeFlow(
    redeclare package WallFriction =
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.QuadraticTurbulent,
    use_mu_nominal=not show_Res,
    pathLengths_internal=pathLengths_nominal,
    useUpstreamScheme=false);

  import Modelica.Constants.pi;

  // variables for nominal pressure loss
  Modelica.SIunits.Length[n - 1] pathLengths_nominal
    "pathLengths resulting from nominal pressure loss and geometry";
  Real[n - 1] ks_inv "coefficient for quadratic flow";
  Real[n - 1] zetas "coefficient for quadratic flow";

  // Reynolds Number
  Medium.AbsolutePressure[n - 1] dps_fg_turbulent={(mus_act[i]*diameters[i]*pi/
      4)^2*Re_turbulent^2/(ks_inv[i]*rhos_act[i]) for i in 1:n - 1} if show_Res
    "Start of turbulent flow";

equation
  // Inverse parameterization for WallFriction.QuadraticTurbulent
  // Note: the code should be shared with the WallFriction.QuadraticTurbulent model,
  //       but this required a re-design of the WallFriction interfaces ...
  //   zeta = (length_nominal/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
  //   k_inv = (pi*diameter*diameter)^2/(8*zeta);
  //   k = rho*k_inv "Factor in m_flow = sqrt(k*dp)";
  for i in 1:n - 1 loop
    ks_inv[i] = (m_flow_nominal/nParallel)^2/((dp_nominal/(n - 1) - g*dheights[
      i]*rhos_act[i]))/rhos_act[i];
    zetas[i] = (pi*diameters[i]*diameters[i])^2/(8*ks_inv[i]);
    pathLengths_nominal[i] = zetas[i]*diameters[i]*(2*Modelica.Math.log10(3.7/(
      (roughnesses[i] + roughnesses[i + 1])/2/diameters[i])))^2;
  end for;

  annotation (Documentation(info="<html>
<p>
This model defines the pressure loss assuming turbulent flow for
specified <code>dp_nominal</code> and <code>m_flow_nominal</code>.
It takes into account the fluid density of each flow segment and
obtaines appropriate <code>pathLengths_nominal</code> values
for an inverse parameterization of the
<a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow\">
          TurbulentPipeFlow</a>
model. Per default the upstream and downstream densities are averaged with the setting <code>useUpstreamScheme = false</code>,
in order to avoid discontinuous <code>pathLengths_nominal</code> values in the case of flow reversal.
</p>
<p>
The geometry parameters <code>crossAreas</code>, <code>diameters</code> and <code>roughnesses</code> do
not effect simulation results of this nominal pressure loss model.
As the geometry is specified however, the optionally calculated Reynolds number as well as
<code>m_flows_turbulent</code> and <code>dps_fg_turbulent</code> become meaningful
and can be related to <code>m_flow_small</code> and <code>dp_small</code>.
</p>
<p>
<b>Optional Variables if show_Res</b>
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Type</b></th><th><b>Name</b></th><th><b>Description</b></th></tr>
<tr><td>ReynoldsNumber</td><td>Res[n]</td>
    <td>Reynolds numbers of pipe flow per flow segment</td></tr>
<tr><td>MassFlowRate</td><td>m_flows_turbulent[n-1]</td>
    <td>mass flow rates at start of turbulent region for Re_turbulent=4000</td></tr>
<tr><td>AbsolutePressure</td><td>dps_fg_turbulent[n-1]</td>
    <td>pressure losses due to friction and gravity corresponding to m_flows_turbulent</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li><i>6 Dec 2008</i>
    by Ruediger Franke</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
end NominalTurbulentPipeFlow;
