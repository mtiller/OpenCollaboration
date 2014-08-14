within ORNL_AdvSMR.Correlations;
function f_dittus_boelter
  "Dittus-Boelter correlation for one-phase flow in a tube"

  input Modelica.SIunits.MassFlowRate w;
  input Modelica.SIunits.Length D;
  input Modelica.SIunits.Area A;
  input Modelica.SIunits.DynamicViscosity mu;
  input Modelica.SIunits.ThermalConductivity k;
  input Modelica.SIunits.SpecificHeatCapacity cp;
  output Modelica.SIunits.CoefficientOfHeatTransfer hTC;
protected
  Real Re;
  Real Pr;
algorithm
  Re := abs(w)*D/A/mu;
  Pr := cp*mu/k;
  hTC := 0.023*k/D*Re^0.8*Pr^0.4;
  annotation (Documentation(info="<HTML>
<p>Dittus-Boelter's correlation for the computation of the heat transfer coefficient in one-phase flows.
<p><b>Revision history:</b></p>
<ul>
<li><i>20 Dec 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
Input variables changed. This function now computes the heat transfer coefficient as a function of all the required fluid properties and flow parameters.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end f_dittus_boelter;
