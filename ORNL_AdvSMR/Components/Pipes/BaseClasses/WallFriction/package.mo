within ORNL_AdvSMR.Components.Pipes.BaseClasses;
package WallFriction "Different variants for pressure drops due to pipe wall friction"
extends Modelica.Icons.Package;


annotation (Documentation(info="<html>
<p>
This package provides functions to compute
pressure losses due to <b>wall friction</b> in a pipe.
Every correlation is defined by a package that is derived
by inheritance from the package WallFriction.PartialWallFriction.
The details of the underlying pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2
</pre>

<p>
are used, where the friction loss factor &lambda; is shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

</html>"));
end WallFriction;
