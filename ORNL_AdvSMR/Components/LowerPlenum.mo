within ORNL_AdvSMR.Components;
model LowerPlenum "Lower plenum model with outlet manifold"

  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";

  replaceable package CoverGasMedium =
      ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases.Ar constrainedby
    Modelica.Media.Interfaces.PartialMedium "Cover gas medium model";

  Medium.ThermodynamicState fluidState "Thermodynamic state of the fluid";
  parameter Modelica.SIunits.Volume V "Inner volume";
  parameter Modelica.SIunits.Area S=0 "Internal surface";
  parameter Modelica.SIunits.Position H=0 "Elevation of outlet over inlet"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma=0
    "Heat Transfer Coefficient" annotation (Evaluate=true);
  parameter Modelica.SIunits.HeatCapacity Cm=0 "Metal Heat Capacity"
    annotation (Evaluate=true);
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter ORNL_AdvSMR.Choices.FluidPhase.FluidPhases FluidPhaseStart=
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid
    "Fluid phase (only for initialization!)"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Pressure pstart "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart=if FluidPhaseStart ==
      ThermoPower3.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ThermoPower3.Choices.FluidPhase.FluidPhases.Steam
       then 3e6 else 1e6 "Specific enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Temperature Tmstart=300
    "Metal wall temperature start value"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  ORNL_AdvSMR.Interfaces.FlangeA inlet(
    h_outflow(start=hstart),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-122,-20},{-80,20}}, rotation
          =0), iconTransformation(extent={{-120,-20},{-80,20}})));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(
    h_outflow(start=hstart),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0),
        iconTransformation(extent={{80,-20},{120,20}})));
  replaceable ORNL_AdvSMR.Interfaces.HeatPort_a thermalPort
    "Internal surface of metal wall" annotation (Dialog(enable=false),
      Placement(transformation(extent={{-24,85.5},{24,99.5}}, rotation=0),
        iconTransformation(extent={{-24,85.5},{24,99.5}})));

public
  Modelica.SIunits.Pressure p(
    start=pstart,
    fixed=false,
    stateSelect=if Medium.singleState then StateSelect.avoid else StateSelect.prefer)
    "Fluid pressure at the outlet";
  Modelica.SIunits.SpecificEnthalpy h(start=hstart, stateSelect=StateSelect.prefer)
    "Fluid specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hi "Inlet specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy ho "Outlet specific enthalpy";
  Modelica.SIunits.Mass M "Fluid mass";
  Modelica.SIunits.Energy Q "Fluid internal energy";
  ThermoPower3.AbsoluteTemperature T "Fluid temperature";
  Modelica.SIunits.Mass Mg "Cover gas mass";
  Modelica.SIunits.Energy Qg "Cover gas internal energy";
  ThermoPower3.AbsoluteTemperature Tm(start=Tmstart) "Wall temperature";
  Modelica.SIunits.Time Tr "Residence time";
  Real dM_dt(unit="kg/s");
  Real dQ_dt(unit="W");
  Real dp_dt(unit="Pa/s");
  Real dMg_dt(unit="kg/s");
  Real dQg_dt(unit="W");
  Real dpg_dt(unit="Pa/s");

  Boolean ss=Medium.singleState;

equation
  if Medium.singleState then
    dp_dt = der(p);
  else
    dp_dt = der(p);
  end if;

  // Set fluid properties
  fluidState = Medium.setState_ph(p, h);
  T = Medium.temperature(fluidState);
  M = V*Medium.density(fluidState) "Fluid mass";
  dM_dt = V*(Medium.density_derp_h(fluidState)*dp_dt + Medium.density_derh_p(
    fluidState)*der(h));
  dM_dt = inlet.m_flow + outlet.m_flow "Fluid mass balance";

  //
  Q = M*h - p*V "Fluid energy";
  dQ_dt = h*dM_dt + M*der(h) - V*dp_dt;
  dQ_dt = inlet.m_flow*hi + outlet.m_flow*ho + gamma*S*(Tm - T) + thermalPort.Q_flow
    "Fluid energy balance";

  if Cm > 0 and gamma > 0 then
    Cm*der(Tm) = gamma*S*(T - Tm) "Energy balance of the built-in wall model";
  else
    Tm = T "Trivial equation for metal temperature";
  end if;

  // Boundary conditions
  hi = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else
    actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
  ho = homotopy(if not allowFlowReversal then h else actualStream(outlet.h_outflow),
    h);
  inlet.h_outflow = h;
  outlet.h_outflow = h;
  inlet.p = p + Medium.density(fluidState)*Modelica.Constants.g_n*H;
  outlet.p = p;
  thermalPort.T = T;

  Tr = noEvent(M/max(abs(inlet.m_flow), Modelica.Constants.eps))
    "Residence time";
initial equation
  // Initial conditions
  Modelica.Utilities.Streams.print(" - INITIALIZATION IN HEADER - ", "");
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(h) = 0;
    if (not Medium.singleState) then
      der(p) = 0;
    end if;
    if (Cm > 0 and gamma > 0) then
      der(Tm) = 0;
    end if;
    Modelica.Utilities.Streams.print("p = " + String(p) + "    h = " + String(h),
      "");
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyStateNoP then
    der(h) = 0;
    if (Cm > 0 and gamma > 0) then
      der(Tm) = 0;
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  Modelica.Utilities.Streams.print(" - INITIALIZATION IN HEADER FINISHED - ",
    "");

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-85,85},{85,-85}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-85,85},{85,-85}},
          pattern=LinePattern.None,
          lineColor={135,135,135},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=180)}),
    Documentation(info="<HTML>
<p>This model describes a constant volume header with metal walls. The fluid can be water, steam, or a two-phase mixture. 
<p>It is possible to take into account the heat storage and transfer in the metal wall in two ways:
<ul>
<li>
  Leave <tt>InternalSurface</tt> unconnected, and set the appropriate
  values for the total wall heat capacity <tt>Cm</tt>, surface <tt>S</tt>
  and heat transfer coefficient <tt>gamma</tt>. In this case, the metal
  wall temperature is considered as uniform, and the wall is thermally
  insulated from the outside.
</li>
<li>
  Set <tt>Cm = 0</tt>, and connect a suitable thermal model of the the
  wall to the <tt>InternalSurface</tt> connector instead. This can be
  useful in case a more detailed thermal model is needed, e.g. for 
  thermal stress studies.
</li>
</ul>
<p>The model can represent an actual header when connected to the model of a bank of tubes (e.g., <tt>Flow1D</tt> with <tt>Nt>1</tt>).</p>
</HTML>", revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>12 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>InternalSurface</tt> connector added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>28 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added head between inlet and outlet.</li>
<li><i>7 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Changed name from <tt>Collector</tt> to <tt>Header</tt>.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics));
end LowerPlenum;
