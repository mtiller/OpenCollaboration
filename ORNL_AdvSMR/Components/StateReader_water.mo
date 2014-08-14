within ORNL_AdvSMR.Components;
model StateReader_water
  "State reader for the visualization of the state in the simulation (water)"

  extends BaseReader_water;
  Modelica.SIunits.Temperature T "Temperature";
  Modelica.SIunits.Pressure p "Pressure";
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  Modelica.SIunits.MassFlowRate w "Mass flow rate";
  Medium.ThermodynamicState fluidState "Thermodynamic state of the fluid";

equation
  // Set fluid state
  p = inlet.p;
  h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else
    actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
  fluidState = Medium.setState_ph(p, h);
  T = Medium.temperature(fluidState);
  w = inlet.m_flow;
end StateReader_water;
