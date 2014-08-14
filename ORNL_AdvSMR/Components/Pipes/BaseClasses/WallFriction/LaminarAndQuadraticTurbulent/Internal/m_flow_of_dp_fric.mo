within ORNL_AdvSMR.Components.Pipes.BaseClasses.WallFriction.LaminarAndQuadraticTurbulent.Internal;
function m_flow_of_dp_fric
  "Calculate mass flow rate as function of pressure drop due to friction"

  input Modelica.SIunits.Pressure dp_fric
    "Pressure loss due to friction (dp = port_a.p - port_b.p)";
  input Modelica.SIunits.Density rho_a "Density at port_a";
  input Modelica.SIunits.Density rho_b "Density at port_b";
  input Modelica.SIunits.DynamicViscosity mu_a
    "Dynamic viscosity at port_a (dummy if use_mu = false)";
  input Modelica.SIunits.DynamicViscosity mu_b
    "Dynamic viscosity at port_b (dummy if use_mu = false)";
  input Modelica.SIunits.Length length "Length of pipe";
  input Modelica.SIunits.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input Modelica.SIunits.ReynoldsNumber Re1
    "Boundary between laminar regime and transition";
  input Modelica.SIunits.ReynoldsNumber Re2
    "Boundary between transition and turbulent regime";
  input Real Delta "Relative roughness";
  output Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate from port_a to port_b";
  output Real dm_flow_ddp_fric "Derivative of mass flow rate with dp_fric";
protected
  Modelica.SIunits.DynamicViscosity mu "Upstream viscosity";
  Modelica.SIunits.Density rho "Upstream density";

  Real zeta;
  Real k0;
  Real k_inv;
  Real dm_flow_ddp_laminar "Derivative of m_flow=m_flow(dp) in laminar regime";
  Modelica.SIunits.AbsolutePressure dp_fric_turbulent
    "The turbulent region is: |dp_fric| >= dp_fric_turbulent, simple quadratic correlation";
  Modelica.SIunits.AbsolutePressure dp_fric_laminar
    "The laminar region is: |dp_fric| <= dp_fric_laminar";
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
   dp_fric_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)
*/
  // Determine upstream density and upstream viscosity
  if dp_fric >= 0 then
    rho := rho_a;
    mu := mu_a;
  else
    rho := rho_b;
    mu := mu_b;
  end if;
  // Quadratic turbulent
  zeta := (length/diameter)/(2*log10(3.7/(Delta)))^2;
  k_inv := (pi*diameter*diameter)^2/(8*zeta);
  dp_fric_turbulent := sign(dp_fric)*(mu*diameter*pi/4)^2*Re2^2/(k_inv*rho);

  // Laminar
  k0 := 128*length/(pi*diameter^4);
  dm_flow_ddp_laminar := rho/(k0*mu);
  dp_fric_laminar := sign(dp_fric)*pi*k0*mu^2/rho*diameter/4*Re1;

  if abs(dp_fric) > abs(dp_fric_turbulent) then
    m_flow := sign(dp_fric)*sqrt(rho*k_inv*abs(dp_fric));
    dm_flow_ddp_fric := 0.5*rho*k_inv*(rho*k_inv*abs(dp_fric))^(-0.5);
  elseif abs(dp_fric) < abs(dp_fric_laminar) then
    m_flow := dm_flow_ddp_laminar*dp_fric;
    dm_flow_ddp_fric := dm_flow_ddp_laminar;
  else
    // Preliminary testing seems to indicate that the log-log transform is not required here
    (m_flow,dm_flow_ddp_fric) :=
      Modelica.Fluid.Utilities.cubicHermite_withDerivative(
      dp_fric,
      dp_fric_laminar,
      dp_fric_turbulent,
      dm_flow_ddp_laminar*dp_fric_laminar,
      sign(dp_fric_turbulent)*sqrt(rho*k_inv*abs(dp_fric_turbulent)),
      dm_flow_ddp_laminar,
      if abs(dp_fric_turbulent) > 0 then 0.5*rho*k_inv*(rho*k_inv*abs(
        dp_fric_turbulent))^(-0.5) else Modelica.Constants.inf);
  end if;
  annotation (smoothOrder=1);
end m_flow_of_dp_fric;
