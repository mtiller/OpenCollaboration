within ORNL_AdvSMR.Correlations;
function f_colebrook "Fanning friction factor for water/steam flows"
  input Modelica.SIunits.MassFlowRate w;
  input Real D_A;
  input Real e;
  input Modelica.SIunits.DynamicViscosity mu;
  output Real f;
protected
  Real Re;
algorithm
  Re := abs(w)*D_A/mu;
  Re := if Re > 2100 then Re else 2100;
  f := 0.332/(Modelica.Math.log(e/3.7 + 5.47/Re^0.9)^2);
  annotation (Documentation(info="<HTML>
<p>The Fanning friction factor is computed by Colebrook's equation, assuming turbulent, one-phase flow. For low Reynolds numbers, the limit value for turbulent flow is returned.
<p><b>Revision history:</b></p>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end f_colebrook;
