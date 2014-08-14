within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
package BaseIF97 "Modelica Physical Property Model: the new industrial formulation IAPWS-IF97"
extends Modelica.Icons.Package;

//===================================================================
//                      Constant declarations

//===================================================================

//===================================================================
//                      Base functions

//===================================================================

//work needed: (Pr,lam,eta) = f(d,T,p, region?)


annotation (Documentation(info="<HTML>
    <h4>Version Info and Revision history
        </h4>
        <ul>
        <li>First implemented: <i>July, 2000</i>
        by Hubertus Tummescheit
        for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
        </li>
      <li>Code reorganization, enhanced documentation, additional functions:   <i>December, 2002</i>
      by <a href=\"mailto:Hubertus.Tummescheit@modelon.se\">Hubertus Tummescheit</a> and moved to Modelica
      properties library.</li>
        </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
      </address>
        <P>In September 1997, the International Association for the Properties
        of Water and Steam (<A HREF=\"http://www.iapws.org\">IAPWS</A>) adopted a
        new formulation for the thermodynamic properties of water and steam for
        industrial use. This new industrial standard is called \"IAPWS Industrial
        Formulation for the Thermodynamic Properties of Water and Steam\" (IAPWS-IF97).
        The formulation IAPWS-IF97 replaces the previous industrial standard IFC-67.
        <P>Based on this new formulation, a new steam table, titled \"<a href=\"http://www.springer.de/cgi-bin/search_book.pl?isbn=3-540-64339-7\">Properties of Water and Steam</a>\" by W. Wagner and A. Kruse, was published by
        the Springer-Verlag, Berlin - New-York - Tokyo in April 1998. This
        steam table, ref. <a href=\"#steamprop\">[1]</a> is bilingual (English /
        German) and contains a complete description of the equations of
        IAPWS-IF97. This reference is the authoritative source of information
        for this implementation. A mostly identical version has been published by the International
        Association for the Properties
        of Water and Steam (<A HREF=\"http://www.iapws.org\">IAPWS</A>) with permission granted to re-publish the
        information if credit is given to IAPWS. This document is distributed with this library as
        <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>.
        In addition, the equations published by <A HREF=\"http://www.iapws.org\">IAPWS</A> for
        the transport properties dynamic viscosity (standards document: <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a>)
        and thermal conductivity (standards document: <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a>)
        and equations for the surface tension (standards document: <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a>)
        are also implemented in this library and included for reference.</p>
        <P>
        The functions in BaseIF97.mo are low level functions which should
        only be used in those exceptions when the standard user level
        functions in Water.mo do not contain the wanted properties.
     </p>
<P>Based on IAPWS-IF97, Modelica functions are available for calculating
the most common thermophysical properties (thermodynamic and transport
properties). The implementation requires part of the common medium
property infrastructure of the Modelica.Thermal.Properties library in the file
Common.mo. There are a few extensions from the version of IF97 as
documented in <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> in order to improve performance for
dynamic simulations. Input variables for calculating the properties are
only implemented for a limited number of variable pairs which make sense as dynamic states: (p,h), (p,T), (p,s) and (d,T).
</p>
<hr size=3 width=\"70%\">
<p><a name=\"regions\"><h4>1. Structure and Regions of IAPWS-IF97</h4></a>
<P>The IAPWS Industrial Formulation 1997 consists of
a set of equations for different regions which cover the following range
of validity:</p>
<table border=0 cellpadding=4>
<tr>
<td valign=\"top\">273,15 K &lt; <I>T</I> &lt; 1073,15 K</td>
<td valign=\"top\"><I>p</I> &lt; 100 MPa</td>
</tr>
<tr>
<td valign=\"top\">1073,15 K &lt; <I>T</I> &lt; 2273,15 K</td>
<td valign=\"top\"><I>p</I> &lt; 10 MPa</td>
</tr>
</table>
<p>
Figure 1 shows the 5 regions into which the entire range of validity of
IAPWS-IF97 is divided. The boundaries of the regions can be directly taken
from Fig. 1 except for the boundary between regions 2 and 3; this boundary,
which corresponds approximately to the isentropic line <nobr><I>s</I> = 5.047 kJ kg
<FONT SIZE=-1><sup>-1</sup></FONT>
K<FONT SIZE=-1><sup>-1</sup></FONT>,</nobr> is defined
by a corresponding auxiliary equation. Both regions 1 and 2 are individually
covered by a fundamental equation for the specific Gibbs free energy <nobr><I>g</I>(<I>
p</I>,<I>T </I>)</nobr>, region 3 by a fundamental equation for the specific Helmholtz
free energy <nobr><I>f </I>(<I> <FONT FACE=\"Symbol\">r</FONT></I>,<I>T
</I>)</nobr>, and the saturation curve, corresponding to region 4, by a saturation-pressure
equation <nobr><I>p</I><FONT SIZE=-1><sub>s</sub></FONT>(<I>T</I>)</nobr>. The high-temperature
region 5 is also covered by a <nobr><I>g</I>(<I> p</I>,<I>T </I>)</nobr> equation. These
5 equations, shown in rectangular boxes in Fig. 1, form the so-called <I>basic
equations</I>.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Figure 1: Regions and equations of IAPWS-IF97</caption>
  <tr>
    <td>
    <img src=\"modelica://Modelica/Resources/Images/Media/Water/if97.png\" alt=\"Regions and equations of IAPWS-IF97\">
    </td>
  </tr>
</table>

<P>In addition to these basic equations, so-called <I>backward
equations</I> are provided for regions 1, 2, and 4 in form of
<nobr><I>T </I>(<I> p</I>,<I>h </I>)</nobr> and <nobr><I>T </I>(<I>
p</I>,<I>s </I>)</nobr> for regions 1 and 2, and <nobr><I>T</I><FONT
SIZE=-1><sub>s</sub> </FONT>(<I> p </I>)</nobr> for region 4. These
backward equations, marked in grey in Fig. 1, were developed in such a
way that they are numerically very consistent with the corresponding
basic equation. Thus, properties as functions of&nbsp; <I>p</I>,<I>h
</I>and of&nbsp;<I> p</I>,<I>s </I>for regions 1 and 2, and of
<I>p</I> for region 4 can be calculated without any iteration. As a
result of this special concept for the development of the new
industrial standard IAPWS-IF97, the most important properties can be
calculated extremely quickly. All modelica functions are optimized
with regard to short computing times.
<P>The complete description of the individual equations of the new industrial
formulation IAPWS-IF97 is given in <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>. Comprehensive information on
IAPWS-IF97 (requirements, concept, accuracy, consistency along region boundaries,
and the increase of computing speed in comparison with IFC-67, etc.) can
be taken from <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> or [2].
<P><a name=\"steamprop\">[1]<I>Wagner, W., Kruse, A.</I> Properties of Water
and Steam / Zustandsgr&ouml;&szlig;en von Wasser und Wasserdampf / IAPWS-IF97.
Springer-Verlag, Berlin, 1998.
<P>[2] <I>Wagner, W., Cooper, J. R., Dittmann, A., Kijima,
J., Kretzschmar, H.-J., Kruse, A., Mare&#353; R., Oguchi, K., Sato, H., St&ouml;cker,
I., &#352;ifner, O., Takaishi, Y., Tanishita, I., Tr&uuml;benbach, J., and Willkommen,
Th.</I> The IAPWS Industrial Formulation 1997 for the Thermodynamic Properties
of Water and Steam. ASME Journal of Engineering for Gas Turbines and Power 122 (2000), 150 - 182.
<p>
<HR size=3 width=\"90%\">
<h4>2. Calculable Properties      </h4>
<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\">
       <tbody>
       <tr>
       <td valign=\"top\" bgcolor=\"#cccccc\"><br>
      </td>
      <td valign=\"top\" bgcolor=\"#cccccc\"><b>Common name</b><br>
       </td>
       <td valign=\"top\" bgcolor=\"#cccccc\"><b>Abbreviation </b><br>
       </td>
       <td valign=\"top\" bgcolor=\"#cccccc\"><b>Unit</b><br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;1<br>
      </td>
      <td valign=\"top\">Pressure</td>
       <td valign=\"top\">p<br>
        </td>
       <td valign=\"top\">Pa<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;2<br>
      </td>
      <td valign=\"top\">Temperature</td>
       <td valign=\"top\">T<br>
       </td>
       <td valign=\"top\">K<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;3<br>
      </td>
      <td valign=\"top\">Density</td>
        <td valign=\"top\">d<br>
        </td>
       <td valign=\"top\">kg/m<sup>3</sup><br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;4<br>
      </td>
      <td valign=\"top\">Specific volume</td>
        <td valign=\"top\">v<br>
        </td>
       <td valign=\"top\">m<sup>3</sup>/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;5<br>
      </td>
      <td valign=\"top\">Specific enthalpy</td>
       <td valign=\"top\">h<br>
       </td>
       <td valign=\"top\">J/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;6<br>
      </td>
      <td valign=\"top\">Specific entropy</td>
       <td valign=\"top\">s<br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;7<br>
      </td>
      <td valign=\"top\">Specific internal energy<br>
       </td>
       <td valign=\"top\">u<br>
       </td>
       <td valign=\"top\">J/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;8<br>
      </td>
      <td valign=\"top\">Specific isobaric heat capacity</td>
       <td valign=\"top\">c<font size=\"-1\"><sub>p</sub></font><br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;9<br>
      </td>
      <td valign=\"top\">Specific isochoric heat capacity</td>
       <td valign=\"top\">c<font size=\"-1\"><sub>v</sub></font><br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">10<br>
      </td>
      <td valign=\"top\">Isentropic exponent, kappa<nobr>=       <font face=\"Symbol\">-</font>(v/p)
(dp/dv)<font size=\"-1\"><sub>s</sub> </font></nobr></td>
     <td valign=\"top\">kappa (     <font face=\"Symbol\">k</font>)<br>
     </td>
     <td valign=\"top\">1<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">11<br>
      </td>
      <td valign=\"top\">Speed of sound<br>
     </td>
     <td valign=\"top\">a<br>
     </td>
     <td valign=\"top\">m/s<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">12<br>
      </td>
      <td valign=\"top\">Dryness fraction<br>
     </td>
     <td valign=\"top\">x<br>
     </td>
     <td valign=\"top\">kg/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">13<br>
      </td>
      <td valign=\"top\">Specific Helmholtz free energy,     f = u - Ts</td>
     <td valign=\"top\">f<br>
     </td>
     <td valign=\"top\">J/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">14<br>
      </td>
      <td valign=\"top\">Specific Gibbs free energy,     g = h - Ts</td>
     <td valign=\"top\">g<br>
     </td>
     <td valign=\"top\">J/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">15<br>
      </td>
      <td valign=\"top\">Isenthalpic exponent, <nobr> theta     = -(v/p)(dp/dv)<font
 size=\"-1\"><sub>h</sub></font></nobr></td>
     <td valign=\"top\">theta (<font face=\"Symbol\">q</font>)<br>
     </td>
     <td valign=\"top\">1<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">16<br>
      </td>
      <td valign=\"top\">Isobaric volume expansion coefficient,     alpha = v<font
 size=\"-1\"><sup>-1</sup></font>       (dv/dT)<font size=\"-1\"><sub>p</sub>
    </font></td>
     <td valign=\"top\">alpha  (<font face=\"Symbol\">a</font>)<br>
     </td>
       <td valign=\"top\">1/K<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">17<br>
      </td>
      <td valign=\"top\">Isochoric pressure coefficient,     <nobr>beta = p<font
 size=\"-1\"><sup><font face=\"Symbol\">-</font>1</sup>     </font>(dp/dT)<font
 size=\"-1\"><sub>v</sub></font></nobr>     </td>
     <td valign=\"top\">beta (<font face=\"Symbol\">b</font>)<br>
     </td>
     <td valign=\"top\">1/K<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">18<br>
      </td>
      <td valign=\"top\">Isothermal compressibility,     g<nobr>amma  = <font
 face=\"Symbol\">-</font>v        <sup><font size=\"-1\"><font face=\"Symbol\">-</font>1</font></sup>(dv/dp)<font
 size=\"-1\"><sub>T</sub></font></nobr> </td>
        <td valign=\"top\">gamma (<font face=\"Symbol\">g</font>)<br>
     </td>
     <td valign=\"top\">1/Pa<br>
     </td>
     </tr>
     <!-- <tr><td valign=\"top\">f</td><td valign=\"top\">Fugacity</td></tr> --> <tr>
     <td valign=\"top\">19<br>
      </td>
      <td valign=\"top\">Dynamic viscosity</td>
     <td valign=\"top\">eta (<font face=\"Symbol\">h</font>)<br>
     </td>
     <td valign=\"top\">Pa s<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">20<br>
      </td>
      <td valign=\"top\">Kinematic viscosity</td>
     <td valign=\"top\">nu (<font face=\"Symbol\">n</font>)<br>
     </td>
     <td valign=\"top\">m<sup>2</sup>/s<br>
     </td>
     </tr>
     <!-- <tr><td valign=\"top\">Pr</td><td valign=\"top\">Prandtl number</td></tr> --> <tr>
     <td valign=\"top\">21<br>
      </td>
      <td valign=\"top\">Thermal conductivity</td>
     <td valign=\"top\">lambda (<font face=\"Symbol\">l</font>)<br>
     </td>
     <td valign=\"top\">W/(m K)<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">22 <br>
      </td>
      <td valign=\"top\">Surface tension</td>
     <td valign=\"top\">sigma (<font face=\"Symbol\">s</font>)<br>
     </td>
     <td valign=\"top\">N/m<br>
     </td>
     </tr>
  </tbody>
</table>
        <p>The properties 1-11 are calculated by default with the functions for dynamic
        simulation, 2 of these variables are the dynamic states and are the inputs
        to calculate all other properties. In addition to these properties
        of general interest, the entries to the thermodynamic Jacobian matrix which render
        the mass- and energy balances explicit in the input variables to the property calculation are also calculated.
        For an explanatory example using pressure and specific enthalpy as states, see the Examples sub-package.</p>
        <p>The high-level calls to steam properties are grouped into records comprising both the properties of general interest
        and the entries to the thermodynamic Jacobian. If additional properties are
        needed the low level functions in BaseIF97 provide more choice.</p>
        <HR size=3 width=\"90%\">
        <h4>Additional functions</h4>
        <ul>
        <li>Function <b>boundaryvals_p</b> computes the temperature and the specific enthalpy and
        entropy on both phase boundaries as a function of p</li>
        <li>Function <b>boundaryderivs_p</b> is the Modelica derivative function of <b>boundaryvals_p</b></li>
        <li>Function <b>extraDerivs_ph</b> computes all entries to Bridgmans tables for all
        one-phase regions of IF97 using inputs (p,h). All 336 directional derivatives of the
        thermodynamic surface can be computed as a ratio of two entries in the return data, see package Common
        for details.</li>
        <li>Function <b>extraDerivs_pT</b> computes all entries to Bridgmans tables for all
        one-phase regions of IF97 using inputs (p,T).</li>
        </ul>
     </p>
        </HTML>"));
end BaseIF97;
