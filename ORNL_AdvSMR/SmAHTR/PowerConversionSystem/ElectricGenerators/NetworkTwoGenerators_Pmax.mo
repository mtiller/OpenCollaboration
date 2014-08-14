within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model NetworkTwoGenerators_Pmax
  "Connection: generator(a) - generator(b); Parameters: maximum power"
  extends SmAHTR.PowerConversionSystem.ElectricGenerators.Network2portBase(
      deltaStart=deltaStart_ab, final C_ab=Pmax);
  parameter Boolean hasBreaker=false;
  parameter Modelica.SIunits.Power Pmax "Maximum power transfer";
  parameter Modelica.SIunits.MomentOfInertia J_a=0
    "Moment of inertia of the generator/shaft system A (for damping term calculation only)"
    annotation (Dialog(group="Generator side A"));
  parameter Real r_a=0.2
    "Electrical damping of generator/shaft system (generator A)"
    annotation (dialog(enable=if J_a > 0 then true else false, group=
          "Generator side A"));
  parameter Integer Np_a=2 "Number of electrical poles (generator A)"
    annotation (dialog(enable=if J_a > 0 then true else false, group=
          "Generator side A"));
  parameter Modelica.SIunits.MomentOfInertia J_b=0
    "Moment of inertia of the generator/shaft system B (for damping term calculation only)"
    annotation (Dialog(group="Generator side B"));
  parameter Real r_b=0.2
    "Electrical damping of generator/shaft system (generator B)"
    annotation (dialog(enable=if J_b > 0 then true else false, group=
          "Generator side B"));
  parameter Integer Np_b=2 "Number of electrical poles (generator B)"
    annotation (dialog(enable=if J_b > 0 then true else false, group=
          "Generator side B"));
  parameter Modelica.SIunits.Frequency fnom=50
    "Nominal frequency of the network";
  parameter Modelica.SIunits.Angle deltaStart_ab=0
    "Start value of the load angle between side A and side B"
    annotation (Dialog(tab="Initialization"));
  Real D_a "Electrical damping coefficient side A";
  Real D_b "Electrical damping coefficient side B";
  Modelica.Blocks.Interfaces.BooleanInput closed if hasBreaker
    annotation (Placement(transformation(
        origin={0,97},
        extent={{-15,-16},{15,16}},
        rotation=270)));
equation
  // Breaker and its connections (unique breaker => closedInternal_gen_a = closedInternal_gen_b)
  if not hasBreaker then
    closedInternal_gen_a = true;
    closedInternal_gen_b = true;
  end if;
  connect(closed, closedInternal_gen_a);
  connect(closed, closedInternal_gen_b);

  // Definition of net powers
  Pe_a = Pe_ab;
  Pe_a = -Pe_b;
  // Definition of damping power losses
  if J_a > 0 then
    D_a = 2*r_a*sqrt(C_ab*J_a*(2*Modelica.Constants.pi*fnom*Np_a)/(Np_a
      ^2));
  else
    D_a = 0;
  end if;
  if J_b > 0 then
    D_b = 2*r_b*sqrt(C_ab*J_b*(2*Modelica.Constants.pi*fnom*Np_b)/(Np_b
      ^2));
  else
    D_b = 0;
  end if;
  if closedInternal_gen_a then
    Ploss_a = D_a*der(delta_ab);
    Ploss_b = -D_b*der(delta_ab);
  else
    Ploss_a = 0;
    Ploss_b = 0;
  end if;
  annotation (Documentation(info="<html>
<p>Simplified model of connection between two generators based on swing equation. It completes <tt>Netowrk2portBase</tt> partial model, defining the coefficient of the exchanged clean electrical power and the damping power losses.
<p>The power coefficient is given by directly defining the maximum power that can be transferred between the electrical port and the grid <tt>Pmax</tt>.
<p>The net electrical powers of two port coincide with the power <tt>P_ab</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J_a</tt> or <tt>J_b</tt> are zero, zero damping is assumed. Note that <tt>J_a</tt> and <tt>J_b</tt> are only used to compute the dissipative term and should each refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>",
  revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"),
   Icon(graphics={Line(points={{-54,0},{-94,0}}, color={0,0,0}),Line(
          points={{56,0},{92,0}}, color={0,0,0}),Line(points={{-34,0},{
          -14,0},{12,18}}, color={0,0,0}),Line(points={{14,0},{38,0}},
          color={0,0,0}),Rectangle(
                  extent={{-58,6},{-34,-6}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{38,6},{62,-6}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}));
end NetworkTwoGenerators_Pmax;
