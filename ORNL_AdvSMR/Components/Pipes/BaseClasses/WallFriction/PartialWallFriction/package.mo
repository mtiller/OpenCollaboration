within ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction;
partial package PartialWallFriction "Partial wall friction characteristic (base package of all wall friction characteristics)"
extends Modelica.Icons.Package;

// Constants to be set in subpackages
constant Boolean use_mu=true
  "= true, if mu_a/mu_b are used in function, otherwise value is not used";
constant Boolean use_roughness=true
  "= true, if roughness is used in function, otherwise value is not used";
constant Boolean use_dp_small=true
  "= true, if dp_small is used in function, otherwise value is not used";
constant Boolean use_m_flow_small=true
  "= true, if m_flow_small is used in function, otherwise value is not used";
constant Boolean dp_is_zero=false
  "= true, if no wall friction is present, i.e., dp = 0 (function massFlowRate_dp() cannot be used)";

// pressure loss characteristic functions


replaceable partial function massFlowRate_dp
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.Pressure dp "Pressure loss (dp = port_a.p - port_b.p)";
  input Modelica.SIunits.Density rho_a "Density at port_a";
  input Modelica.SIunits.Density rho_b "Density at port_b";
  input Modelica.SIunits.DynamicViscosity mu_a
    "Dynamic viscosity at port_a (dummy if use_mu = false)";
  input Modelica.SIunits.DynamicViscosity mu_b
    "Dynamic viscosity at port_b (dummy if use_mu = false)";
  input Modelica.SIunits.Length length "Length of pipe";
  input Modelica.SIunits.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input Modelica.SIunits.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
  input Modelica.SIunits.AbsolutePressure dp_small=1
    "Turbulent flow if |dp| >= dp_small (dummy if use_dp_small = false)";

  output Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate from port_a to port_b";
  annotation (Documentation(info="<html>

</html>"));
  end massFlowRate_dp;


replaceable partial function massFlowRate_dp_staticHead
  "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.Pressure dp "Pressure loss (dp = port_a.p - port_b.p)";
  input Modelica.SIunits.Density rho_a "Density at port_a";
  input Modelica.SIunits.Density rho_b "Density at port_b";
  input Modelica.SIunits.DynamicViscosity mu_a
    "Dynamic viscosity at port_a (dummy if use_mu = false)";
  input Modelica.SIunits.DynamicViscosity mu_b
    "Dynamic viscosity at port_b (dummy if use_mu = false)";
  input Modelica.SIunits.Length length "Length of pipe";
  input Modelica.SIunits.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input Real g_times_height_ab
    "Gravity times (Height(port_b) - Height(port_a))";
  input Modelica.SIunits.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
  input Modelica.SIunits.AbsolutePressure dp_small=1
    "Turbulent flow if |dp| >= dp_small (dummy if use_dp_small = false)";

  output Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate from port_a to port_b";
  annotation (Documentation(info="<html>

</html>"));
  end massFlowRate_dp_staticHead;


replaceable partial function pressureLoss_m_flow
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate from port_a to port_b";
  input Modelica.SIunits.Density rho_a "Density at port_a";
  input Modelica.SIunits.Density rho_b "Density at port_b";
  input Modelica.SIunits.DynamicViscosity mu_a
    "Dynamic viscosity at port_a (dummy if use_mu = false)";
  input Modelica.SIunits.DynamicViscosity mu_b
    "Dynamic viscosity at port_b (dummy if use_mu = false)";
  input Modelica.SIunits.Length length "Length of pipe";
  input Modelica.SIunits.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input Modelica.SIunits.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
  input Modelica.SIunits.MassFlowRate m_flow_small=0.01
    "Turbulent flow if |m_flow| >= m_flow_small (dummy if use_m_flow_small = false)";
  output Modelica.SIunits.Pressure dp
    "Pressure loss (dp = port_a.p - port_b.p)";

  annotation (Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow;


replaceable partial function pressureLoss_m_flow_staticHead
  "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate from port_a to port_b";
  input Modelica.SIunits.Density rho_a "Density at port_a";
  input Modelica.SIunits.Density rho_b "Density at port_b";
  input Modelica.SIunits.DynamicViscosity mu_a
    "Dynamic viscosity at port_a (dummy if use_mu = false)";
  input Modelica.SIunits.DynamicViscosity mu_b
    "Dynamic viscosity at port_b (dummy if use_mu = false)";
  input Modelica.SIunits.Length length "Length of pipe";
  input Modelica.SIunits.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input Real g_times_height_ab
    "Gravity times (Height(port_b) - Height(port_a))";
  input Modelica.SIunits.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
  input Modelica.SIunits.MassFlowRate m_flow_small=0.01
    "Turbulent flow if |m_flow| >= m_flow_small (dummy if use_m_flow_small = false)";
  output Modelica.SIunits.Pressure dp
    "Pressure loss (dp = port_a.p - port_b.p)";

  annotation (Documentation(info="<html>

</html>"));
  end pressureLoss_m_flow_staticHead;


annotation (Documentation(info="<html>

</html>"));
end PartialWallFriction;
