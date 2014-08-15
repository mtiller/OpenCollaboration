within Ethan2;
model Condenser
  extends ThermoPower3.Icons.Water.Drum;
  replaceable package Medium = ThermoPower3.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hext = 100
    "condesner heat transfer";
  parameter Modelica.SIunits.Area Aext = 30 "condenser area";
  parameter Modelica.SIunits.Temperature Text = 300 "coolant temp";
  parameter Modelica.SIunits.Volume Vt "Drum volume";
  parameter Modelica.SIunits.Mass Mmd "Drum metal mass";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";
  parameter Modelica.SIunits.Pressure pstart "Pressure start value";
  parameter Modelica.SIunits.Volume Vldstart "Start value of drum water volume"
    annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  Medium.SaturationProperties sat "Saturation conditions";
  ThermoPower3.Water.FlangeA feed(redeclare package Medium = Medium, m_flow(min=
         if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
     Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  ThermoPower3.Water.FlangeB condensate(redeclare package Medium = Medium,
      m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{78,-20},{118,20}}, rotation=0),
        iconTransformation(extent={{78,-20},{118,20}})));
  Modelica.SIunits.Mass Ml "Liquid water mass";

  Modelica.SIunits.Mass Mv "condensate mass";
  Modelica.SIunits.Mass M "Total liquid+steam mass";
  Modelica.SIunits.Energy E "Total energy";
  Modelica.SIunits.Volume Vl(start=Vldstart, stateSelect=StateSelect.prefer)
    "Liquid water volume in the drum";
  Modelica.SIunits.Volume Vv "Steam volume";
  Medium.AbsolutePressure p(start = pstart) "Prescribed Drum pressure";
  Modelica.SIunits.MassFlowRate qf "Feedwater mass flowrate";
  Modelica.SIunits.MassFlowRate qs "condensate mass flowrate";
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
  E = Ml*hl + Mv*hv - p*Vt "Total energy";
  Ts = sat.Tsat "Saturation temperature";
  der(M) = qf - qs "Mass balance";
  der(E) = qf*hf - qs*hl "Energy balance";
  Vt = Vl + Vv "Total volume";

  // Boundary conditions
  p = feed.p;
  p = condensate.p;
  hf = homotopy(if not allowFlowReversal then inStream(feed.h_outflow) else
    actualStream(feed.h_outflow), inStream(feed.h_outflow));
  feed.m_flow = qf;
  -condensate.m_flow = qs;
  feed.h_outflow = hv;
  condensate.h_outflow = if hf < hl then hf else hl;

  // Fluid properties
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);
  hl = Medium.bubbleEnthalpy(sat);
  hv = Medium.dewEnthalpy(sat);
initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
    der(p) = 0;
    der(Vl) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
    annotation (Dialog(tab="Initialisation"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Documentation(info="<HTML>
<p>Simplified model of a drum for drum boilers. This model assumes thermodynamic equilibrium between the liquid and vapour volumes. The model has two state variables (i.e., pressure and liquid volume).
</HTML>",
        revisions="<html>
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
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics));
end Condenser;
