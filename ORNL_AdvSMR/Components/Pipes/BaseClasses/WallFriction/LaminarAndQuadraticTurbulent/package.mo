within ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction;
package LaminarAndQuadraticTurbulent "Pipe wall friction in the laminar and quadratic turbulent regime (simple characteristic)"


extends PartialWallFriction(
  final use_mu=true,
  final use_roughness=true,
  final use_dp_small=true,
  final use_m_flow_small=true);

import ln = Modelica.Math.log "Logarithm, base e";
import Modelica.Math.log10 "Logarithm, base 10";
import Modelica.Math.exp "Exponential function";
import Modelica.Constants.pi;


redeclare function extends massFlowRate_dp
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
  import Modelica.Math;
protected
  constant Real pi=Modelica.Constants.pi;
  constant Real Re_turbulent=4000 "Start of turbulent regime";
  Real zeta;
  Real k0;
  Real k_inv;
  Real yd0 "Derivative of m_flow=m_flow(dp) at zero";
  Modelica.SIunits.AbsolutePressure dp_turbulent;
  algorithm
  /*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*mu)
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
   dp_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2

   The start of the turbulent region is computed with mean values
   of dynamic viscosity mu and density rho. Otherwise, one has
   to introduce different "delta" values for both flow directions.
   In order to simplify the approach, only one delta is used.

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)

   In order that the derivative of dp=f(m_flow) is continuous
   at m_flow=0, the mean values of mu and d are used in the
   laminar region: mu/rho = (mu_a + mu_b)/(rho_a + rho_b)
   If data.zetaLaminarKnown = false then mu_a and mu_b are potentially zero
   (because dummy values) and therefore the division is only performed
   if zetaLaminarKnown = true.
*/
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");
  zeta := (length/diameter)/(2*Math.log10(3.7/(roughness/diameter)))^2;
  k0 := 128*length/(pi*diameter^4);
  k_inv := (pi*diameter*diameter)^2/(8*zeta);
  yd0 := (rho_a + rho_b)/(k0*(mu_a + mu_b));
  dp_turbulent := ((mu_a + mu_b)*diameter*pi/8)^2*Re_turbulent^2/(k_inv*(rho_a
     + rho_b)/2);
  m_flow := Modelica.Fluid.Utilities.regRoot2(
      dp,
      dp_turbulent,
      rho_a*k_inv,
      rho_b*k_inv,
      use_yd0=true,
      yd0=yd0);
  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
  end massFlowRate_dp;


redeclare function extends pressureLoss_m_flow
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
  import Modelica.Math;

protected
  constant Real pi=Modelica.Constants.pi;
  constant Real Re_turbulent=4000 "Start of turbulent regime";
  Real zeta;
  Real k0;
  Real k;
  Real yd0 "Derivative of dp = f(m_flow) at zero";
  Modelica.SIunits.MassFlowRate m_flow_turbulent
    "The turbulent region is: |m_flow| >= m_flow_turbulent";

  algorithm
  /*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*mu)
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
   dp_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2

   The start of the turbulent region is computed with mean values
   of dynamic viscosity mu and density rho. Otherwise, one has
   to introduce different "delta" values for both flow directions.
   In order to simplify the approach, only one delta is used.

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)

   In order that the derivative of dp=f(m_flow) is continuous
   at m_flow=0, the mean values of mu and d are used in the
   laminar region: mu/rho = (mu_a + mu_b)/(rho_a + rho_b)
*/
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");
  zeta := (length/diameter)/(2*Math.log10(3.7/(roughness/diameter)))^2;
  k0 := 128*length/(pi*diameter^4);
  k := 8*zeta/(pi*diameter*diameter)^2;
  yd0 := k0*(mu_a + mu_b)/(rho_a + rho_b);
  m_flow_turbulent := (pi/8)*diameter*(mu_a + mu_b)*Re_turbulent;
  dp := Modelica.Fluid.Utilities.regSquare2(
      m_flow,
      m_flow_turbulent,
      k/rho_a,
      k/rho_b,
      use_yd0=true,
      yd0=yd0);
  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow;


redeclare function extends massFlowRate_dp_staticHead
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"
  import Modelica.Math;

protected
  Real Delta=roughness/diameter "Relative roughness";
  Modelica.SIunits.ReynoldsNumber Re1=745*exp(if Delta <= 0.0065 then 1 else
      0.0065/Delta) "Boundary between laminar regime and transition";
  constant Modelica.SIunits.ReynoldsNumber Re2=4000
    "Boundary between transition and turbulent regime";

  Modelica.SIunits.Pressure dp_a
    "Upper end of regularization domain of the m_flow(dp) relation";
  Modelica.SIunits.Pressure dp_b
    "Lower end of regularization domain of the m_flow(dp) relation";

  Modelica.SIunits.MassFlowRate m_flow_a
    "Value at upper end of regularization domain";
  Modelica.SIunits.MassFlowRate m_flow_b
    "Value at lower end of regularization domain";

  Modelica.SIunits.MassFlowRate dm_flow_ddp_fric_a
    "Derivative at upper end of regularization domain";
  Modelica.SIunits.MassFlowRate dm_flow_ddp_fric_b
    "Derivative at lower end of regularization domain";

  Modelica.SIunits.Pressure dp_grav_a=g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Modelica.SIunits.Pressure dp_grav_b=g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";

  // Properly define zero mass flow conditions
  Modelica.SIunits.MassFlowRate m_flow_zero=0;
  Modelica.SIunits.Pressure dp_zero=(dp_grav_a + dp_grav_b)/2;
  Real dm_flow_ddp_fric_zero;
  algorithm
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");

  dp_a := max(dp_grav_a, dp_grav_b) + dp_small;
  dp_b := min(dp_grav_a, dp_grav_b) - dp_small;

  if dp >= dp_a then
    // Positive flow outside regularization
    m_flow := Internal.m_flow_of_dp_fric(
        dp - dp_grav_a,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta);
  elseif dp <= dp_b then
    // Negative flow outside regularization
    m_flow := Internal.m_flow_of_dp_fric(
        dp - dp_grav_b,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta);
  else
    // Regularization parameters
    (m_flow_a,dm_flow_ddp_fric_a) := Internal.m_flow_of_dp_fric(
        dp_a - dp_grav_a,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta);
    (m_flow_b,dm_flow_ddp_fric_b) := Internal.m_flow_of_dp_fric(
        dp_b - dp_grav_b,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta);
    // Include a properly defined zero mass flow point
    // Obtain a suitable slope from the linear section slope c (value of m_flow is overwritten later)
    (m_flow,dm_flow_ddp_fric_zero) := Modelica.Fluid.Utilities.regFun3(
        dp_zero,
        dp_b,
        dp_a,
        m_flow_b,
        m_flow_a,
        dm_flow_ddp_fric_b,
        dm_flow_ddp_fric_a);
    // Do regularization
    if dp > dp_zero then
      m_flow := Modelica.Fluid.Utilities.regFun3(
          dp,
          dp_zero,
          dp_a,
          m_flow_zero,
          m_flow_a,
          dm_flow_ddp_fric_zero,
          dm_flow_ddp_fric_a);
    else
      m_flow := Modelica.Fluid.Utilities.regFun3(
          dp,
          dp_b,
          dp_zero,
          m_flow_b,
          m_flow_zero,
          dm_flow_ddp_fric_b,
          dm_flow_ddp_fric_zero);
    end if;
  end if;
  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
  end massFlowRate_dp_staticHead;


redeclare function extends pressureLoss_m_flow_staticHead
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"
  import Modelica.Math;

protected
  Real Delta=roughness/diameter "Relative roughness";
  Modelica.SIunits.ReynoldsNumber Re1=745*exp(if Delta <= 0.0065 then 1 else
      0.0065/Delta) "Boundary between laminar regime and transition";
  constant Modelica.SIunits.ReynoldsNumber Re2=4000
    "Boundary between transition and turbulent regime";

  Modelica.SIunits.MassFlowRate m_flow_a
    "Upper end of regularization domain of the dp(m_flow) relation";
  Modelica.SIunits.MassFlowRate m_flow_b
    "Lower end of regularization domain of the dp(m_flow) relation";

  Modelica.SIunits.Pressure dp_a "Value at upper end of regularization domain";
  Modelica.SIunits.Pressure dp_b "Value at lower end of regularization domain";

  Modelica.SIunits.Pressure dp_grav_a=g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Modelica.SIunits.Pressure dp_grav_b=g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";

  Real ddp_dm_flow_a
    "Derivative of pressure drop with mass flow rate at m_flow_a";
  Real ddp_dm_flow_b
    "Derivative of pressure drop with mass flow rate at m_flow_b";

  // Properly define zero mass flow conditions
  Modelica.SIunits.MassFlowRate m_flow_zero=0;
  Modelica.SIunits.Pressure dp_zero=(dp_grav_a + dp_grav_b)/2;
  Real ddp_dm_flow_zero;

  algorithm
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");

  m_flow_a := if dp_grav_a < dp_grav_b then Internal.m_flow_of_dp_fric(
      dp_grav_b - dp_grav_a,
      rho_a,
      rho_b,
      mu_a,
      mu_b,
      length,
      diameter,
      Re1,
      Re2,
      Delta) + m_flow_small else m_flow_small;
  m_flow_b := if dp_grav_a < dp_grav_b then Internal.m_flow_of_dp_fric(
      dp_grav_a - dp_grav_b,
      rho_a,
      rho_b,
      mu_a,
      mu_b,
      length,
      diameter,
      Re1,
      Re2,
      Delta) - m_flow_small else -m_flow_small;

  if m_flow >= m_flow_a then
    // Positive flow outside regularization
    dp := Internal.dp_fric_of_m_flow(
        m_flow,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta) + dp_grav_a;
  elseif m_flow <= m_flow_b then
    // Negative flow outside regularization
    dp := Internal.dp_fric_of_m_flow(
        m_flow,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta) + dp_grav_b;
  else
    // Regularization parameters
    (dp_a,ddp_dm_flow_a) := Internal.dp_fric_of_m_flow(
        m_flow_a,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta);
    dp_a := dp_a + dp_grav_a "Adding dp_grav to dp_fric to get dp";
    (dp_b,ddp_dm_flow_b) := Internal.dp_fric_of_m_flow(
        m_flow_b,
        rho_a,
        rho_b,
        mu_a,
        mu_b,
        length,
        diameter,
        Re1,
        Re2,
        Delta);
    dp_b := dp_b + dp_grav_b "Adding dp_grav to dp_fric to get dp";
    // Include a properly defined zero mass flow point
    // Obtain a suitable slope from the linear section slope c (value of dp is overwritten later)
    (dp,ddp_dm_flow_zero) := Modelica.Fluid.Utilities.regFun3(
        m_flow_zero,
        m_flow_b,
        m_flow_a,
        dp_b,
        dp_a,
        ddp_dm_flow_b,
        ddp_dm_flow_a);
    // Do regularization
    if m_flow > m_flow_zero then
      dp := Modelica.Fluid.Utilities.regFun3(
          m_flow,
          m_flow_zero,
          m_flow_a,
          dp_zero,
          dp_a,
          ddp_dm_flow_zero,
          ddp_dm_flow_a);
    else
      dp := Modelica.Fluid.Utilities.regFun3(
          m_flow,
          m_flow_b,
          m_flow_zero,
          dp_b,
          dp_zero,
          ddp_dm_flow_b,
          ddp_dm_flow_zero);
    end if;
  end if;
  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow_staticHead;


annotation (Documentation(info="<html>
<p>
This component defines the quadratic turbulent regime of wall friction:
dp = k*m_flow*|m_flow|, where \"k\" depends on density and the roughness
of the pipe and is no longer a function of the Reynolds number.
This relationship is only valid for large Reynolds numbers.
At Re=4000, a polynomial is constructed that approaches
the constant &lambda; (for large Reynolds-numbers) at Re=4000
smoothly and has a derivative at zero mass flow rate that is
identical to laminar wall friction.
</p>
</html>"));
end LaminarAndQuadraticTurbulent;
