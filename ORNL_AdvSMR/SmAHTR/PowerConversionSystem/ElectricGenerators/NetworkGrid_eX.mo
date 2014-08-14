within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model NetworkGrid_eX
  extends SmAHTR.PowerConversionSystem.ElectricGenerators.Network1portBase(
      final C=e*v/(X + Xline));
  parameter Modelica.SIunits.Voltage e "e.m.f voltage"
    annotation (Dialog(group="Generator"));
  parameter Modelica.SIunits.Voltage v "Network voltage";
  parameter Modelica.SIunits.Frequency fnom=50 "Nominal frequency of network";
  parameter Modelica.SIunits.Reactance X "Internal reactance"
    annotation (Dialog(group="Generator"));
  parameter Modelica.SIunits.Reactance Xline "Line reactance";
  parameter Modelica.SIunits.MomentOfInertia J=0
    "Moment of inertia of the generator/shaft system (for damping term calculation only)"
    annotation (Dialog(group="Generator"));
  parameter Real r=0.2 "Damping coefficient of the swing equation"
    annotation (dialog(enable=if J > 0 then true else false, group=
          "Generator"));
  parameter Integer Np=2 "Number of electrical poles" annotation (
      dialog(enable=if J > 0 then true else false, group="Generator"));
  Real D "Electrical damping coefficient";
equation
  // Definition of the reference angular velocity
  omegaRef = 2*Modelica.Constants.pi*fnom;
  // Damping power loss
  if J > 0 then
    D = 2*r*sqrt(C*J*(2*Modelica.Constants.pi*fnom*Np)/(Np^2));
  else
    D = 0;
  end if;
  if closedInternal then
    Ploss = D*der(delta);
  else
    Ploss = 0;
  end if;
  annotation (Icon(graphics={Line(
                  points={{40,40},{40,-40}},
                  color={0,0,0},
                  thickness=0.5),Line(points={{-56,0},{-98,0}}, color={
          0,0,0}),Line(points={{-34,0},{-16,0},{12,16}}, color={0,0,0}),
          Line(points={{14,0},{40,0}}, color={0,0,0}),Rectangle(
                  extent={{-60,6},{-34,-6}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This model extends <tt>Network1portBase</tt> partial model, by defining the power coefficient <tt>C</tt> in terms of <tt>e</tt>, <tt>v</tt>, <tt>X</tt>, and <tt>Xline</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J</tt> is zero, zero damping is assumed by default. Note that <tt>J</tt> is only used to compute the dissipative term and should refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>",
  revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
end NetworkGrid_eX;
