within ORNL_AdvSMR;
package Thermal "Thermal models of heat transfer"
extends Modelica.Icons.Library;


annotation (Documentation(info="<HTML>
This package contains models of physical processes and components related to heat transfer phenomena.
<p>All models with dynamic equations provide initialisation support. Set the <tt>initOpt</tt> parameter to the appropriate value:
<ul>
<li><tt>Choices.Init.Options.noInit</tt>: no initialisation
<li><tt>Choices.Init.Options.steadyState</tt>: full steady-state initialisation
</ul>
The latter options can be useful when two or more components are connected directly so that they will have the same pressure or temperature, to avoid over-specified systems of initial equations.

</HTML>"));
end Thermal;
