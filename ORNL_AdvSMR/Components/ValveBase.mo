within ORNL_AdvSMR.Components;
partial model ValveBase "Base model for valves"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.Valve;
  import ORNL_AdvSMR.Choices.Valve.CvTypes;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model";
  Medium.ThermodynamicState fluidState(p(start=pin_start));
  parameter CvTypes CvData=CvTypes.Av "Selection of flow coefficient";
  parameter Modelica.SIunits.Area Av(
    fixed=if CvData == CvTypes.Av then true else false,
    start=wnom/(sqrt(rhonom*dpnom))*FlowChar(thetanom)) = 0
    "Av (metric) flow coefficient" annotation (Dialog(group="Flow Coefficient",
        enable=(CvData == CvTypes.Av)));
  parameter Real Kv(unit="m3/h") = 0 "Kv (metric) flow coefficient" annotation
    (Dialog(group="Flow Coefficient", enable=(CvData == CvTypes.Kv)));
  parameter Real Cv=0 "Cv (US) flow coefficient [USG/min]" annotation (Dialog(
        group="Flow Coefficient", enable=(CvData == CvTypes.Cv)));
  parameter Modelica.SIunits.Pressure pnom "Nominal inlet pressure"
    annotation (Dialog(group="Nominal operating point"));
  parameter Modelica.SIunits.Pressure dpnom "Nominal pressure drop"
    annotation (Dialog(group="Nominal operating point"));
  parameter Modelica.SIunits.MassFlowRate wnom "Nominal mass flowrate"
    annotation (Dialog(group="Nominal operating point"));
  parameter ORNL_AdvSMR.SIunits.Density rhonom=1000 "Nominal density"
    annotation (Dialog(group="Nominal operating point", enable=(CvData ==
          CvTypes.OpPoint)));
  parameter Real thetanom=1 "Nominal valve opening" annotation (Dialog(group=
          "Nominal operating point", enable=(CvData == CvTypes.OpPoint)));
  parameter Modelica.SIunits.Power Qnom=0 "Nominal heat loss to ambient"
    annotation (Dialog(group="Nominal operating point"), Evaluate=true);
  parameter Boolean CheckValve=false "Reverse flow stopped";
  parameter Real b=0.01 "Regularisation factor";
  replaceable function FlowChar =
      ORNL_AdvSMR.Functions.ValveCharacteristics.linear constrainedby
    ORNL_AdvSMR.Functions.ValveCharacteristics.baseFun "Flow characteristic"
    annotation (choicesAllMatching=true);
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  final parameter Modelica.SIunits.Pressure pin_start=pnom
    "Inlet pressure start value" annotation (Dialog(tab="Initialisation"));
  final parameter Modelica.SIunits.Pressure pout_start=pnom - dpnom
    "Inlet pressure start value" annotation (Dialog(tab="Initialisation"));
  Modelica.SIunits.MassFlowRate w "Mass flow rate";
  ORNL_AdvSMR.SIunits.LiquidDensity rho "Inlet density";
  Medium.Temperature Tin;
  Modelica.SIunits.Pressure dp "Pressure drop across the valve";
protected
  function sqrtR = ORNL_AdvSMR.Functions.sqrtReg (delta=b*dpnom);
public
  ORNL_AdvSMR.Interfaces.FlangeA inlet(
    m_flow(start=wnom, min=if allowFlowReversal then -Modelica.Constants.inf
           else 0),
    p(start=pin_start),
    redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-120,-20},{-80,20}}, rotation=0), iconTransformation(extent=
            {{-120,-20},{-80,20}})));
  ORNL_AdvSMR.Interfaces.FlangeB outlet(
    m_flow(start=-wnom, max=if allowFlowReversal then +Modelica.Constants.inf
           else 0),
    p(start=pout_start),
    redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{80,-20},{120,20}}, rotation=0), iconTransformation(extent={{
            80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput theta "Valve opening in per unit"
    annotation (Placement(transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
initial equation
  if CvData == CvTypes.Kv then
    Av = 2.7778e-5*Kv;
  elseif CvData == CvTypes.Cv then
    Av = 2.4027e-5*Cv;
  end if;
  // assert(CvData>=0 and CvData<=3, "Invalid CvData");
equation
  inlet.m_flow + outlet.m_flow = 0 "Mass balance";
  w = inlet.m_flow;

  // Fluid properties
  fluidState = Medium.setState_ph(inlet.p, inStream(inlet.h_outflow));
  Tin = Medium.temperature(fluidState);
  rho = Medium.density(fluidState);

  // Energy balance
  outlet.h_outflow = inStream(inlet.h_outflow) - Qnom/wnom;
  inlet.h_outflow = inStream(outlet.h_outflow) - Qnom/wnom;

  dp = inlet.p - outlet.p "Definition of dp";
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Text(extent={{-100,-40},{100,-80}}, textString=
              "%name")}),
    Diagram(graphics),
    Documentation(info="<HTML>
<p>This is the base model for the <tt>ValveLiq</tt>, <tt>ValveLiqChoked</tt>, and <tt>ValveVap</tt> valve models. The model is based on the IEC 534 / ISA S.75 standards for valve sizing.
<p>The model optionally supports reverse flow conditions (assuming symmetrical behaviour) or check valve operation, and has been suitably modified to avoid numerical singularities at zero pressure drop.</p>
<p>An optional heat loss to the ambient can be included, proportional to the mass flow rate; <tt>Qnom</tt> specifies the heat loss at nominal flow rate.</p> 
<p><b>Modelling options</b></p>
<p>The following options are available to specify the valve flow coefficient in fully open conditions:
<ul><li><tt>CvData = ThermoPower.Water.ValveBase.CvTypes.Av</tt>: the flow coefficient is given by the metric <tt>Av</tt> coefficient (m^2).
<li><tt>CvData = ThermoPower.Water.ValveBase.CvTypes.Kv</tt>: the flow coefficient is given by the metric <tt>Kv</tt> coefficient (m^3/h).
<li><tt>CvData = ThermoPower.Water.ValveBase.CvTypes.Cv</tt>: the flow coefficient is given by the US <tt>Cv</tt> coefficient (USG/min).
<li><tt>CvData = ThermoPower.Water.ValveBase.CvTypes.OpPoint</tt>: the flow coefficient is specified by the nominal operating point:  <tt>pnom</tt>, <tt>dpnom</tt>, <tt>wnom</tt>, <tt>rhonom</tt>, <tt>thetanom</tt> (in forward flow).
</ul>
<p>The nominal pressure drop <tt>dpnom</tt> must always be specified; to avoid numerical singularities, the flow characteristic is modified for pressure drops less than <tt>b*dpnom</tt> (the default value is 1% of the nominal pressure drop). Increase this parameter if numerical instabilities occur in valves with very low pressure drops.
<p>If <tt>CheckValve</tt> is true, then the flow is stopped when the outlet pressure is higher than the inlet pressure; otherwise, reverse flow takes place.
<p>The default flow characteristic <tt>FlowChar</tt> is linear; it can be replaced by functions taken from <tt>Functions.ValveCharacteristics</tt>, or by any suitable user-defined function extending <tt>Functions.ValveCharacteristics.baseFun</tt>.
</HTML>", revisions="<html>
<ul>
<li><i>17 Jul 2012</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added heat loss to ambient (defaults to zero).</li>
<li><i>5 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Moved replaceable characteristics to Function.ValveCharacteristics package.</li>
<li><i>29 Sep 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Re-introduced valve sizing by an operating point.</li>
<li><i>6 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Enumeration-type choice of CvData.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>18 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>Avnom</tt> removed; <tt>Av</tt> can now be set directly. <tt>Kvnom</tt> and <tt>Cvnom</tt> renamed to <tt>Kv</tt> and <tt>Cv</tt>.<br>
<tt>CvData=3</tt> no longer uses <tt>dpnom</tt>, <tt>wnom</tt> and <tt>rhonom</tt>, and requires an additional initial equation to set the flow coefficient based on the initial working conditions.
<li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Valve models restructured using inheritance. <br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end ValveBase;
