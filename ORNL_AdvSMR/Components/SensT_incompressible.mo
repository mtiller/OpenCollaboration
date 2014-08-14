within ORNL_AdvSMR.Components;
model SensT_incompressible "Temperature sensor"
  extends ORNL_AdvSMR.Icons.Water.SensThrough;
  replaceable package Medium =
      ORNL_AdvSMR.Media.Fluids.LiFBeF2.flibe_incompressible constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy of the fluid";
  // Medium.ThermodynamicState fluidState "Thermodynamic state of the fluid";
  ThermoPower3.Water.FlangeA inlet(redeclare package Medium = Medium, m_flow(
        min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-80,-60},{-40,-20}}, rotation
          =0)));
  ThermoPower3.Water.FlangeB outlet(redeclare package Medium = Medium, m_flow(
        max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{40,-60},{80,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(transformation(
          extent={{60,40},{100,80}}, rotation=0)));
protected
  constant Modelica.SIunits.Pressure p0=1.01325e5 "Reference pressure";
  constant Modelica.SIunits.Temperature T0=731.15
    "Reference temperature and critical temperature";
  constant Modelica.SIunits.SpecificHeatCapacity cp0=2386
    "Specific heat capacity is assumed constant within the temperature range";
  constant Modelica.SIunits.Density rho0=2056
    "Density at reference temperature";
  constant Modelica.SIunits.RelativePressureCoefficient beta_r=2.3755e-4
    "Relative pressure coefficient";
  constant Modelica.SIunits.SpecificEnthalpy h0=1.7445e6
    "Fluid enthalpy at reference pressure and temperature";
  constant Modelica.SIunits.DynamicViscosity eta0=0.03023
    "Dynamic viscosity at reference pressure and temperature";
  constant Modelica.SIunits.ThermalConductivity lambda0=0.966827
    "Thermal conductivty at reference pressure and temperature";

equation
  inlet.m_flow + outlet.m_flow = 0 "Mass balance";
  inlet.p = outlet.p "No pressure drop";
  // Set fluid properties
  h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else
    actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
  // fluidState = Medium.setState_ph(inlet.p, h);
  T = T0 + (h - h0)/cp0;

  // Boundary conditions
  inlet.h_outflow = inStream(outlet.h_outflow);
  inStream(inlet.h_outflow) = outlet.h_outflow;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-40,84},{38,34}},
          lineColor={0,0,0},
          textString="T")}),
    Documentation(info="<HTML>
<p>This component can be inserted in a hydraulic circuit to measure the temperature of the fluid flowing through it.
<p>Flow reversal is supported.
</HTML>", revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end SensT_incompressible;
