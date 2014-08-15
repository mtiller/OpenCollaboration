within Ethan2;
model SteamDrumSeperator
  extends ThermoPower3.Icons.Water.Drum;
  replaceable package Medium = ThermoPower3.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium model";
//  parameter Modelica.SIunits.Volume Vt "Drum volume";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ThermoPower3.System system "System wide properties";
  parameter Modelica.SIunits.Pressure pstart "Pressure start value" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Mass Mlstart "Start value of drum liquid volume" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Mass Mvstart "Start value of drum vapor volume" annotation (Dialog(tab="Initialisation"));
  parameter ThermoPower3.Choices.Init.Options initOpt=ThermoPower3.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  Medium.SaturationProperties sat "Saturation conditions";
  ThermoPower3.Water.FlangeA feed(redeclare package Medium = Medium, m_flow(min=
         if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
     Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  ThermoPower3.Water.FlangeB steam(redeclare package Medium = Medium, m_flow(
        max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{78,-20},{118,20}}, rotation=0),
        iconTransformation(extent={{78,-20},{118,20}})));
//  Modelica.SIunits.Mass Ml "Liquid water mass";
//  Modelica.SIunits.Mass Mv "Steam mass";
//  Modelica.SIunits.Mass M "Total liquid+steam mass";
//  Modelica.SIunits.Energy E "Total energy";
  Modelica.SIunits.Mass Ml(start=Mlstart) "Liquid water total volume";
  Modelica.SIunits.Mass Mv(start=Mvstart) "Steam volume";
  Medium.AbsolutePressure p(start=pstart) "Drum pressure";
  Modelica.SIunits.MassFlowRate qf "Feedwater mass flowrate";
  Modelica.SIunits.MassFlowRate qs "Steam mass flowrate";
  Medium.SpecificEnthalpy hf "Feedwater specific enthalpy";
  Medium.SpecificEnthalpy hl "Specific enthalpy of liquid";
  Medium.SpecificEnthalpy hv "Specific enthalpy of steam";
  Medium.SpecificEnthalpy hls "Specific enthalpy of saturated liquid";
  Medium.SpecificEnthalpy hvs "Specific enthalpy of saturated steam";
  Medium.Density rhol "Density of saturated liquid";
  Medium.Density rhov "Density of saturated steam";

  //changes
  Real x;
  Modelica.SIunits.MassFlowRate qc "condensate mass flowrate";
  parameter Modelica.SIunits.Volume Vnom;
  parameter Modelica.SIunits.Area Anom;
//  parameter Real Rsp(unit="J/(kg.K)")=500;
  constant Real eps = 1e-3;
  Modelica.SIunits.Power conserve;
  Modelica.SIunits.MassFlowRate qe "expected steam flowrate";

  ThermoPower3.Water.FlangeB cond(redeclare package Medium = Medium, m_flow(max=
         if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
     Placement(transformation(extent={{-20,-120},{20,-80}},
                                                          rotation=0),
        iconTransformation(extent={{-20,-120},{20,-80}})));
equation
    conserve = qf*hf - qc*hl - qs*hv "should be and is 0";
  //x is not used but is there for tracking
  x = if hf >= hv then (1-eps) elseif hf <= hl then eps else max(min((1-eps),(hf - hl)/(hvs - hls)),eps);
  qe = x*qf;
//original
//  Ml = Vl*rhol "Mass of liquid";
  der(Ml) = (1-x)*qf - qc "mass balance on liquid";
//  Mv = Vv*rhov "Mass of vapour";
  der(Mv) =    x *qf - qs "mass balance on vapor";
//  Vt = Vl + Vv "Total volume";
//  M = Ml + Mv "Total mass";
//  Ev = Mv*hv "vapor energy";
//  El = Ml*hl;
//  der(M) = qf - qs - qc "Mass balance";
//  der(E) = qf*hf - qs*steam.h_outflow - qc*cond.h_outflow "Energy balance";

  // Boundary conditions
  p = feed.p;
  p = steam.p;
  p = cond.p;
//  p = cond.p + (Ml/Ams)*9.81;
//  p = steam.p + (Mv*hv/Vt);

  qc = qf-qs;
  feed.h_outflow = hls;
  steam.h_outflow = max(hv,hf);
  cond.h_outflow = min(hl,hf);
  hf = inStream(feed.h_outflow);

  hl = min(hls,hf);
  hv = max(hvs,hf);

  feed.m_flow = qf;
  -steam.m_flow = max(qs,0.00001) "prevent 0 flow";
  -cond.m_flow = max(qc,0.00001) "prevent 0 flow";

  // Fluid properties
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  rhol = Medium.bubbleDensity(sat);
  rhov = Medium.dewDensity(sat);
  hls = Medium.bubbleEnthalpy(sat);
  hvs = Medium.dewEnthalpy(sat);

initial equation
  if initOpt == ThermoPower3.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ThermoPower3.Choices.Init.Options.steadyState then
//    der(p) = 0;
    der(Mv) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
 annotation (
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
end SteamDrumSeperator;
