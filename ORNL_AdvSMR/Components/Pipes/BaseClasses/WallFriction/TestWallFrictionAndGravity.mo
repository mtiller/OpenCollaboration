within ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction;
model TestWallFrictionAndGravity
  "Pressure loss in pipe due to wall friction and gravity (only for test purposes; if needed use Pipes.StaticPipe instead)"
  extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

  replaceable package WallFriction = QuadraticTurbulent constrainedby
    PartialWallFriction "Characteristic of wall friction" annotation (
      choicesAllMatching=true);

  parameter Modelica.SIunits.Length length "Length of pipe";
  parameter Modelica.SIunits.Diameter diameter
    "Inner (hydraulic) diameter of pipe";
  parameter Modelica.SIunits.Length height_ab=0.0
    "Height(port_b) - Height(port_a)" annotation (Evaluate=true);
  parameter Modelica.SIunits.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation (Dialog(enable=WallFriction.use_roughness));

  parameter Boolean use_nominal=false
    "= true, if mu_nominal and rho_nominal are used, otherwise computed from medium"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.DynamicViscosity mu_nominal=
      Medium.dynamicViscosity(Medium.setState_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default))
    "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)"
    annotation (Dialog(enable=use_nominal));
  parameter Modelica.SIunits.Density rho_nominal=Medium.density_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default)
    "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(enable=use_nominal));

  parameter Boolean show_Re=false
    "= true, if Reynolds number is included for plotting"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean from_dp=true
    " = true, use m_flow = f(dp), otherwise dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.AbsolutePressure dp_small=system.dp_small
    "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head)"
    annotation (Dialog(tab="Advanced",enable=from_dp and WallFriction.use_dp_small));
  Modelica.SIunits.ReynoldsNumber Re=
      CharacteristicNumbers.ReynoldsNumber_m_flow(
      m_flow,
      noEvent(if m_flow > 0 then mu_a else mu_b),
      diameter) if show_Re "Reynolds number of pipe flow";

protected
  Modelica.SIunits.DynamicViscosity mu_a=if not WallFriction.use_mu then 1.e-10
       else (if use_nominal then mu_nominal else Medium.dynamicViscosity(
      state_a));
  Modelica.SIunits.DynamicViscosity mu_b=if not WallFriction.use_mu then 1.e-10
       else (if use_nominal then mu_nominal else Medium.dynamicViscosity(
      state_b));
  Modelica.SIunits.Density rho_a=if use_nominal then rho_nominal else
      Medium.density(state_a);
  Modelica.SIunits.Density rho_b=if use_nominal then rho_nominal else
      Medium.density(state_b);

  Real g_times_height_ab(final unit="m2/s2") = system.g*height_ab
    "Gravitiy times height_ab = dp_grav/d";

  // Currently not in use (means to widen the regularization domain in case of large difference in static head)
  final parameter Boolean use_x_small_staticHead=false
    "Use dp_/m_flow_small_staticHead only if static head actually exists"
    annotation (Evaluate=true);
  /*abs(height_ab)>0*/
  Modelica.SIunits.AbsolutePressure dp_small_staticHead=noEvent(max(dp_small,
      0.015*abs(g_times_height_ab*(rho_a - rho_b))))
    "Heuristic for large discontinuities in static head";
  Modelica.SIunits.MassFlowRate m_flow_small_staticHead=noEvent(max(
      m_flow_small, (-5.55e-7*(rho_a + rho_b)/2 + 5.5e-4)*abs(g_times_height_ab
      *(rho_a - rho_b)))) "Heuristic for large discontinuities in static head";

equation
  if from_dp and not WallFriction.dp_is_zero then
    m_flow = WallFriction.massFlowRate_dp_staticHead(
      dp,
      rho_a,
      rho_b,
      mu_a,
      mu_b,
      length,
      diameter,
      g_times_height_ab,
      roughness,
      if use_x_small_staticHead then dp_small_staticHead else dp_small);
  else
    dp = WallFriction.pressureLoss_m_flow_staticHead(
      m_flow,
      rho_a,
      rho_b,
      mu_a,
      mu_b,
      length,
      diameter,
      g_times_height_ab,
      roughness,
      if use_x_small_staticHead then m_flow_small_staticHead else m_flow_small);
  end if;

  // Energy balance, considering change of potential energy
  port_a.h_outflow = inStream(port_b.h_outflow) + system.g*height_ab;
  port_b.h_outflow = inStream(port_a.h_outflow) - system.g*height_ab;

  annotation (
    defaultComponentName="pipeFriction",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),Rectangle(
          extent={{-100,44},{100,-45}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),Text(
          extent={{-150,80},{150,120}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
This model describes pressure losses due to <b>wall friction</b> in a pipe
and due to gravity.
It is assumed that no mass or energy is stored in the pipe.
Correlations of different complexity and validity can be
seleted via the replaceable package <b>WallFriction</b> (see parameter menu below).
The details of the pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2
</pre>

<p>
are used, where the friction loss factor &lambda; is shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

<p>
By default, the correlations are computed with media data
at the actual time instant.
In order to reduce non-linear equation systems, parameter
<b>use_nominal</b> provides the option
to compute the correlations with constant media values
at the desired operating point. This might speed-up the
simulation and/or might give a more robust simulation.
</p>
</html>"),
    Diagram(coordinateSystem(
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
          textString="diameter"),Line(
          points={{-100,74},{100,74}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.Filled}),Text(
          extent={{-34,92},{34,74}},
          lineColor={0,0,255},
          textString="length")}));
end TestWallFrictionAndGravity;
