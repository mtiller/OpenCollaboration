within ORNL_AdvSMR.Components.Pipes.BaseClasses.CharacteristicNumbers;
function ReynoldsNumber_m_flow "Return Reynolds number from m_flow, mu, D, A"
  input Modelica.SIunits.MassFlowRate m_flow "Mass flow rate";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity";
  input Modelica.SIunits.Length D
    "Characteristic dimension (hydraulic diameter of pipes or orifices)";
  input Modelica.SIunits.Area A=Modelica.Constants.pi/4*D*D
    "Cross sectional area of fluid flow";
  output Modelica.SIunits.ReynoldsNumber Re "Reynolds number";
algorithm
  Re := abs(m_flow)*D/A/mu;
  annotation (Documentation(info="<html>Simplified calculation of Reynolds Number for flow through pipes or orifices;
              using the mass flow rate <code>m_flow</code> instead of the velocity <code>v</code> to express inertial forces.
<pre>
  Re = |m_flow|*diameter/A/&mu;
with
  m_flow = v*&rho;*A
</pre>
See also <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">
          Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>.
</html>"));
end ReynoldsNumber_m_flow;
