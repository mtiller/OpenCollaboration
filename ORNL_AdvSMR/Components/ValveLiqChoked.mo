within ORNL_AdvSMR.Components;
model ValveLiqChoked
  "Valve for liquid water flow, allows choked flow conditions"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Components.ValveBase(redeclare replaceable package Medium
      = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium);
  import ORNL_AdvSMR.Choices.Valve.CvTypes;
  parameter Real Flnom=0.9 "Liquid pressure recovery factor";
  replaceable function Flfun = ORNL_AdvSMR.Functions.ValveCharacteristics.one
    constrainedby ORNL_AdvSMR.Functions.ValveCharacteristics.baseFun
    "Pressure recovery characteristic";
  Modelica.SIunits.MassFlowRate w "Mass flowrate";
  Real Ff "Ff coefficient (see IEC/ISA standard)";
  Real Fl "Pressure recovery coefficient Fl (see IEC/ISA standard)";
  ORNL_AdvSMR.SIunits.AbsolutePressure pv "Saturation pressure";
  Modelica.SIunits.Pressure dpEff "Effective pressure drop";
initial equation
  if CvData == CvTypes.OpPoint then
    wnom = FlowChar(theta)*Av*sqrt(rhonom)*sqrtR(dpnom)
      "Determination of Av by the operating point";
  end if;
equation
  pv = Medium.saturationPressure(Tin);
  Ff = 0.96 - 0.28*sqrt(pv/Medium.fluidConstants[1].criticalPressure);
  Fl = Flnom*Flfun(theta);
  dpEff = if outlet.p < (1 - Fl^2)*inlet.p + Ff*Fl^2*pv then Fl^2*(inlet.p - Ff
    *pv) else inlet.p - outlet.p
    "Effective pressure drop, accounting for possible choked conditions";
  if CheckValve then
    w = homotopy(FlowChar(theta)*Av*sqrt(rho)*(if dpEff >= 0 then sqrtR(dpEff)
       else 0), theta/thetanom*wnom/dpnom*(inlet.p - outlet.p));
  else
    w = homotopy(FlowChar(theta)*Av*sqrt(rho)*sqrtR(dpEff), theta/thetanom*wnom
      /dpnom*(inlet.p - outlet.p));
  end if;
  annotation (
    Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
    Diagram(graphics),
    Documentation(info="<HTML>
<p>Liquid water valve model according to the IEC 534/ISA S.75 standards for valve sizing, incompressible fluid, with possible choked flow conditions. <p>
Extends the <tt>ValveBase</tt> model (see the corresponding documentation for common valve features).<p>
The model operating range includes choked flow operation, which takes place for low outlet pressures due to flashing in the vena contracta; otherwise, non-choking conditions are assumed.
<p>The default liquid pressure recovery coefficient <tt>Fl</tt> is constant and given by the parameter <tt>Flnom</tt>. The relative change (per unit) of the recovery coefficient can be specified as a given function of the valve opening by customising the <tt>Flfun</tt> function.
<p>If the flow coefficient is specified in terms of a nominal operating point, this should be in non-chocked conditions.
</HTML>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Rewritten with sqrtReg.</li>
<<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Valve model restructured using inheritance. <br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end ValveLiqChoked;
