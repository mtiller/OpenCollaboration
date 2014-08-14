within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
model NetworkGridTwoGenerators "Base class for network with two port"
  extends SmAHTR.PowerConversionSystem.ElectricGenerators.Network2portBase(
      final C_ab=e_a*e_b/(X_a + X_b));
  parameter Boolean hasBreaker=false
    "Model includes a breaker controlled by external input";
  parameter Modelica.SIunits.Voltage v "Network connection frame";
  parameter Modelica.SIunits.Voltage e_a "e.m.f voltage (generator A)"
    annotation (Dialog(group="Generator side A"));
  parameter Modelica.SIunits.Voltage e_b "e.m.f voltage (generator B)"
    annotation (Dialog(group="Generator side B"));
  parameter Modelica.SIunits.Reactance X_a "Internal reactance (generator A)"
    annotation (Dialog(group="Generator side A"));
  parameter Modelica.SIunits.Reactance X_b "Internal reactance (generator B)"
    annotation (Dialog(group="Generator side B"));
  parameter Modelica.SIunits.Reactance Xline "Line reactance";
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
  parameter Modelica.SIunits.Frequency fnom=50 "Frequency of the network";
  Real D_a "Electrical damping coefficient side A";
  Real D_b "Electrical damping coefficient side B";
  Modelica.SIunits.Power Pe_g "Electrical Power provided to the grid";
  Modelica.SIunits.Power Pe_ag "Power transferred from generator A to the grid";
  Modelica.SIunits.Power Pe_bg "Power transferred from generator B to the grid";
  final parameter Modelica.SIunits.Power C_ag=e_a*v/(X_a + Xline)
    "Coefficient of Pe_ag";
  final parameter Modelica.SIunits.Power C_bg=e_b*v/(X_b + Xline)
    "Coefficient of Pe_bg";
  Modelica.SIunits.AngularVelocity omegaRef "Angular velocity reference";
  Modelica.SIunits.Angle delta_ag(stateSelect=StateSelect.prefer)
    "Load angle between generator side A and the grid";
  Modelica.SIunits.Angle delta_bg
    "Load angle between generator side B and the grid";
  Modelica.SIunits.Angle delta_g "Grid phase";
  Modelica.Blocks.Interfaces.BooleanInput closed_gen_a if hasBreaker
    annotation (Placement(transformation(
        origin={-68,59},
        extent={{-15,-16},{15,16}},
        rotation=270)));
  Modelica.Blocks.Interfaces.BooleanInput closed_gen_b if hasBreaker
    annotation (Placement(transformation(
        origin={68,59},
        extent={{-15,-16},{15,16}},
        rotation=270)));
  Modelica.Blocks.Interfaces.BooleanInput closed_grid if hasBreaker
    annotation (Placement(transformation(
        origin={0,97},
        extent={{-15,-16},{15,16}},
        rotation=270)));
protected
  Modelica.Blocks.Interfaces.BooleanInput closedInternal_grid
    annotation (Placement(transformation(
        origin={0,49},
        extent={{-9,-8},{9,8}},
        rotation=270)));
equation
  // Load angles
  omegaRef = 2*Modelica.Constants.pi*fnom;
  der(delta_g) = omegaRef;
  delta_ag = delta_a - delta_g;
  delta_bg = delta_b - delta_g;
  // Breakers and their connections
  if not hasBreaker then
    closedInternal_gen_a = true;
    closedInternal_gen_b = true;
    closedInternal_grid = true;
  end if;
  connect(closed_gen_a, closedInternal_gen_a);
  connect(closed_gen_b, closedInternal_gen_b);
  connect(closed_grid, closedInternal_grid);
  // Coefficients of exchanged powers (power = zero if open breaker)
  if closedInternal_gen_a and closedInternal_grid then
    Pe_ag = homotopy(C_ag*Modelica.Math.sin(delta_ag), C_ag*delta_ag);
  else
    Pe_ag = 0;
  end if;
  if closedInternal_gen_b and closedInternal_grid then
    Pe_bg = homotopy(C_bg*Modelica.Math.sin(delta_bg), C_bg*delta_bg);
  else
    Pe_bg = 0;
  end if;
  if closedInternal_gen_a then
    Ploss_a = D_a*der(delta_ag);
  else
    Ploss_a = 0;
  end if;
  if closedInternal_gen_b then
    Ploss_b = D_b*der(delta_bg);
  else
    Ploss_b = 0;
  end if;
  // Net and exchanged powers
  Pe_a = Pe_ab + Pe_ag;
  Pe_b = -Pe_ab + Pe_bg;
  Pe_g = Pe_ag + Pe_bg;
  // Damping power losses
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
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(delta_ag) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Diagram(graphics),
    Icon(graphics={Line(points={{32,0},{98,0}}, color={0,0,0}),Line(
          points={{-40,0},{-32,0},{-16,8}}, color={0,0,0}),Line(points=
          {{-16,0},{16,0}}, color={0,0,0}),Line(points={{0,2},{0,12},{8,
          24}}, color={0,0,0}),Line(
                  points={{-30,64},{30,64}},
                  color={0,0,0},
                  thickness=0.5),Line(points={{0,64},{0,26}}, color={0,
          0,0}),Rectangle(
                  extent={{-4,54},{4,36}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-4,4},{4,-4}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Line(points={{-36,0},{
          -102,0}}, color={0,0,0}),Rectangle(
                  extent={{-66,4},{-48,-4}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{48,4},{66,-4}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{8,0},{16,
          0},{32,8}}, color={0,0,0})}),
    Documentation(info="<html>
<p>Simplified model of connection between two generators and the grid.
<p>This model adds to <tt>Netowrk2portBase</tt> partial model, in more in comparison to the concepts expressed by the <tt>NetowrkTwoGenerators_eX</tt> model, two further electrical flows: from port_a to grid and from port_b to grid, so that to describe the interactions between two ports and the grid.
<p>The clean electrical powers of two ports are defined by opportune combinations of the power flows introduced.
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
</html>"));
end NetworkGridTwoGenerators;
