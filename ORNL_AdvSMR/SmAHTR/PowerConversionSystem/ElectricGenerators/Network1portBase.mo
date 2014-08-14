within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.ElectricGenerators;
partial model Network1portBase "Base class for one-port network"
  parameter Boolean hasBreaker=false
    "Model includes a breaker controlled by external input";
  parameter Modelica.SIunits.Angle deltaStart=0 "Start value of the load angle"
    annotation (Dialog(tab="Initialization"));
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialization option" annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Power C "Max. power transfer";
  Modelica.SIunits.Power Pe "Net electrical power";
  Modelica.SIunits.Power Ploss "Electrical power loss";
  Modelica.SIunits.AngularVelocity omega "Angular velocity";
  Modelica.SIunits.AngularVelocity omegaRef "Angular velocity reference";
  Modelica.SIunits.Angle delta(stateSelect=StateSelect.prefer, start=
        deltaStart) "Load angle";

  PowerConnection powerConnection annotation (Placement(transformation(
          extent={{-114,-14},{-86,14}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput closed if hasBreaker
    annotation (Placement(transformation(
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
</html>",
  revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
end Network1portBase;
