within ORNL_AdvSMR.Components;
model Mixer "Mixer with metal walls for water/steam flows"

  extends ORNL_AdvSMR.Icons.Water.Mixer;
  replaceable package Medium = ORNL_AdvSMR.Media.Fluids.Na constrainedby
    ORNL_AdvSMR.Media.Interfaces.PartialMedium "Medium model";
  Medium.ThermodynamicState fluidState "Thermodynamic state of the fluid";
  parameter Modelica.SIunits.Volume V "Internal volume";
  parameter Modelica.SIunits.Area S=0 "Internal surface";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma=0
    "Internal Heat Transfer Coefficient" annotation (Evaluate=true);
  parameter Modelica.SIunits.HeatCapacity Cm=0 "Metal Heat Capacity"
    annotation (Evaluate=true);
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter ORNL_AdvSMR.Choices.FluidPhase.FluidPhases FluidPhaseStart=
      ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid
    "Fluid phase (only for initialization!)"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Pressure pstart "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hstart=if FluidPhaseStart ==
      ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if
      FluidPhaseStart == ORNL_AdvSMR.Choices.FluidPhase.FluidPhases.Steam then
      3e6 else 1e6 "Specific enthalpy start value"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.SIunits.AbsoluteTemperature Tmstart=300
    "Metal wall temperature start value"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));
  ORNL_AdvSMR.Interfaces.FlangeA in1(
    h_outflow(start=hstart),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-100,40},{-60,80}}, rotation=
            0)));
  ORNL_AdvSMR.Interfaces.FlangeA in2(
    h_outflow(start=hstart),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-100,-80},{-60,-40}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB out(
    h_outflow(start=hstart),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
  Modelica.SIunits.Pressure p(start=pstart, stateSelect=if Medium.singleState
         then StateSelect.avoid else StateSelect.prefer) "Fluid pressure";
  Medium.SpecificEnthalpy h(start=hstart, stateSelect=StateSelect.prefer)
    "Fluid specific enthalpy";
  Medium.SpecificEnthalpy hi1 "Inlet 1 specific enthalpy";
  Medium.SpecificEnthalpy hi2 "Inlet 2 specific enthalpy";
  Medium.SpecificEnthalpy ho "Outlet specific enthalpy";
  Modelica.SIunits.Mass M "Fluid mass";
  Modelica.SIunits.Energy E "Fluid energy";
  Modelica.SIunits.HeatFlowRate Q "Heat flow rate exchanged with the outside";
  Medium.Temperature T "Fluid temperature";
  ORNL_AdvSMR.SIunits.AbsoluteTemperature Tm(start=Tmstart) "Wall temperature";
  Modelica.SIunits.Time Tr "Residence time";
  replaceable ORNL_AdvSMR.Thermal.HT thermalPort
    "Internal surface of metal wall" annotation (Placement(transformation(
          extent={{-24,66},{24,80}}, rotation=0)));
equation
  // Set fluid properties
  fluidState = Medium.setState_ph(p, h);
  T = Medium.temperature(fluidState);

  M = V*Medium.density(fluidState) "Fluid mass";
  E = M*Medium.specificInternalEnergy(fluidState) "Fluid energy";
  der(M) = in1.m_flow + in2.m_flow + out.m_flow "Fluid mass balance";
  der(E) = in1.m_flow*hi1 + in2.m_flow*hi2 + out.m_flow*ho - gamma*S*(T - Tm)
     + Q "Fluid energy balance";
  if Cm > 0 and gamma > 0 then
    Cm*der(Tm) = gamma*S*(T - Tm) "Metal wall energy balance";
  else
    Tm = T;
  end if;

  // Boundary conditions
  hi1 = homotopy(if not allowFlowReversal then inStream(in1.h_outflow) else
    actualStream(in1.h_outflow), inStream(in1.h_outflow));
  hi2 = homotopy(if not allowFlowReversal then inStream(in2.h_outflow) else
    actualStream(in2.h_outflow), inStream(in2.h_outflow));
  ho = homotopy(if not allowFlowReversal then h else actualStream(out.h_outflow),
    h);
  in1.h_outflow = h;
  in2.h_outflow = h;
  out.h_outflow = h;
  in1.p = p;
  in2.p = p;
  out.p = p;
  thermalPort.Q_flow = Q;
  thermalPort.T = T;

  Tr = noEvent(M/max(abs(out.m_flow), Modelica.Constants.eps)) "Residence time";

initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    der(h) = 0;
    if (not Medium.singleState) then
      der(p) = 0;
    end if;
    if (Cm > 0 and gamma > 0) then
      der(Tm) = 0;
    end if;
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyStateNoP then
    der(h) = 0;
    if (Cm > 0 and gamma > 0) then
      der(Tm) = 0;
    end if;
  else
    assert(false, "Unsupported initialisation option");
  end if;

  annotation (
    Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)),
    Documentation(info="<HTML>
<p>This model describes a constant volume mixer with metal walls. The fluid can be water, steam, or a two-phase mixture. The metal wall temperature and the heat transfer coefficient between the wall and the fluid are uniform. The wall is thermally insulated from the outside.
</HTML>", revisions="<html>
<ul>
<li><i>23 May 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       Thermal port added.</li>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Icon(graphics),
    Diagram(graphics));
end Mixer;
