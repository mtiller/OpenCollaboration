within ORNL_AdvSMR.BaseClasses.HeatTransfer;
partial model PartialFlowHeatTransfer
  "base class for any pipe heat transfer correlation"
  extends ORNL_AdvSMR.Interfaces.PartialHeatTransfer;

  // Additional inputs provided to flow heat transfer model
  input Modelica.SIunits.Velocity[n] vs
    "Mean velocities of fluid flow in segments";

  // Geometry parameters and inputs for flow heat transfer
  parameter Real nParallel "number of identical parallel flow devices"
    annotation (Dialog(
      tab="Internal Interface",
      enable=false,
      group="Geometry"));
  input Modelica.SIunits.Length[n] lengths "Lengths along flow path";
  input Modelica.SIunits.Length[n] dimensions
    "Characteristic dimensions for fluid flow (diameter for pipe flow)";
  input Modelica.SIunits.Height[n] roughnesses
    "Average heights of surface asperities";

  annotation (Documentation(info="<html>
Base class for heat transfer models of flow devices.
<p>
The geometry is specified in the interface with the <code>surfaceAreas[n]</code>, the <code>roughnesses[n]</code>
and the lengths[n] along the flow path.
Moreover the fluid flow is characterized for different types of devices by the characteristic <code>dimensions[n+1]</code>
and the average velocities <code>vs[n+1]</code> of fluid flow.
See <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>
for examplary definitions.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={Rectangle(
          extent={{-80,60},{80,-60}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder),Text(
          extent={{-40,22},{38,-18}},
          lineColor={0,0,0},
          textString="%name")}));
end PartialFlowHeatTransfer;
