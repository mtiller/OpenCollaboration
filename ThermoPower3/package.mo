within ;
package ThermoPower3 "Open library for thermal power plant simulation"
import Modelica.Math.*;
import Modelica.SIunits.*;


annotation (
  Documentation(info="<HTML>
<p><h2>General Information</h2></p>
<p>The ThermoFluid library is an open Modelica library for the dynamic modeling of thermal power plants.
<p>A general description of the library can be found in the papers:
<ul><li>F. Casella, A. Leva, <a href=\"http://www.modelica.org/Conference2003/papers/h08_Leva.pdf\">\"Modelica open library for power plant simulation: design and experimental validation\"</a>, <i>Proceedings of the 2003 Modelica Conference</i>, Link&ouml ping, Sweden, 2003.</li>
<li>F. Casella, A. Leva, <a href=\"http://dx.doi.org/10.1080/13873950500071082\">\"Modelling of Thermo-Hydraulic Power Generation Processes Using Modelica\"</a>. Mathematical and Computer Modeling of Dynamical Systems, vol. 12, n. 1, pp. 19-33, Feb. 2006.</li>
 
</ul>
<p>The papers are available from the <a href=\"mailto:francesco.casella@polimi.it\">authors</a> upon request, or can be downloaded from the <a href=\"http://www.elet.polimi.it/upload/casella/ThermoPower3/\">library home page</a>.
<p>The ThermoPower3 library uses the medium models provided by the Modelica.Media library, which is freely available from the <a href= \"http://www.modelica.org/\">Modelica Association</a> web site.
 
<p><h2>Library home page</h2></p>
<p>For additional information and library updates, consult the <a href=\"http://home.dei.polimi.it/casella/ThermoPower3/\"> 
library home page</a>, and the <a href=\"http://sourceforge.net/projects/ThermoPower3/\"> ThermoPower3 project page </a> on SourceForge.net.
<p>Contributions to the library are welcome: please contact the authors if you are interested.
 
<p><h2>Release notes:</h2></p>
<h3>Version 2.1 (<i>6 Jul 2009</i>)</h3>
The 2.1 release of ThermoPower3 contains several additions and a few bug
fixes with respect to version 2.0. We tried to keep the new version
backwards-compatible with the old one, but there might be a few cases
where small adaptations could be required.<br>
<br>
ThermoPower3 2.1 requires the Modelica Standard Library version 2.2.1 or
2.2.2. It has been tested with Dymola 6.1 (using MSL 2.2.1) and with
Dymola 7.1 (using MSL 2.2.2). It is planned to be usable also with
other tools, in particular OpenModelica, MathModelica and SimulationX,
but this is not possible with the currently released versions of those
tools. It is expected that this should become at least partially
possible within the year 2009. <br>
<br>
ThermoPower3 2.1 is the last major revision compatible with Modelica
2.1 and the Modelica Standard Library 2.2.x. The next version is planned to use Modelica 3.1 and the Modelica Standard Library 3.1. It will use
use stream connectors, which generalize the concept of Flange
connectors, lifting the restrictions that only two complementary
connectors can be bound.<br>
<br>
This is a list of the main changes with respect to v. 2.0<br>
<ul>
  <li>New PowerPlants package, containing a library of high-level
reusable components for the modelling of combined-cycle power plants,
including full models that can be simulated.</li>
  <li>New examples cases in the Examples package.</li>
  <li>New components in the Electrical package, to model the generator-grid connection by the swing equation</li>
  <li>Three-way junctions (FlowJoin and FlowSplit) now have an option
to describe unidirectional flow at each flange. This feature can
substantially enhance numerical robustness and simulation performance
in all cases when it is known a priori that no flow reversal will occur.</li>
  <li>The Flow1D and Flow1D2ph models are now restricted to positive
flow direction, since it was found that it is not possible to describe
flow reversal consistently with the average-density approach adopted in
this library. For full flow reversal support please use the Flow1Dfem
model, which does not have any restriction in this respect.</li>
  <li>A bug in Flow1D and Flow1D2ph has been corrected, which caused
significant errors in the mass balance under dynamic conditions; this
was potentially critical in closed-loop models, but has now been
resolved.&nbsp;</li>
  <li>The connectors for lumped- and distribute-parameters heat
transfer with variable heat transfer coefficients have been split:
HThtc and DHThtc now have an output qualifier on the h.t.c., while
HThtc_in and DHThtc_in have an input qualifier. This was necessary to
avoid incorrect connections, and is also required by tools to correctly
checked if a model is balanced. This change should have no impact on
most user-developed models.</li>
</ul> 
<h3>Version 2.0 (<i>10 Jun 2005</i>)</h3>
<ul>
    <li>The new Modelica 2.2 standard library is used.
    <li>The ThermoPower3 library is now based on the Modelica.Media standard library for fluid property calculations. All the component models use a Modelica.Media compliant interface to specify the medium model. Standard water and gas models from the Modelica.Media library can be used, as well as custom-built water and gas models, compliant with the Modelica.Media interfaces.
    <li>Fully functional gas components are now available, including model for gas compressors and turbines, as well as compact gas turbine unit models.
    <li>Steady-state initialisation support has been added to all dynamic models.
<li>Some components are still under development, and could be changed in the final 2.0 release:
<ul>
<li>Moving boundary model for two-phase flow in once-through evaporators.
<li>Stress models for headers and turbines.
</ul>
</ul>
<h3>Version 1.2 (<i>18 Nov 2004</i>)</h3>
<ul>
    <li>Valve and pump models restructured using inheritance.
    <li>Simple model of a steam turbine unit added (requires the  Modelica.Media library).
    <li>CISE example restructured and moved to the <tt>Examples</tt> package.
    <li>Preliminary version of gas components added in the <tt>Gas</tt> package.
    <li>Finite element model of thermohydraulic two-phase flow added.
    <li>Simplified models for the connection to the power system added in the <tt>Electrical</tt> package.
</ul>
 
<h3>Version 1.1 (<i>15 Feb 2004</i>)</h3>
<ul>
    <li>No default values for parameters whose values must be set explicitly by the user.
    <li>Description of the meaning of the model variables added.
    <li><tt>Pump</tt>, <tt>PumpMech</tt>, <tt>Accumulator</tt> models added.
    <li>More rational geometric parameters for <tt>Flow1D*</tt> models.
    <li><tt>Flow1D</tt> model corrected to avoid numerical problems when the phase transition boundaries cross the nodes.
    <li><tt>Flow1D2phDB</tt> model updated.
    <li><tt>Flow1D2phChen</tt> models with two-phase heat transfer added.
</ul>
<h3>Version 1.0 (<i>20 Oct 2003</i>)</h3>
<ul>
    <li>First release in the public domain</li>
</ul>
<h2>License agreement</h2></p>
<p>The ThermoPower3 package is licensed by Politecnico di Milano under the  <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"><b>Modelica License 2</b></a>.</p> 
<p><b>Copyright &copy; 2002-2009, Politecnico di Milano.</b></p>
</HTML>"),
  uses(Modelica(version="3.2.1")),
  version="3.1");
end ThermoPower3;
