within ORNL_AdvSMR.PRISM.PowerConversionSystem.ElectricGenerators;
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
