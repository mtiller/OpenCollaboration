within ORNL_AdvSMR.Correlations;
function f_colebrook_2ph
  "Fanning friction factor for a two phase water/steam flow"
  input Modelica.SIunits.MassFlowRate w;
  input Real D_A;
  input Real e;
  input Modelica.SIunits.DynamicViscosity mul;
  input Modelica.SIunits.DynamicViscosity muv;
  input Real x;
  output Real f;
protected
  Real Re;
protected
  Modelica.SIunits.DynamicViscosity mu;
algorithm
  mu := 1/(x/muv + (1 - x)/mul);
  Re := w*D_A/mu;
  Re := if Re > 2100 then Re else 2100;
  f := 0.332/(Modelica.Math.log(e/3.7 + 5.47/Re^0.9)^2);
  annotation (Documentation(info="<HTML>
<p>The Fanning friction factor is computed by Colebrook's equation, assuming turbulent, homogeneous two-phase flow. For low Reynolds numbers, the limit value for turbulent flow is returned.
<p><b>Revision history:</b></p>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end f_colebrook_2ph;
