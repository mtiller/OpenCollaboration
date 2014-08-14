within ORNL_AdvSMR.Components;
model ValveVap "Valve for steam flow"
  extends ValveBase;
  import ORNL_AdvSMR.Choices.Valve.CvTypes;
  parameter Real Fxt_full=0.5 "Fk*xt critical ratio at full opening";
  replaceable function xtfun "Critical ratio characteristic"
    import aSMR = ORNL_AdvSMR;
    extends ORNL_AdvSMR.Functions.ValveCharacteristics.one;
  end xtfun constrainedby ORNL_AdvSMR.Functions.ValveCharacteristics.baseFun;
  Real x "Pressure drop ratio";
  Real xs "Saturated pressure drop ratio";
  Real Y "Compressibility factor";
  Real Fxt "Fxt coefficient";
  Medium.AbsolutePressure p "Inlet pressure";
protected
  parameter Real Fxt_nom(fixed=false) "Nominal Fxt";
  parameter Real x_nom(fixed=false) "Nominal pressure drop ratio";
  parameter Real xs_nom(fixed=false) "Nominal saturated pressure drop ratio";
  parameter Real Y_nom(fixed=false) "Nominal compressibility factor";
initial equation
  if CvData == CvTypes.OpPoint then
    // Determination of Av by the nominal operating point conditions
    Fxt_nom = Fxt_full*xtfun(thetanom);
    x_nom = dpnom/pnom;
    xs_nom = smooth(0, if x_nom > Fxt_nom then Fxt_nom else x_nom);
    Y_nom = 1 - abs(xs_nom)/(3*Fxt_nom);
    wnom = FlowChar(thetanom)*Av*Y_nom*sqrt(rhonom)*sqrtR(pnom*xs_nom);
  else
    // Dummy values
    Fxt_nom = 0;
    x_nom = 0;
    xs_nom = 0;
    Y_nom = 0;
  end if;
equation
  p = homotopy(if not allowFlowReversal then inlet.p else noEvent(if dp >= 0
     then inlet.p else outlet.p), inlet.p);
  Fxt = Fxt_full*xtfun(theta);
  x = dp/p;
  xs = smooth(0, if x < -Fxt then -Fxt else if x > Fxt then Fxt else x);
  Y = 1 - abs(xs)/(3*Fxt);
  if CheckValve then
    w = homotopy(FlowChar(theta)*Av*Y*sqrt(rho)*smooth(0, if xs >= 0 then sqrtR(
      p*xs) else 0), theta/thetanom*wnom/dpnom*(inlet.p - outlet.p));
  else
    w = homotopy(FlowChar(theta)*Av*Y*sqrt(rho)*sqrtR(p*xs), theta/thetanom*
      wnom/dpnom*(inlet.p - outlet.p));
  end if;
  annotation (
    Icon(graphics),
    Diagram(graphics),
    Documentation(info="<HTML>
<p>Liquid water valve model according to the IEC 534/ISA S.75 standards for valve sizing, compressible fluid. <p>
Extends the <tt>ValveBase</tt> model (see the corresponding documentation for common valve features).
<p>The product Fk*xt is given by the parameter <tt>Fxt_full</tt>, and is assumed constant by default. The relative change (per unit) of the xt coefficient with the valve opening can be specified by customising the <tt>xtfun</tt> function.
</HTML>", revisions="<html>
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
end ValveVap;
