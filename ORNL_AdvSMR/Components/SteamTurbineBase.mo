within ORNL_AdvSMR.Components;
partial model SteamTurbineBase "Steam turbine"
  import aSMR = ORNL_AdvSMR;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model";
  parameter Boolean explicitIsentropicEnthalpy=true
    "Outlet enthalpy computed by isentropicEnthalpy function";
  parameter Modelica.SIunits.MassFlowRate wstart=wnom
    "Mass flow rate start value" annotation (Dialog(tab="Initialisation"));
  parameter Real PRstart "Pressure ratio start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.MassFlowRate wnom "Inlet nominal flowrate";
  parameter Modelica.SIunits.Pressure pnom "Nominal inlet pressure";
  parameter Real eta_mech=0.98 "Mechanical efficiency";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";

  Medium.ThermodynamicState steamState_in;
  Medium.ThermodynamicState steamState_iso;

  Modelica.SIunits.Angle phi "shaft rotation angle";
  Modelica.SIunits.Torque tau "net torque acting on the turbine";
  Modelica.SIunits.AngularVelocity omega "shaft angular velocity";
  Modelica.SIunits.MassFlowRate w(start=wstart) "Mass flow rate";
  Medium.SpecificEnthalpy hin "Inlet enthalpy";
  Medium.SpecificEnthalpy hout "Outlet enthalpy";
  Medium.SpecificEnthalpy hiso "Isentropic outlet enthalpy";
  Medium.SpecificEntropy sin "Inlet entropy";
  Medium.AbsolutePressure pin(start=pnom) "Outlet pressure";
  Medium.AbsolutePressure pout(start=pnom/PRstart) "Outlet pressure";
  Real PR "pressure ratio";
  Modelica.SIunits.Power Pm "Mechanical power input";
  Real eta_iso "Isentropic efficiency";

  Modelica.Blocks.Interfaces.RealInput partialArc annotation (Placement(
        transformation(extent={{-80,-60},{-60,-40}}, rotation=0),
        iconTransformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  ORNL_AdvSMR.Interfaces.FlangeA inlet(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-130,70},{-90,110}}, rotation
          =0), iconTransformation(extent={{-110,90},{-90,110}})));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{70,-130},{110,-90}}, rotation
          =0), iconTransformation(extent={{90,-110},{110,-90}})));

equation
  PR = pin/pout "Pressure ratio";
  if cardinality(partialArc) == 0 then
    partialArc = 1 "Default value if not connected";
  end if;
  if explicitIsentropicEnthalpy then
    hiso = Medium.isentropicEnthalpy(pout, steamState_in) "Isentropic enthalpy";
    //dummy assignments
    sin = 0;
    steamState_iso = Medium.setState_ph(1e5, 1e5);
  else
    sin = Medium.specificEntropy(steamState_in);
    steamState_iso = Medium.setState_ps(pout, sin);
    hiso = Medium.specificEnthalpy(steamState_iso);
  end if;
  hin - hout = eta_iso*(hin - hiso) "Computation of outlet enthalpy";
  Pm = eta_mech*w*(hin - hout) "Mechanical power from the steam";
  Pm = -tau*omega "Mechanical power balance";

  inlet.m_flow + outlet.m_flow = 0 "Mass balance";
  // assert(w >= -wnom/100, "The turbine model does not support flow reversal");

  // Mechanical boundary conditions
  shaft_a.phi = phi;
  shaft_b.phi = phi;
  shaft_a.tau + shaft_b.tau = tau;
  der(phi) = omega;

  // steam boundary conditions and inlet steam properties
  steamState_in = Medium.setState_ph(pin, inStream(inlet.h_outflow));
  hin = inStream(inlet.h_outflow);
  hout = outlet.h_outflow;
  pin = inlet.p;
  pout = outlet.p;
  w = inlet.m_flow;
  // The next equation is provided to close the balance but never actually used
  inlet.h_outflow = outlet.h_outflow;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Text(extent={{-100,-79},{100,-100}}, textString="%name"),
        Polygon(
          points={{-70,94},{-70,32},{-60,34},{-60,105},{-92,105},{-92,94},{-70,
              94}},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{10,-22},{3.67395e-016,-20},{-1.3471e-015,19},{-21,19},{-21,
              28},{10,28},{10,-22}},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={70,-77},
          rotation=180),
        Bitmap(extent={{-91,20},{91,-20}}, fileName=
              "modelica://SMR/../../Desktop/rotor.png"),
        Bitmap(extent={{-102,83},{102,-87}}, fileName=
              "modelica://ORNL_AdvSMR/Icons/turbine.png")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Documentation(info="<html>
<p>This base model contains the basic interface, parameters and definitions for steam turbine models. It lacks the actual performance characteristics, i.e. two more equations to determine the flow rate and the efficiency.
<p>This model does not include any shaft inertia by itself; if that is needed, connect a <tt>Modelica.Mechanics.Rotational.Inertia</tt> model to one of the shaft connectors.
<p><b>Modelling options</b></p>
<p>The following options are available to calculate the enthalpy of the outgoing steam:
<ul><li><tt>explicitIsentropicEnthalpy = true</tt>: the isentropic enthalpy <tt>hout_iso</tt> is calculated by the <tt>Medium.isentropicEnthalpy</tt> function. <li><tt>explicitIsentropicEnthalpy = false</tt>: the isentropic enthalpy is given equating the specific entropy of the inlet steam <tt>steam_in</tt> and of a fictional steam state <tt>steam_iso</tt>, which has the same pressure of the outgoing steam, both computed with the function <tt>Medium.specificEntropy</tt>.</pp></ul>
</html>", revisions="<html>
<ul>
<li><i>20 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
<li><i>5 Oct 2011</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Small changes in alias variables.</li>
</ul>
</html>"));
end SteamTurbineBase;
