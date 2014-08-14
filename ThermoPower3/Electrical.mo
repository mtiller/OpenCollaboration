within ThermoPower3;
package Electrical "Simplified models of electric power components"
  extends Modelica.Icons.Library;
  connector PowerConnection "Electrical power connector"
    flow Power W "Active power";
    Frequency f "Frequency";
    annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}));
  end PowerConnection;

  model Grid "Ideal grid with finite droop"
    parameter Frequency fn=50 "Nominal frequency";
    parameter Power Pn "Nominal power installed on the network";
    parameter Real droop=0.05 "Network droop";
    PowerConnection connection annotation (Placement(transformation(extent={{-100,
              -14},{-72,14}}, rotation=0)));
  equation
    connection.f = fn + droop*fn*connection.W/Pn;
    annotation (Diagram(graphics), Icon(graphics={Line(points={{18,-16},{2,-38}},
            color={0,0,0}),Line(points={{-72,0},{-40,0}}, color={0,0,0}),
            Ellipse(
              extent={{100,-68},{-40,68}},
              lineColor={0,0,0},
              lineThickness=0.5),Line(points={{-40,0},{-6,0},{24,36},{54,50}},
            color={0,0,0}),Line(points={{24,36},{36,-6}}, color={0,0,0}),Line(
            points={{-6,0},{16,-14},{40,-52}}, color={0,0,0}),Line(points={{18,
            -14},{34,-6},{70,-22}}, color={0,0,0}),Line(points={{68,18},{36,-4},
            {36,-4}}, color={0,0,0}),Ellipse(
              extent={{-8,2},{-2,-4}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{20,38},{26,32}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{52,54},{58,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{14,-12},{20,-18}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{66,22},{72,16}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{32,-2},{38,-8}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{38,-50},{44,-56}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{66,-18},{72,-24}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{0,-34},{6,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
  end Grid;

  model Generator "Active power generator"
    import Modelica.SIunits.Conversions.NonSIunits.*;
    parameter Real eta=1 "Conversion efficiency";
    parameter Modelica.SIunits.MomentOfInertia J=0 "Moment of inertia";
    parameter Integer Np=2 "Number of electrical poles";
    parameter Modelica.SIunits.Frequency fstart=50
      "Start value of the electrical frequency"
      annotation (Dialog(tab="Initialization"));
    parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
      "Initialization option" annotation (Dialog(tab="Initialization"));
    Modelica.SIunits.Power Pm "Mechanical power";
    Modelica.SIunits.Power Pe "Electrical Power";
    Modelica.SIunits.Power Ploss "Inertial power Loss";
    Modelica.SIunits.Torque tau "Torque at shaft";
    Modelica.SIunits.AngularVelocity omega_m(start=2*Modelica.Constants.pi*
          fstart/Np) "Angular velocity of the shaft";
    Modelica.SIunits.AngularVelocity omega_e
      "Angular velocity of the e.m.f. rotating frame";
    AngularVelocity_rpm n "Rotational speed";
    Modelica.SIunits.Frequency f "Electrical frequency";
    PowerConnection powerConnection annotation (Placement(transformation(extent=
             {{72,-14},{100,14}}, rotation=0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (
        Placement(transformation(extent={{-100,-14},{-72,14}}, rotation=0)));
  equation
    omega_m = der(shaft.phi) "Mechanical boundary condition";
    omega_e = omega_m*Np;
    f = omega_e/(2*Modelica.Constants.pi) "Electrical frequency";
    n = Modelica.SIunits.Conversions.to_rpm(omega_m) "Rotational speed in rpm";
    Pm = omega_m*tau;
    if J > 0 then
      Ploss = J*der(omega_m)*omega_m;
    else
      Ploss = 0;
    end if annotation (Diagram);
    Pm = Pe/eta + Ploss "Energy balance";
    // Boundary conditions
    f = powerConnection.f;
    Pe = -powerConnection.W;
    tau = shaft.tau;
  initial equation
    if initOpt == ThermoPower3.Choices.Init.Options.noInit then
      // do nothing
    elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
      der(omega_m) = 0;
    else
      assert(false, "Unsupported initialisation option");
    end if;
    annotation (
      Icon(graphics={Rectangle(
              extent={{-72,6},{-48,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),Ellipse(
              extent={{50,-50},{-50,50}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{50,0},{72,0}}, color=
             {0,0,0}),Text(
              extent={{-26,24},{28,-28}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="G")}),
      Diagram(graphics),
      Documentation(info="<html>
<p>This model describes the conversion between mechanical power and electrical power in an ideal synchronous generator. 
The frequency in the electrical connector is the e.m.f. of generator.
<p>It is possible to consider the generator inertia in the model, by setting the parameter <tt>J > 0</tt>. 
</html>"));
  end Generator;

  model Breaker "Circuit breaker"

    PowerConnection connection1 annotation (Placement(transformation(extent={{-100,
              -14},{-72,14}}, rotation=0)));
    PowerConnection connection2 annotation (Placement(transformation(extent={{
              72,-14},{100,14}},rotation=0)));
    Modelica.Blocks.Interfaces.BooleanInput closed annotation (Placement(
          transformation(
          origin={0,80},
          extent={{-20,-20},{20,20}},
          rotation=270)));
  equation
    connection1.W + connection2.W = 0;
    if closed then
      connection1.f = connection2.f;
    else
      connection1.W = 0;
    end if;
    annotation (
      Diagram(graphics),
      Icon(graphics={Line(points={{-72,0},{-40,0}}, color={0,0,0}),Line(points=
            {{40,0},{72,0}}, color={0,0,0}),Line(
              points={{-40,0},{30,36},{30,34}},
              color={0,0,0},
              thickness=0.5),Ellipse(
              extent={{-42,4},{-34,-4}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{36,4},{44,-4}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,60},{0,20}}, color=
             {255,85,255})}),
      Documentation(info="<html>
Ideal breaker model. Can only be used to connect a generator to a grid with finite droop. Otherwise, please consider the other models in this package.
</html>"));
  end Breaker;

  model Load "Electrical load"
    parameter Power Wn "Nominal active power consumption";
    parameter Frequency fn=50 "Nominal frequency";
    replaceable function powerCurve = Functions.one
      "Normalised power consumption vs. frequency curve";
    PowerConnection connection annotation (Placement(transformation(extent={{-14,
              72},{14,100}}, rotation=0)));
    Power W "Actual power consumption";
    Frequency f "Frequency";
    Modelica.Blocks.Interfaces.RealInput powerConsumption annotation (Placement(
          transformation(
          origin={-33,0},
          extent={{13,12},{-13,-12}},
          rotation=180)));
  equation
    if cardinality(powerConsumption) == 1 then
      W = powerConsumption*powerCurve((f - fn)/fn)
        "Power consumption determined by connector";
    else
      powerConsumption = Wn "Set the connector value (not used)";
      W = Wn*powerCurve((f - fn)/fn)
        "Power consumption determined by parameter";
    end if;
    connection.f = f;
    connection.W = W;
    annotation (
      extent=[-20, 80; 0, 100],
      rotation=-90,
      Icon(graphics={Line(points={{0,40},{0,74}}, color={0,0,0}),Rectangle(
              extent={{-20,40},{20,-40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,-40},{0,-68}},
            color={0,0,0}),Line(points={{16,-68},{-16,-68}}, color={0,0,0}),
            Line(points={{8,-76},{-8,-76}}, color={0,0,0}),Line(points={{-2,-84},
            {4,-84}}, color={0,0,0})}),
      Diagram(graphics),
      Placement(transformation(
          origin={-10,90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  end Load;

  model PowerSensor "Measures power flow through the component"

    PowerConnection port_a annotation (Placement(transformation(extent={{-110,-10},
              {-90,10}}, rotation=0)));
    PowerConnection port_b annotation (Placement(transformation(extent={{90,-12},
              {110,8}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput W
      "Power flowing from port_a to port_b" annotation (Placement(
          transformation(
          origin={0,-94},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    port_a.W + port_b.W = 0;
    port_a.f = port_b.f;
    W = port_a.W;
    annotation (Diagram(graphics), Icon(graphics={Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,70},{0,40}}, color=
             {0,0,0}),Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),Line(points=
             {{37.6,13.7},{65.8,23.9}}, color={0,0,0}),Line(points={{-37.6,13.7},
            {-65.8,23.9}}, color={0,0,0}),Line(points={{0,0},{9.02,28.6}},
            color={0,0,0}),Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="W"),Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{100,0},{70,0}}, color={0,0,0}),Text(extent={{-148,88},
            {152,128}}, textString="%name"),Line(points={{0,-70},{0,-84}},
            color={0,0,0})}));
  end PowerSensor;

  model FrequencySensor "Measures the frequency at the connector"

    PowerConnection port annotation (Placement(transformation(extent={{-110,-10},
              {-90,10}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput f "Frequency at the connector"
      annotation (Placement(transformation(extent={{92,-10},{112,10}}, rotation=
             0)));
  equation
    port.W = 0;
    f = port.f;
    annotation (Diagram(graphics), Icon(graphics={Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,70},{0,40}}, color=
             {0,0,0}),Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),Line(points=
             {{37.6,13.7},{65.8,23.9}}, color={0,0,0}),Line(points={{-37.6,13.7},
            {-65.8,23.9}}, color={0,0,0}),Line(points={{0,0},{9.02,28.6}},
            color={0,0,0}),Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="f"),Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{100,0},{70,0}}, color={0,0,0}),Text(extent={{-148,88},
            {152,128}}, textString="%name")}));
  end FrequencySensor;

  partial model Network1portBase "Base class for one-port network"
    parameter Boolean hasBreaker=false
      "Model includes a breaker controlled by external input";
    parameter Modelica.SIunits.Angle deltaStart=0
      "Start value of the load angle" annotation (Dialog(tab="Initialization"));
    parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
      "Initialization option" annotation (Dialog(tab="Initialization"));
    parameter Modelica.SIunits.Power C "Max. power transfer";
    Modelica.SIunits.Power Pe "Net electrical power";
    Modelica.SIunits.Power Ploss "Electrical power loss";
    Modelica.SIunits.AngularVelocity omega "Angular velocity";
    Modelica.SIunits.AngularVelocity omegaRef "Angular velocity reference";
    Modelica.SIunits.Angle delta(stateSelect=StateSelect.prefer, start=
          deltaStart) "Load angle";

    PowerConnection powerConnection annotation (Placement(transformation(extent=
             {{-114,-14},{-86,14}}, rotation=0)));
    Modelica.Blocks.Interfaces.BooleanInput closed if hasBreaker annotation (
        Placement(transformation(
          origin={0,97},
          extent={{-15,-16},{15,16}},
          rotation=270)));
  protected
    Modelica.Blocks.Interfaces.BooleanInput closedInternal annotation (
        Placement(transformation(
          origin={0,49},
          extent={{-9,-8},{9,8}},
          rotation=270)));
  public
    Modelica.Blocks.Interfaces.RealOutput delta_out annotation (Placement(
          transformation(
          origin={0,-90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    // Load angle
    der(delta) = omega - omegaRef;
    // Power flow
    if closedInternal then
      Pe = homotopy(C*Modelica.Math.sin(delta), C*delta);
    else
      Pe = 0;
    end if;
    // Boundary conditions
    Pe + Ploss = powerConnection.W;
    omega = 2*Modelica.Constants.pi*powerConnection.f;
    if not hasBreaker then
      closedInternal = true;
    end if;
    connect(closed, closedInternal);
    //Output signal
    delta_out = delta;
  initial equation
    if initOpt == ThermoPower3.Choices.Init.Options.noInit then
      // do nothing
    elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
      der(delta) = 0;
    else
      assert(false, "Unsupported initialisation option");
    end if;
    annotation (
      Diagram(graphics),
      Icon(graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>Basic interface of the Network models with one electrical port for the connection to the generator, containing the common parameters, variables and connectors.</p>
<p><b>Modelling options</b>
<p>The net electrical power is defined by the following relationship:
<ul><tt>Pe = C*sin(delta)</tt></ul> 
<p><tt>delta</tt> is the load angle, defined by the following relationship:
<ul><tt>der(delta) = omega - omegaRef</tt></ul>
<p>where <tt>omega</tt> is related to the frequency on the power connector (generator frequency), and <tt>omegaRef</tt> is the reference angular velocity of the network embedded in the model.
<p>The electrical power losses are described by the variable <tt>Ploss</tt>.
<p>If <tt>hasBreaker</tt> is true, the model provides a circuit breaker, controlled by the boolean input signal, to describe the connection/disconnection of the electrical port from the grid; otherwise it is assumed that the electrical port is always connected to the grid. 
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end Network1portBase;

  model NetworkGrid_eX
    extends ThermoPower3.Electrical.Network1portBase(final C=e*v/(X + Xline));
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
    parameter Integer Np=2 "Number of electrical poles" annotation (dialog(
          enable=if J > 0 then true else false, group="Generator"));
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
              thickness=0.5),Line(points={{-56,0},{-98,0}}, color={0,0,0}),Line(
            points={{-34,0},{-16,0},{12,16}}, color={0,0,0}),Line(points={{14,0},
            {40,0}}, color={0,0,0}),Rectangle(
              extent={{-60,6},{-34,-6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This model extends <tt>Network1portBase</tt> partial model, by defining the power coefficient <tt>C</tt> in terms of <tt>e</tt>, <tt>v</tt>, <tt>X</tt>, and <tt>Xline</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J</tt> is zero, zero damping is assumed by default. Note that <tt>J</tt> is only used to compute the dissipative term and should refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end NetworkGrid_eX;

  model NetworkGrid_Pmax
    extends ThermoPower3.Electrical.Network1portBase(final C=Pmax);
    parameter Modelica.SIunits.Power Pmax "Maximum power transfer";
    parameter Modelica.SIunits.Frequency fnom=50 "Nominal frequency of network";
    parameter Modelica.SIunits.MomentOfInertia J=0
      "Moment of inertia of the generator/shaft system (for damping term calculation)"
      annotation (Dialog(group="Generator"));
    parameter Real r=0.2 "Electrical damping of generator/shaft system"
      annotation (dialog(enable=if J > 0 then true else false, group=
            "Generator"));
    parameter Integer Np=2 "Number of electrical poles" annotation (dialog(
          enable=if J > 0 then true else false, group="Generator"));
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
              fillPattern=FillPattern.Solid),Line(points={{-54,0},{-92,0}},
            color={0,0,0}),Line(points={{-28,0},{-10,0},{18,16}}, color={0,0,0}),
            Line(points={{20,0},{46,0}}, color={0,0,0}),Line(
              points={{46,40},{46,-40}},
              color={0,0,0},
              thickness=0.5)}), Documentation(info="<html>
<p>This model extends <tt>Network1portBase</tt> partial model, by directly defining the maximum power that can be transferred between the electrical port and the grid <tt>Pmax</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J</tt> is zero, zero damping is assumed. Note that <tt>J</tt> is only used to compute the dissipative term and should refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end NetworkGrid_Pmax;

  partial model Network2portBase "Base class for network with two port"
    parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
      "Initialization option" annotation (Dialog(tab="Initialization"));
    parameter Modelica.SIunits.Power C_ab "Coefficient of Pe_ab";
    Modelica.SIunits.Power Pe_ab "Exchanged electrical power from A to B";
    Modelica.SIunits.Power Pe_a "Net electrical power side A";
    Modelica.SIunits.Power Pe_b "Net electrical power side B";
    Modelica.SIunits.Power Ploss_a "Electrical power loss side A";
    Modelica.SIunits.Power Ploss_b "Electrical power loss side B";
    Modelica.SIunits.AngularVelocity omega_a "Angular velocity A";
    Modelica.SIunits.AngularVelocity omega_b "Angular velocity B";
    Modelica.SIunits.Angle delta_a "Phase A";
    Modelica.SIunits.Angle delta_b "Phase B";
    Modelica.SIunits.Angle delta_ab(stateSelect=StateSelect.prefer, start=
          deltaStart) "Load angle between A and B";

  protected
    parameter Real deltaStart=0;
  public
    PowerConnection powerConnection_a "A" annotation (Placement(transformation(
            extent={{-114,-14},{-86,14}}, rotation=0)));
    PowerConnection powerConnection_b "B" annotation (Placement(transformation(
            extent={{86,-14},{114,14}}, rotation=0)));
  protected
    Modelica.Blocks.Interfaces.BooleanInput closedInternal_gen_a annotation (
        Placement(transformation(
          origin={-40,29},
          extent={{-9,-8},{9,8}},
          rotation=270)));
    Modelica.Blocks.Interfaces.BooleanInput closedInternal_gen_b annotation (
        Placement(transformation(
          origin={40,29},
          extent={{-9,-8},{9,8}},
          rotation=270)));
  equation
    // Definition of load angles
    der(delta_a) = omega_a;
    der(delta_b) = omega_b;
    delta_ab = delta_a - delta_b;
    // Definition of power flow
    if closedInternal_gen_a and closedInternal_gen_b then
      Pe_ab = homotopy(C_ab*Modelica.Math.sin(delta_ab), C_ab*delta_ab);
    else
      Pe_ab = 0;
    end if;
    // Boundary conditions
    Pe_a + Ploss_a = powerConnection_a.W;
    Pe_b + Ploss_b = powerConnection_b.W;
    omega_a = 2*Modelica.Constants.pi*powerConnection_a.f;
    omega_b = 2*Modelica.Constants.pi*powerConnection_b.f;
  initial equation
    if initOpt == ThermoPower3.Choices.Init.Options.noInit then
      // do nothing
    elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
      der(delta_ab) = 0;
    else
      assert(false, "Unsupported initialisation option");
    end if;
    annotation (
      Diagram(graphics),
      Icon(graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>Basic interface of the Network models with two electrical ports, containing the common parameters, variables and connectors.</p>
<p><b>Modelling options</b>
<p>The flow of electrical power from side A to side B is defined by the following relationship:
<ul><tt>Pe_ab = C*sin(delta_ab)</tt></ul> 
<p>where
<ul><tt>delta_ab = delta_a - delta_b</tt></ul>
<p>is the relative load angle.</p>
<p><tt>delta_a</tt> and <tt>delta_b</tt> are the phases of the rotating frames in the corresponding ports.
<p>The electrical power loss on each side are described by the variables <tt>Ploss_a</tt> and <tt>Ploss_b</tt>.
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end Network2portBase;

  model NetworkTwoGenerators_eX
    "Connection: generator(a) - generator(b); Parameters: voltages and reactances"
    extends ThermoPower3.Electrical.Network2portBase(deltaStart=deltaStart_ab,
        final C_ab=e_a*e_b/(X_a + X_b + Xline));
    parameter Boolean hasBreaker=false
      "Model includes a breaker controlled by external input";
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
      "Electrical damping of generator/shaft system (generator A)" annotation (
        dialog(enable=if J_a > 0 then true else false, group="Generator side A"));
    parameter Integer Np_a=2 "Number of electrical poles (generator A)"
      annotation (dialog(enable=if J_a > 0 then true else false, group=
            "Generator side A"));
    parameter Modelica.SIunits.MomentOfInertia J_b=0
      "Moment of inertia of the generator/shaft system B (for damping term calculation only)"
      annotation (Dialog(group="Generator side B"));
    parameter Real r_b=0.2
      "Electrical damping of generator/shaft system (generator B)" annotation (
        dialog(enable=if J_b > 0 then true else false, group="Generator side B"));
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
    Modelica.Blocks.Interfaces.BooleanInput closed if hasBreaker annotation (
        Placement(transformation(
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

    // Definitions of net powers
    Pe_a = Pe_ab;
    Pe_a = -Pe_b;
    // Definitions of damping power losses
    if J_a > 0 then
      D_a = 2*r_a*sqrt(C_ab*J_a*(2*Modelica.Constants.pi*fnom*Np_a)/(Np_a^2));
    else
      D_a = 0;
    end if;
    if J_b > 0 then
      D_b = 2*r_b*sqrt(C_ab*J_b*(2*Modelica.Constants.pi*fnom*Np_b)/(Np_b^2));
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
<p>Simplified model of connection between two generators based on the swing equation. It completes <tt>Netowrk2portBase</tt> partial model, by defining the power coefficient <tt>C</tt> in terms of the parameters <tt>e_a</tt>, <tt>e_b</tt>, <tt>X_a</tt>, <tt>X_b</tt> and <tt>Xline</tt>.
<p>The net electrical powers of two port coincides with the power <tt>P_ab</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J_a</tt> or <tt>J_b</tt> are zero, zero damping is assumed. Note that <tt>J_a</tt> and <tt>J_b</tt> are only used to compute the dissipative term and should each refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"), Icon(graphics={Line(points={{-54,0},{-94,0}}, color={0,0,0}),Line(
            points={{62,0},{98,0}}, color={0,0,0}),Line(points={{-34,0},{-14,0},
            {12,18}}, color={0,0,0}),Line(points={{14,0},{38,0}}, color={0,0,0}),
            Rectangle(
              extent={{-58,6},{-34,-6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{38,6},{62,-6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
  end NetworkTwoGenerators_eX;

  model NetworkTwoGenerators_Pmax
    "Connection: generator(a) - generator(b); Parameters: maximum power"
    extends ThermoPower3.Electrical.Network2portBase(deltaStart=deltaStart_ab,
        final C_ab=Pmax);
    parameter Boolean hasBreaker=false;
    parameter Modelica.SIunits.Power Pmax "Maximum power transfer";
    parameter Modelica.SIunits.MomentOfInertia J_a=0
      "Moment of inertia of the generator/shaft system A (for damping term calculation only)"
      annotation (Dialog(group="Generator side A"));
    parameter Real r_a=0.2
      "Electrical damping of generator/shaft system (generator A)" annotation (
        dialog(enable=if J_a > 0 then true else false, group="Generator side A"));
    parameter Integer Np_a=2 "Number of electrical poles (generator A)"
      annotation (dialog(enable=if J_a > 0 then true else false, group=
            "Generator side A"));
    parameter Modelica.SIunits.MomentOfInertia J_b=0
      "Moment of inertia of the generator/shaft system B (for damping term calculation only)"
      annotation (Dialog(group="Generator side B"));
    parameter Real r_b=0.2
      "Electrical damping of generator/shaft system (generator B)" annotation (
        dialog(enable=if J_b > 0 then true else false, group="Generator side B"));
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
    Modelica.Blocks.Interfaces.BooleanInput closed if hasBreaker annotation (
        Placement(transformation(
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
      D_a = 2*r_a*sqrt(C_ab*J_a*(2*Modelica.Constants.pi*fnom*Np_a)/(Np_a^2));
    else
      D_a = 0;
    end if;
    if J_b > 0 then
      D_b = 2*r_b*sqrt(C_ab*J_b*(2*Modelica.Constants.pi*fnom*Np_b)/(Np_b^2));
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
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"), Icon(graphics={Line(points={{-54,0},{-94,0}}, color={0,0,0}),Line(
            points={{56,0},{92,0}}, color={0,0,0}),Line(points={{-34,0},{-14,0},
            {12,18}}, color={0,0,0}),Line(points={{14,0},{38,0}}, color={0,0,0}),
            Rectangle(
              extent={{-58,6},{-34,-6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{38,6},{62,-6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
  end NetworkTwoGenerators_Pmax;

  model NetworkGridTwoGenerators "Base class for network with two port"
    extends ThermoPower3.Electrical.Network2portBase(final C_ab=e_a*e_b/(X_a +
          X_b));
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
      "Electrical damping of generator/shaft system (generator A)" annotation (
        dialog(enable=if J_a > 0 then true else false, group="Generator side A"));
    parameter Integer Np_a=2 "Number of electrical poles (generator A)"
      annotation (dialog(enable=if J_a > 0 then true else false, group=
            "Generator side A"));
    parameter Modelica.SIunits.MomentOfInertia J_b=0
      "Moment of inertia of the generator/shaft system B (for damping term calculation only)"
      annotation (Dialog(group="Generator side B"));
    parameter Real r_b=0.2
      "Electrical damping of generator/shaft system (generator B)" annotation (
        dialog(enable=if J_b > 0 then true else false, group="Generator side B"));
    parameter Integer Np_b=2 "Number of electrical poles (generator B)"
      annotation (dialog(enable=if J_b > 0 then true else false, group=
            "Generator side B"));
    parameter Modelica.SIunits.Frequency fnom=50 "Frequency of the network";
    Real D_a "Electrical damping coefficient side A";
    Real D_b "Electrical damping coefficient side B";
    Modelica.SIunits.Power Pe_g "Electrical Power provided to the grid";
    Modelica.SIunits.Power Pe_ag
      "Power transferred from generator A to the grid";
    Modelica.SIunits.Power Pe_bg
      "Power transferred from generator B to the grid";
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
    Modelica.Blocks.Interfaces.BooleanInput closedInternal_grid annotation (
        Placement(transformation(
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
      D_a = 2*r_a*sqrt(C_ab*J_a*(2*Modelica.Constants.pi*fnom*Np_a)/(Np_a^2));
    else
      D_a = 0;
    end if;
    if J_b > 0 then
      D_b = 2*r_b*sqrt(C_ab*J_b*(2*Modelica.Constants.pi*fnom*Np_b)/(Np_b^2));
    else
      D_b = 0;
    end if;
  initial equation
    if initOpt == Choices.Init.Options.noInit then
      // do nothing
    elseif initOpt == Choices.Init.Options.steadyState then
      der(delta_ag) = 0;
    else
      assert(false, "Unsupported initialisation option");
    end if;
    annotation (
      Diagram(graphics),
      Icon(graphics={Line(points={{32,0},{98,0}}, color={0,0,0}),Line(points={{
            -40,0},{-32,0},{-16,8}}, color={0,0,0}),Line(points={{-16,0},{16,0}},
            color={0,0,0}),Line(points={{0,2},{0,12},{8,24}}, color={0,0,0}),
            Line(
              points={{-30,64},{30,64}},
              color={0,0,0},
              thickness=0.5),Line(points={{0,64},{0,26}}, color={0,0,0}),
            Rectangle(
              extent={{-4,54},{4,36}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-4,4},{4,-4}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Line(points={{-36,0},{-102,0}},
            color={0,0,0}),Rectangle(
              extent={{-66,4},{-48,-4}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{48,4},{66,-4}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{8,0},{16,0},{32,8}},
            color={0,0,0})}),
      Documentation(info="<html>
<p>Simplified model of connection between two generators and the grid.
<p>This model adds to <tt>Netowrk2portBase</tt> partial model, in more in comparison to the concepts expressed by the <tt>NetowrkTwoGenerators_eX</tt> model, two further electrical flows: from port_a to grid and from port_b to grid, so that to describe the interactions between two ports and the grid.
<p>The clean electrical powers of two ports are defined by opportune combinations of the power flows introduced.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J_a</tt> or <tt>J_b</tt> are zero, zero damping is assumed. Note that <tt>J_a</tt> and <tt>J_b</tt> are only used to compute the dissipative term and should each refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end NetworkGridTwoGenerators;
  annotation (Documentation(info="<html>
<p>This package allows to describe the flow of active power between a synchronous generator and a grid, through simplified power transmission line models, assuming ideal voltage control. </p>
<p>These models are meant to be used as simplified boundary conditions for a thermal power plant model, rather than for fully modular description of three-phase networks. Specialized libraries should be used for this purpose; bear in mind, however, that full three-phase models of electrical machinery and power lines could make the power plant simulation substantially heavier, if special numeric integration strategies are not adopted.
</html>"));
end Electrical;
