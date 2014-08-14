within ORNL_AdvSMR.Components;
model PumpMech "Centrifugal pump with mechanical connector for the shaft"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Components.PumpBase;
  extends ORNL_AdvSMR.Icons.Water.PumpMech;
  Modelica.SIunits.Angle phi "Shaft angle";
  Modelica.SIunits.AngularVelocity omega "Shaft angular velocity";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a MechPort annotation (
      Placement(transformation(extent={{76,6},{106,36}}, rotation=0)));
equation
  // Mechanical boundary condition
  phi = MechPort.phi;
  omega = der(phi);
  W = omega*MechPort.tau;

  n = Modelica.SIunits.Conversions.to_rpm(omega) "Rotational speed";
  annotation (
    Icon(graphics={Text(extent={{-10,104},{18,84}}, textString="Np")}),
    Diagram(graphics),
    Documentation(info="<HTML>
<p>This model describes a centrifugal pump (or a group of <tt>Np</tt> pumps in parallel) with a mechanical rotational connector for the shaft, to be used when the pump drive has to be modelled explicitly. In the case of <tt>Np</tt> pumps in parallel, the mechanical connector is relative to a single pump.
<p>The model extends <tt>PumpBase</tt>
 </HTML>", revisions="<html>
<ul>
<li><i>5 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model restructured by using inheritance. Adapted to Modelica.Media.</li>
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       <tt>ThermalCapacity</tt> and <tt>CheckValve</tt> added.</li>
<li><i>15 Dec 2003</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>"));
end PumpMech;
