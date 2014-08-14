within ORNL_AdvSMR.Components;
model PumpNPSH
  extends Pump(redeclare replaceable package Medium =
        Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialTwoPhaseMedium);
  Modelica.SIunits.Height NPSHa "Net Positive Suction Head available";
  Medium.AbsolutePressure pv "Saturated liquid pressure";
equation
  pv = Medium.saturationPressure(Tin);
  NPSHa = (infl.p - pv)/(rho*g);
  annotation (Documentation(info="<html>Same as Pump. Additionally, the net positive suction head available is computed. Requires a two-phase medium model to compute the saturation properties.
</html>", revisions="<html>
<ul>
<li><i>30 Jul 2007</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added (removed NPSH from Pump model).</li>
</ul>
</html>"));
end PumpNPSH;
