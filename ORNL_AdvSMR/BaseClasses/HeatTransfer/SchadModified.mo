within ORNL_AdvSMR.BaseClasses.HeatTransfer;
model SchadModified
  "Schad-modified correlation for liquid metal coolants in flow bundles (1.1 <= P/D <= 1.5 and Pe <= 1000)"
  extends PartialBundleHeatTransfer;
protected
  Real[n] Nus_turb "Nusselt number for turbulent flow";
  Real[n] Nus_lam "Nusselt number for laminar flow";
  Real Nu_1;
  Real[n] Nus_2;
  Real[n] Xis;
equation
  Nu_1 = 3.66;
  for i in 1:n loop
    Nus_turb[i] = smooth(0, (Xis[i]/8)*abs(Res[i])*Prs[i]/(1 + 12.7*(Xis[i]/8)^
      0.5*(Prs[i]^(2/3) - 1))*(1 + 1/3*(diameters[i]/lengths[i]/(if vs[i] >= 0
       then (i - 0.5) else (n - i + 0.5)))^(2/3)));
    Xis[i] = (1.8*Modelica.Math.log10(max(1e-10, Res[i])) - 1.5)^(-2);
    Nus_lam[i] = (Nu_1^3 + 0.7^3 + (Nus_2[i] - 0.7)^3)^(1/3);
    Nus_2[i] = smooth(0, 1.077*(abs(Res[i])*Prs[i]*diameters[i]/lengths[i]/(if
      vs[i] >= 0 then (i - 0.5) else (n - i + 0.5)))^(1/3));
    Nus[i] = spliceFunction(
      Nus_turb[i],
      Nus_lam[i],
      Res[i] - 6150,
      3850);
  end for;
  annotation (Documentation(info="<html>
Heat transfer model for laminar and turbulent flow in pipes. Range of validity:
<ul>
<li>fully developed pipe flow</li>
<li>forced convection</li>
<li>one phase Newtonian fluid</li>
<li>(spatial) constant wall temperature in the laminar region</li>
<li>0 &le; Re &le; 1e6, 0.6 &le; Pr &le; 100, d/L &le; 1</li>
<li>The correlation holds for non-circular pipes only in the turbulent region. Use diameter=4*crossArea/perimeter as characteristic length.</li>
</ul>
The correlation takes into account the spatial position along the pipe flow, which changes discontinuously at flow reversal. However, the heat transfer coefficient itself is continuous around zero flow rate, but not its derivative.
<h4>References</h4>

<dl><dt>Verein Deutscher Ingenieure (1997):</dt>
    <dd><b>VDI W&auml;rmeatlas</b>.
         Springer Verlag, Ed. 8, 1997.</dd>
</dl>
</html>"));
end SchadModified;
