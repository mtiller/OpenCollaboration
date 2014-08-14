within ORNL_AdvSMR.SmAHTR.PowerConversionSystem.SteamTurbines;
model SteamTurbineStodola "Steam turbine"
  extends SmAHTR.PowerConversionSystem.SteamTurbines.SteamTurbineBase;
  parameter Real eta_iso_nom=0.92 "Nominal isentropic efficiency";
  parameter Modelica.SIunits.Area Kt "Kt coefficient of Stodola's law";
  parameter Real partialArc_nom=1 "Nominal partial arc";
equation
  w = homotopy(Kt*partialArc*sqrt(Medium.pressure(steamState_in)*
    Medium.density(steamState_in))*ThermoPower3.Functions.sqrtReg(1 - (
    1/PR)^2), partialArc/partialArc_nom*wnom/pnom*Medium.pressure(
    steamState_in)) "Stodola's law";
  eta_iso = eta_iso_nom "Constant efficiency";
  annotation (Documentation(info="<html>
<p>This model extends <tt>SteamTurbineBase</tt> by adding the actual performance characteristics:
<ul>
<li>Stodola's law
<li>Constant isentropic efficiency
</ul></p>
<p>The inlet flowrate is also proportional to the <tt>partialArc</tt> signal if the corresponding connector is wired. In this case, it is assumed that the flow rate is reduced by partial arc admission, not by throttling (i.e., no loss of thermodynamic efficiency occurs). To simulate throttling, insert a valve model before the turbine inlet.
</html>",
  revisions="<html>
<ul>
<li><i>20 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end SteamTurbineStodola;
