within ORNL_AdvSMR.Interfaces;
partial model PartialHeatTransfer "Common interface for heat transfer models"

  // Parameters
  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialSinglePhaseMedium "Medium model"
    annotation (
    evaluate=true,
    choicesAllMatching=true,
    Dialog(tab="Internal Interface", enable=true));

  parameter Integer n=1 "Number of heat transfer segments"
    annotation (Dialog(tab="Internal Interface", enable=false), Evaluate=true);

  // Inputs provided to heat transfer model
  input Medium.ThermodynamicState[n] states
    "Thermodynamic states of flow segments";

  input Modelica.SIunits.Area[n] surfaceAreas "Heat transfer areas";

  // Outputs defined by heat transfer model
  output Modelica.SIunits.HeatFlux[n] phi "Heat flow rates";

  // Parameters
  parameter Boolean use_k=false "= true to use k value for thermal isolation"
    annotation (Dialog(tab="Internal Interface", enable=false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h_ambient=0
    "Heat transfer coefficient to ambient"
    annotation (Dialog(group="Ambient"), Evaluate=true);
  parameter Modelica.SIunits.Temperature T_ambient=system.T_ambient
    "Ambient temperature" annotation (Dialog(group="Ambient"));
  outer Modelica.Fluid.System system "System wide properties";

  // Heat ports
  Thermal.DHThtc heatPort(N=n) "Heat port to component boundary" annotation (
      Placement(transformation(extent={{-80,60},{80,80}}, rotation=0),
        iconTransformation(extent={{-20,60},{20,80}})));

  // Variables
  Modelica.SIunits.Temperature[n] Ts=Medium.temperature(states)
    "Temperatures defined by fluid states";

equation
  if use_k then
    phi = heatPort.phi + {h_ambient*(T_ambient - heatPort.T[i]) for i in 1:n};
  else
    phi = heatPort.phi;
  end if;

  annotation (Documentation(info="<html>
<p>
This component is a common interface for heat transfer models. The heat flow rates <code>Q_flows[n]</code> through the boundaries of n flow segments
are obtained as function of the thermodynamic <code>states</code> of the flow segments for a given fluid <code>Medium</code>,
the <code>surfaceAreas[n]</code> and the boundary temperatures <code>heatPorts[n].T</code>.
</p>
<p>
The heat loss coefficient <code>k</code> can be used to model a thermal isolation between <code>heatPorts.T</code> and <code>T_ambient</code>.</p>
<p>
An extending model implementing this interface needs to define one equation: the relation between the predefined fluid temperatures <code>Ts[n]</code>,
the boundary temperatures <code>heatPorts[n].T</code>, and the heat flow rates <code>Q_flows[n]</code>.
</p>
</html>"));
end PartialHeatTransfer;
