within ORNL_AdvSMR.Components;
model Drum2States
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.Drum;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium model";
  parameter Modelica.SIunits.Volume Vd "Drum volume";
  parameter Modelica.SIunits.Volume Vdcr "Volume of downcomer and risers";
  parameter Modelica.SIunits.Mass Mmd "Drum metal mass";
  parameter Modelica.SIunits.Mass Mmdcr "Metal mass of downcomer and risers";
  parameter Modelica.SIunits.SpecificHeatCapacity cm
    "Specific heat capacity of the metal";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  parameter Modelica.SIunits.Pressure pstart "Pressure start value"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Volume Vldstart "Start value of drum water volume"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  Medium.SaturationProperties sat "Saturation conditions";
  ORNL_AdvSMR.Interfaces.FlangeA feed(redeclare package Medium = Medium, m_flow(
        min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-110,-64},{-70,-24}},
          rotation=0)));
  ORNL_AdvSMR.Interfaces.FlangeB steam(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{48,52},{88,92}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat
    "Metal wall thermal port" annotation (Placement(transformation(extent={{-28,
            -100},{28,-80}}, rotation=0)));
  Modelica.SIunits.Mass Ml "Liquid water mass";
  Modelica.SIunits.Mass Mv "Steam mass";
  Modelica.SIunits.Mass M "Total liquid+steam mass";
  Modelica.SIunits.Energy E "Total energy";
  Modelica.SIunits.Volume Vt "Total volume";
  Modelica.SIunits.Volume Vl(start=Vldstart + Vdcr) "Liquid water total volume";
  Modelica.SIunits.Volume Vld(start=Vldstart, stateSelect=StateSelect.prefer)
    "Liquid water volume in the drum";
  Modelica.SIunits.Volume Vv "Steam volume";
  Medium.AbsolutePressure p(start=pstart,stateSelect=StateSelect.prefer)
    "Drum pressure";
  Modelica.SIunits.MassFlowRate qf "Feedwater mass flowrate";
  Modelica.SIunits.MassFlowRate qs "Steam mass flowrate";
  Modelica.SIunits.HeatFlowRate Q "Heat flow to the risers";
  Medium.SpecificEnthalpy hf "Feedwater specific enthalpy";
  Medium.SpecificEnthalpy hl "Specific enthalpy of saturated liquid";
  Medium.SpecificEnthalpy hv "Specific enthalpy of saturated steam";
  Medium.Temperature Ts "Saturation temperature";
  Medium.Density rhol "Density of saturated liquid";
  Medium.Density rhov "Density of saturated steam";
equation
  Ml = Vl*rhol "Mass of liquid";
  Mv = Vv*rhov "Mass of vapour";
  M = Ml + Mv "Total mass";
  E = Ml*hl + Mv*hv - p*Vt + (Mmd + Mmdcr)*cm*Ts "Total energy";
  Ts = sat.Tsat "Saturation temperature";
  der(M) = qf - qs "Mass balance";
  der(E) = Q + qf*hf - qs*hv "Energy balance";
  Vl = Vld + Vdcr "Liquid volume";
  Vt = Vd + Vdcr "Total volume";
  Vt = Vl + Vv "Total volume";

  // Boundary conditions
  p = feed.p;
  p = steam.p;
  hf = homotopy(if not allowFlowReversal then inStream(feed.h_outflow) else
    actualStream(feed.h_outflow), inStream(feed.h_outflow));
  feed.m_flow = qf;
  -steam.m_flow = qs;
  feed.h_outflow = hl;
  steam.h_outflow = hv;
  Q = heat.Q_flow;
  heat.T = Ts;

  // Fluid properties
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
initial equation
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    der(p) = 0;
    der(Vld) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Diagram(graphics),
    Documentation(info="<HTML>
<p>Simplified model of a drum for drum boilers. This model assumes thermodynamic equilibrium between the liquid and vapour volumes. The model has two state variables (i.e., pressure and liquid volume).
</HTML>", revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>24 Sep 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 May 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Icon(graphics));
end Drum2States;
