within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbines;
model SteamTurbineUnit "Turbine for steam flows"
  import aSMR = ORNL_AdvSMR;
  replaceable package Medium = Modelica.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  extends ThermoPower3.Icons.Water.SteamTurbineUnit;
  parameter Real pnom "Inlet nominal pressure";
  parameter Real wnom "Inlet nominal flowrate";
  parameter Real eta_iso "Isentropic efficiency [PerUnit]";
  parameter Real eta_mech=0.98 "Mechanical efficiency [PerUnit]";
  parameter Real hpFraction
    "Fraction of power provided by the HP turbine [PerUnit]";
  parameter Modelica.SIunits.Time T_HP
    "Time constant of HP mechanical power response";
  parameter Modelica.SIunits.Time T_LP
    "Time constant of LP mechanical power response";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";
  parameter Modelica.SIunits.Pressure pstartin=pnom "Inlet start pressure"
                           annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.SpecificEnthalpy hstartin
    "Inlet enthalpy start value"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.SpecificEnthalpy hstartout
    "Outlet enthalpy start value"
    annotation (Dialog(tab="Initialization"));
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.steadyState
    "Initialization option" annotation (Dialog(tab="Initialization"));
  Medium.ThermodynamicState fluidState_in(p(start=pstartin),h(start=
          hstartin));
  ORNL_AdvSMR.Interfaces.FlangeA inlet(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
                    annotation (Placement(transformation(extent={{-120,
            50},{-80,90}}, rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
                    annotation (Placement(transformation(extent={{80,-90},
            {120,-50}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
     Placement(transformation(extent={{-110,-14},{-84,14}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
     Placement(transformation(extent={{86,-14},{112,14}}, rotation=0)));
  Modelica.SIunits.MassFlowRate w "Mass flowrate";
  Modelica.SIunits.Angle phi "Shaft rotation angle";
  Modelica.SIunits.AngularVelocity omega "Shaft angular velocity";
  Modelica.SIunits.Torque tau "Net torque acting on the turbine";
  Real Kv(unit="kg/(s.Pa)") "Turbine nominal admittance at full throttle";
  Medium.SpecificEnthalpy hin(start=hstartin) "Inlet enthalpy";
  Medium.SpecificEnthalpy hout(start=hstartout) "Outlet enthalpy";
  Medium.SpecificEnthalpy hiso(start=hstartout) "Isentropic outlet enthalpy";
  Modelica.SIunits.Power Pm "Mechanical power input";
  Modelica.SIunits.Power P_HP "Mechanical power produced by the HP turbine";
  Modelica.SIunits.Power P_LP "Mechanical power produced by the LP turbine";
  Modelica.Blocks.Interfaces.RealInput partialArc annotation (Placement(
        transformation(extent={{-110,-88},{-74,-52}}, rotation=0)));
equation
  if cardinality(partialArc) == 0 then
    partialArc = 1 "Default value if not connected";
  end if;
  Kv = partialArc*wnom/pnom "Definition of Kv coefficient";
  w = Kv*inlet.p "Flow characteristics";
  hiso = Medium.isentropicEnthalpy(outlet.p, fluidState_in)
    "Isentropic enthalpy";
  hin - hout = eta_iso*(hin - hiso) "Computation of outlet enthalpy";
  Pm = eta_mech*w*(hin - hout) "Mechanical power from the fluid";
  T_HP*der(P_HP) = Pm*hpFraction - P_HP "Power output to HP turbine";
  T_LP*der(P_LP) = Pm*(1 - hpFraction) - P_LP "Power output to LP turbine";
  P_HP + P_LP = -tau*omega "Mechanical power balance";

  // Mechanical boundary conditions
  shaft_a.phi = phi;
  shaft_b.phi = phi;
  shaft_a.tau + shaft_b.tau = tau;
  der(phi) = omega;

  // Fluid boundary conditions and inlet fluid properties
  fluidState_in = Medium.setState_ph(inlet.p, hin);
  hin = inStream(inlet.h_outflow);
  hout = outlet.h_outflow;
  w = inlet.m_flow;

  inlet.m_flow + outlet.m_flow = 0 "Mass balance";
  assert(w >= 0, "The turbine model does not support flow reversal");

  // The next equation is provided to close the balance but never actually used
  inlet.h_outflow = outlet.h_outflow;
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(P_HP) = 0;
    der(P_LP) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (
    Icon(graphics={Text(extent={{-108,-80},{108,-110}}, textString=
          "%name"),Line(
                  points={{-74,-70},{-74,-70},{-56,-70},{-56,-30}},
                  color={0,0,0},
                  thickness=0.5)}),
    Documentation(info="<HTML>
<p>This model describes a simplified steam turbine unit, with a high pressure and a low pressure turbine.<p>
The inlet flowrate is proportional to the inlet pressure, and to the <tt>partialArc</tt> signal if the corresponding connector is wired. In this case, it is assumed that the flow rate is reduced by partial arc admission, not by throttling (i.e., no loss of thermodynamic efficiency occurs). To simulate throttling, insert a valve before the turbine unit inlet.
<p>The model assumes that a fraction <tt>hpFraction</tt> of the available hydraulic power is converted by the HP turbine with a time constant of <tt>T_HP</tt>, while the remaining part is converted by the LP turbine with a time constant of <tt>L_HP</tt>.
<p>This model does not include any shaft inertia by itself; if that is needed, connect a <tt>Modelica.Mechanics.Rotational.Inertia</tt> model to one of the shaft connectors.
<p>The model requires the <tt>Modelica.Media</tt> library (<tt>ThermoFluid</tt> does not compute the isentropic enthalpy correctly).
</HTML>",
  revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>4 Aug 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Diagram(graphics));
end SteamTurbineUnit;
