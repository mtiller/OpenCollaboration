within ORNL_AdvSMR.Components;
model ValveLiq "Valve for liquid water flow"
  extends ValveBase;
  import ORNL_AdvSMR.Choices.Valve.CvTypes;
initial equation
  if CvData == CvTypes.OpPoint then
    wnom = FlowChar(thetanom)*Av*sqrt(rhonom)*sqrtR(dpnom)
      "Determination of Av by the operating point";
  end if;

equation
  if CheckValve then
    w = homotopy(FlowChar(theta)*Av*sqrt(rho)*smooth(0, if dp >= 0 then sqrtR(
      dp) else 0), theta/thetanom*wnom/dpnom*(inlet.p - outlet.p));
  else
    w = homotopy(FlowChar(theta)*Av*sqrt(rho)*sqrtR(dp), theta/thetanom*wnom/
      dpnom*(inlet.p - outlet.p));
  end if;
  annotation (
    Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
    Diagram(graphics),
    Documentation(info="<HTML>
<p>Liquid water valve model according to the IEC 534/ISA S.75 standards for valve sizing, incompressible fluid. <p>
Extends the <tt>ValveBase</tt> model (see the corresponding documentation for common valve features).
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Rewritten with sqrtReg.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Valve model restructured using inheritance. <br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end ValveLiq;
