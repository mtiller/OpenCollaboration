within ORNL_AdvSMR.BaseClasses.WallFriction;
package Laminar "Pipe wall friction in the laminar regime (linear correlation)"


extends PartialWallFriction(
  final use_mu=true,
  final use_roughness=false,
  final use_dp_small=false,
  final use_m_flow_small=false);


redeclare function extends massFlowRate_dp
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"

  algorithm
  m_flow := dp*Modelica.Constants.pi*diameter^4*(rho_a + rho_b)/(128*length*(
    mu_a + mu_b));
  annotation (Documentation(info="<html>

</html>"));
  end massFlowRate_dp;


redeclare function extends pressureLoss_m_flow
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"

  algorithm
  dp := m_flow*128*length*(mu_a + mu_b)/(Modelica.Constants.pi*diameter^4*(
    rho_a + rho_b));
  annotation (Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow;


redeclare function extends massFlowRate_dp_staticHead
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"

protected
  Real k0inv=Modelica.Constants.pi*diameter^4/(128*length) "Constant factor";

  Real dp_grav_a=g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Real dp_grav_b=g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";

  Real dm_flow_ddp_fric_a=k0inv*rho_a/mu_a
    "Slope of mass flow rate over dp if flow in design direction (a to b)";
  Real dm_flow_ddp_fric_b=k0inv*rho_b/mu_b
    "Slope of mass flow rate over dp if flow against design direction (b to a)";

  Real dp_a=max(dp_grav_a, dp_grav_b) + dp_small
    "Upper end of regularization domain of the m_flow(dp) relation";
  Real dp_b=min(dp_grav_a, dp_grav_b) - dp_small
    "Lower end of regularization domain of the m_flow(dp) relation";

  Modelica.SIunits.MassFlowRate m_flow_a
    "Value at upper end of regularization domain";
  Modelica.SIunits.MassFlowRate m_flow_b
    "Value at lower end of regularization domain";

  // Properly define zero mass flow conditions
  Modelica.SIunits.MassFlowRate m_flow_zero=0;
  Modelica.SIunits.Pressure dp_zero=(dp_grav_a + dp_grav_b)/2;
  Real dm_flow_ddp_fric_zero;
  algorithm
  /*
  dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
     = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
     = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
     = 2*c0/(pi*D_Re^3) * mu/d * m_flow
     = k0 * mu/d * m_flow
  k0 = 2*c0/(pi*D_Re^3)
*/

  if dp >= dp_a then
    // Positive flow outside regularization
    m_flow := dm_flow_ddp_fric_a*(dp - dp_grav_a);
  elseif dp <= dp_b then
    // Negative flow outside regularization
    m_flow := dm_flow_ddp_fric_b*(dp - dp_grav_b);
  else
    m_flow_a := dm_flow_ddp_fric_a*(dp_a - dp_grav_a);
    m_flow_b := dm_flow_ddp_fric_b*(dp_b - dp_grav_b);

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
  /*
  m_flow := if dp<dp_b then dm_flow_ddp_b*(dp-dp_grav_b) else
              (if dp>dp_a then dm_flow_ddp_a*(dp-dp_grav_a) else
                Modelica.Fluid.Utilities.regFun3(dp, dp_b, dp_a, dm_flow_ddp_b*(dp_b - dp_grav_b), dm_flow_ddp_a*(dp_a - dp_grav_a), dm_flow_ddp_b, dm_flow_ddp_a));
*/
  annotation (Documentation(info="<html>

</html>"));
  end massFlowRate_dp_staticHead;


redeclare function extends pressureLoss_m_flow_staticHead
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"

protected
  Real k0=128*length/(Modelica.Constants.pi*diameter^4) "Constant factor";

  Real dp_grav_a=g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Real dp_grav_b=g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";

  Real ddp_dm_flow_a=k0*mu_a/rho_a
    "Slope of dp over mass flow rate if flow in design direction (a to b)";
  Real ddp_dm_flow_b=k0*mu_b/rho_b
    "Slope of dp over mass flow rate if flow against design direction (b to a)";

  Real m_flow_a=if dp_grav_a >= dp_grav_b then m_flow_small else m_flow_small
       + (dp_grav_b - dp_grav_a)/ddp_dm_flow_a
    "Upper end of regularization domain of the dp(m_flow) relation";
  Real m_flow_b=if dp_grav_a >= dp_grav_b then -m_flow_small else -m_flow_small
       - (dp_grav_b - dp_grav_a)/ddp_dm_flow_b
    "Lower end of regularization domain of the dp(m_flow) relation";

  Modelica.SIunits.Pressure dp_a "Value at upper end of regularization domain";
  Modelica.SIunits.Pressure dp_b "Value at lower end of regularization domain";

  // Properly define zero mass flow conditions
  Modelica.SIunits.MassFlowRate m_flow_zero=0;
  Modelica.SIunits.Pressure dp_zero=(dp_grav_a + dp_grav_b)/2;
  Real ddp_dm_flow_zero;
  algorithm
  /*
  dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
     = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
     = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
     = 2*c0/(pi*D_Re^3) * mu/d * m_flow
     = k0 * mu/d * m_flow
  k0 = 2*c0/(pi*D_Re^3)
*/

  if m_flow >= m_flow_a then
    // Positive flow outside regularization
    dp := (ddp_dm_flow_a*m_flow + dp_grav_a);
  elseif m_flow <= m_flow_b then
    // Negative flow outside regularization
    dp := (ddp_dm_flow_b*m_flow + dp_grav_b);
  else
    // Regularization parameters
    dp_a := ddp_dm_flow_a*m_flow_a + dp_grav_a;
    dp_b := ddp_dm_flow_b*m_flow_b + dp_grav_b;
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
  annotation (Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow_staticHead;


annotation (Documentation(info="<html>
<p>
This component defines only the laminar region of wall friction:
dp = k*m_flow, where \"k\" depends on density and dynamic viscosity.
The roughness of the wall does not have an influence on the laminar
flow and therefore argument roughness is ignored.
Since this is a linear relationship, the occuring systems of equations
are usually much simpler (e.g., either linear instead of non-linear).
By using nominal values for density and dynamic viscosity, the
systems of equations can still further be reduced.
</p>

<p>
In <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a> the complete friction regime is illustrated.
This component describes only the <b>Hagen-Poiseuille</b> equation.
</p>
<br>

</html>"));
end Laminar;
