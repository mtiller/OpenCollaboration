within ORNL_AdvSMR.Components;
model Flow1DDB
  "1-dimensional fluid flow model for water or steam flow (finite volumes, Dittus-Boelter heat transfer)"
  extends ThermoPower3.Water.Flow1D(redeclare ThermoPower3.Thermal.DHThtc wall);
  Medium.DynamicViscosity mu[N] "Dynamic viscosity";
  Medium.ThermalConductivity k[N] "Thermal conductivity";
  Medium.SpecificHeatCapacity cp[N] "Heat capacity at constant pressure";
equation
  for j in 1:N loop
    // Additional fluid properties
    mu[j] = Medium.dynamicViscosity(fluidState[j]);
    k[j] = Medium.thermalConductivity(fluidState[j]);
    cp[j] = Medium.heatCapacity_cp(fluidState[j]);
    wall.gamma[j] = ThermoPower3.Water.f_dittus_boelter(
      w,
      Dhyd,
      A,
      mu[j],
      k[j],
      cp[j]) "Heat transfer on the wall connector";
  end for;
  annotation (Documentation(info="<HTML>
<p>This model extends <tt>Flow1D</tt> by computing the distribution of the heat transfer coefficient <tt>gamma</tt> and making it available through an extended version of the <tt>wall</tt> connector.
<p>This model can be used in the case of one-phase water or steam flow. Dittus-Boelter's equation [1] is used to compute the heat transfer coefficient.
<p><b>References:</b></p>
<ol>
<li>J. C. Collier: <i>Convective Boiling and Condensation</i>, 2nd ed.,McGraw Hill, 1981, pp. 146.
</ol>
</HTML>", revisions="<html>
<ul>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>26 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to <tt>Modelica.Media</tt>.</li>
<li><i>20 Dec 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Function call to <tt>f_dittus_boelter</tt> updated.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end Flow1DDB;
