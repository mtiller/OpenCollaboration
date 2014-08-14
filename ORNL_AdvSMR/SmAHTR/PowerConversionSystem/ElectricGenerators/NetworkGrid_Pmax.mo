within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model NetworkGrid_Pmax
  extends SmAHTR.PowerConversionSystem.ElectricGenerators.Network1portBase(
      final C=Pmax);
  parameter Modelica.SIunits.Power Pmax "Maximum power transfer";
  parameter Modelica.SIunits.Frequency fnom=50 "Nominal frequency of network";
  parameter Modelica.SIunits.MomentOfInertia J=0
    "Moment of inertia of the generator/shaft system (for damping term calculation)"
    annotation (Dialog(group="Generator"));
  parameter Real r=0.2 "Electrical damping of generator/shaft system"
    annotation (dialog(enable=if J > 0 then true else false, group=
          "Generator"));
  parameter Integer Np=2 "Number of electrical poles" annotation (
      dialog(enable=if J > 0 then true else false, group="Generator"));
  Real D "Electrical damping coefficient";
equation
  // Definition of the reference
  omegaRef = 2*Modelica.Constants.pi*fnom;
  // Definition of damping power loss
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
  annotation (Icon(graphics={Rectangle(
                  extent={{-54,6},{-28,-6}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-54,0},{
          -92,0}}, color={0,0,0}),Line(points={{-28,0},{-10,0},{18,16}},
          color={0,0,0}),Line(points={{20,0},{46,0}}, color={0,0,0}),
          Line(   points={{46,40},{46,-40}},
                  color={0,0,0},
                  thickness=0.5)}), Documentation(info="<html>
<p>This model extends <tt>Network1portBase</tt> partial model, by directly defining the maximum power that can be transferred between the electrical port and the grid <tt>Pmax</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J</tt> is zero, zero damping is assumed. Note that <tt>J</tt> is only used to compute the dissipative term and should refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>",
  revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
end NetworkGrid_Pmax;
