within ORNL_AdvSMR.BaseClasses.HeatTransfer;
model KazimiCarelli
  "Kazimi-Carelli correlation for liquid metal coolants in flow bundles (1.1 <= P/D <= 1.4 and 10 <= Pe <= 5000)"
  extends PartialBundleHeatTransfer;
protected
  Real[n] Nu_turb "Nusselt number for turbulent flow";

equation
  for i in 1:n loop

    Nu_turb[i] = 4.0 + 0.33*(P/D)^3.8*(Pe[i]/100)^0.86 + 0.16*(P/D)^5.0;

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
end KazimiCarelli;
