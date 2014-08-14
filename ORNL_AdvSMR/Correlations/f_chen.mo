within ORNL_AdvSMR.Correlations;
function f_chen "Chen's correlation for two-phase flow in a tube"

  input Modelica.SIunits.MassFlowRate w "Mass flowrate";
  input Modelica.SIunits.Length D "Tube hydraulic diameter";
  input Modelica.SIunits.Area A "Tube cross-section";
  input Modelica.SIunits.DynamicViscosity muf "Liquid dynamic viscosity";
  input Modelica.SIunits.ThermalConductivity kf "Liquid thermal conductivity";
  input Modelica.SIunits.SpecificHeatCapacity cpf "Liquid cp";
  input ThermoPower3.LiquidDensity rhof "Liquid density";
  input Modelica.SIunits.SurfaceTension sigma "Surface Tension";
  input ThermoPower3.GasDensity rhog "Vapour density";
  input Modelica.SIunits.DynamicViscosity mug "Vapour dynamic viscosity";
  input Modelica.SIunits.Temperature DTsat
    "Saturation temperature difference (wall-bulk)";
  input Modelica.SIunits.Pressure Dpsat
    "Saturation pressure difference (wall-bulk)";
  input Modelica.SIunits.SpecificEnthalpy ifg "Latent heat of vaporization";
  input Real x "Steam quality";
  output Modelica.SIunits.CoefficientOfHeatTransfer hTP
    "Two-phase total heat transfer coefficient";
protected
  Real invXtt;
  Real F;
  Real S;
  Real Ref;
  Real Prf;
  Real ReTP;
  Modelica.SIunits.CoefficientOfHeatTransfer hC;
  Modelica.SIunits.CoefficientOfHeatTransfer hNcB;
algorithm
  invXtt := (x/(1 - x))^0.9*(rhof/rhog)^0.5*(mug/muf)^0.1;
  if invXtt < 0.1 then
    F := 1;
  else
    F := 2.35*(invXtt + 0.213)^0.736;
  end if;
  Ref := (w/A*(1 - x)*D)/muf;
  Prf := (muf*cpf/kf);
  hC := 0.023*Ref^0.8*Prf^0.4*kf/D*F;
  ReTP := F^1.25*Ref;
  S := 1/(1 + 2.53e-6*ReTP^1.17);
  hNcB := 0.00122*(kf^0.79*cpf^0.45*rhof^0.49)/(sigma^0.5*muf^0.29*ifg^0.24*
    rhog^0.24)*max(0, DTsat)^0.24*max(0, Dpsat)^0.75*S;
  hTP := hC + hNcB;
  annotation (Documentation(info="<HTML>
<p>Chen's correlation for the computation of the heat transfer coefficient in two-phase flows.
<p><b>Revision history:</b></p>
<ul>
<li><i>20 Dec 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
end f_chen;
