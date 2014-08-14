within ORNL_AdvSMR.BaseClasses.WallFriction;
package QuadraticTurbulent "Pipe wall friction in the quadratic turbulent regime (simple characteristic, mu not used)"


extends PartialWallFriction(
  final use_mu=false,
  final use_roughness=true,
  final use_dp_small=true,
  final use_m_flow_small=true);


redeclare function extends massFlowRate_dp
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
  import Modelica.Math;
protected
  constant Real pi=Modelica.Constants.pi;
  Real zeta;
  Real k_inv;
  algorithm
  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");
  zeta := (length/diameter)/(2*Math.log10(3.7/(roughness/diameter)))^2;
  k_inv := (pi*diameter*diameter)^2/(8*zeta);
  m_flow := Modelica.Fluid.Utilities.regRoot2(
      dp,
      dp_small,
      rho_a*k_inv,
      rho_b*k_inv);
  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
  end massFlowRate_dp;


redeclare function extends pressureLoss_m_flow
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
  import Modelica.Math;

protected
  constant Real pi=Modelica.Constants.pi;
  Real zeta;
  Real k;
  algorithm
  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");
  zeta := (length/diameter)/(2*Math.log10(3.7/(roughness/diameter)))^2;
  k := 8*zeta/(pi*diameter*diameter)^2;
  dp := Modelica.Fluid.Utilities.regSquare2(
      m_flow,
      m_flow_small,
      k/rho_a,
      k/rho_b);
  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow;


redeclare function extends massFlowRate_dp_staticHead
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"
  import Modelica.Math;
protected
  constant Real pi=Modelica.Constants.pi;
  Real zeta=(length/diameter)/(2*Math.log10(3.7/(roughness/diameter)))^2;
  Real k_inv=(pi*diameter*diameter)^2/(8*zeta);

  Modelica.SIunits.Pressure dp_grav_a=g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Modelica.SIunits.Pressure dp_grav_b=g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";

  Real k1=rho_a*k_inv "Factor in m_flow =  sqrt(k1*(dp-dp_grav_a))";
  Real k2=rho_b*k_inv "Factor in m_flow = -sqrt(k2*|dp-dp_grav_b|)";

  Real dp_a=max(dp_grav_a, dp_grav_b) + dp_small
    "Upper end of regularization domain of the m_flow(dp) relation";
  Real dp_b=min(dp_grav_a, dp_grav_b) - dp_small
    "Lower end of regularization domain of the m_flow(dp) relation";

  Modelica.SIunits.MassFlowRate m_flow_a
    "Value at upper end of regularization domain";
  Modelica.SIunits.MassFlowRate m_flow_b
    "Value at lower end of regularization domain";

  Modelica.SIunits.MassFlowRate dm_flow_ddp_fric_a
    "Derivative at upper end of regularization domain";
  Modelica.SIunits.MassFlowRate dm_flow_ddp_fric_b
    "Derivative at lower end of regularization domain";

  // Properly define zero mass flow conditions
  Modelica.SIunits.MassFlowRate m_flow_zero=0;
  Modelica.SIunits.Pressure dp_zero=(dp_grav_a + dp_grav_b)/2;
  Real dm_flow_ddp_fric_zero;
  algorithm
  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");

  if dp >= dp_a then
    // Positive flow outside regularization
    m_flow := sqrt(k1*(dp - dp_grav_a));
  elseif dp <= dp_b then
    // Negative flow outside regularization
    m_flow := -sqrt(k2*abs(dp - dp_grav_b));
  else
    m_flow_a := sqrt(k1*(dp_a - dp_grav_a));
    m_flow_b := -sqrt(k2*abs(dp_b - dp_grav_b));

    dm_flow_ddp_fric_a := k1/(2*sqrt(k1*(dp_a - dp_grav_a)));
    dm_flow_ddp_fric_b := k2/(2*sqrt(k2*abs(dp_b - dp_grav_b)));
    /*  dm_flow_ddp_fric_a := if abs(dp_a - dp_grav_a)>0 then k1/(2*sqrt(k1*(dp_a - dp_grav_a))) else  Modelica.Constants.inf);
    dm_flow_ddp_fric_b := if abs(dp_b - dp_grav_b)>0 then k2/(2*sqrt(k2*abs(dp_b - dp_grav_b))) else Modelica.Constants.inf; */

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
  constant Real pi=Modelica.Constants.pi;
  Real zeta=(length/diameter)/(2*Math.log10(3.7/(roughness/diameter)))^2;
  Real k=8*zeta/(pi*diameter*diameter)^2;

  Modelica.SIunits.Pressure dp_grav_a=g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Modelica.SIunits.Pressure dp_grav_b=g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";

  Real k1=k/rho_a "If m_flow >= 0 then dp = k1*m_flow^2 + dp_grav_a";
  Real k2=k/rho_b "If m_flow < 0 then dp = -k2*m_flow^2 + dp_grav_b";

  Real m_flow_a=if dp_grav_a >= dp_grav_b then m_flow_small else m_flow_small
       + sqrt((dp_grav_b - dp_grav_a)/k1)
    "Upper end of regularization domain of the dp(m_flow) relation";
  Real m_flow_b=if dp_grav_a >= dp_grav_b then -m_flow_small else -m_flow_small
       - sqrt((dp_grav_b - dp_grav_a)/k2)
    "Lower end of regularization domain of the dp(m_flow) relation";

  Modelica.SIunits.Pressure dp_a "Value at upper end of regularization domain";
  Modelica.SIunits.Pressure dp_b "Value at lower end of regularization domain";

  Real ddp_dm_flow_a
    "Derivative of pressure drop with mass flow rate at m_flow_a";
  Real ddp_dm_flow_b
    "Derivative of pressure drop with mass flow rate at m_flow_b";

  // Properly define zero mass flow conditions
  Modelica.SIunits.MassFlowRate m_flow_zero=0;
  Modelica.SIunits.Pressure dp_zero=(dp_grav_a + dp_grav_b)/2;
  Real ddp_dm_flow_zero;

  algorithm
  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
  assert(roughness > 1.e-10,
    "roughness > 0 required for quadratic turbulent wall friction characteristic");

  if m_flow >= m_flow_a then
    // Positive flow outside regularization
    dp := (k1*m_flow^2 + dp_grav_a);
  elseif m_flow <= m_flow_b then
    // Negative flow outside regularization
    dp := (-k2*m_flow^2 + dp_grav_b);
  else
    // Regularization parameters
    dp_a := k1*m_flow_a^2 + dp_grav_a;
    ddp_dm_flow_a := 2*k1*m_flow_a;
    dp_b := -k2*m_flow_b^2 + dp_grav_b;
    ddp_dm_flow_b := -2*k2*m_flow_b;
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
This component defines only the quadratic turbulent regime of wall friction:
dp = k*m_flow*|m_flow|, where \"k\" depends on density and the roughness
of the pipe and is no longer a function of the Reynolds number.
This relationship is only valid for large Reynolds numbers.
</p>

<p>
In <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a> the complete friction regime is illustrated.
This component describes only the asymptotic behaviour for large
Reynolds numbers, i.e., the values at the right ordinate where
&lambda; is constant.
</p>
<br>

</html>"));
end QuadraticTurbulent;
