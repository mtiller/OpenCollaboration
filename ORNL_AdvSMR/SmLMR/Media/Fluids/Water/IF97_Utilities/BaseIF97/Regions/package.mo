within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package Regions "functions to find the current region for given pairs of input variables"


  extends Modelica.Icons.Package;

  //===================================================================
  //                      "Public" functions

  //===================================================================


  annotation (Documentation(info="<HTML><h4>Package description</h4>
 <p>Package <b>Regions</b> contains a large number of auxiliary functions which are neede to compute the current region
 of the IAPWS/IF97 for a given pair of input variables as quickly as possible. The focus of this implementation was on
 computational efficiency, not on compact code. Many of the function values calulated in these functions could be obtained
 using the fundamental functions of IAPWS/IF97, but with considerable overhead. If the region of IAPWS/IF97 is known in advance,
 the input variable mode can be set to the region, then the somewhat costly region checks are omitted.
 The checking for the phase has to be done outside the region functions because many properties are not
 differentiable at the region boundary. If the input phase is 2, the output region will be set to 4 immediately.</p>
 <h4>Package contents</h4>
 <p> The main 4 functions in this package are the functions returning the appropriate region for two input variables.
 <ul>
 <li>Function <b>region_ph</b> compute the region of IAPWS/IF97 for input pair pressure and specific enthalpy.</li>
 <li>Function <b>region_ps</b> compute the region of IAPWS/IF97 for input pair pressure and specific entropy</li>
 <li>Function <b>region_dT</b> compute the region of IAPWS/IF97 for input pair density and temperature.</li>
 <li>Function <b>region_pT</b> compute the region of IAPWS/IF97 for input pair pressure and temperature (only ine phase region).</li>
 </ul>
 <p>In addition, functions of the boiling and condensation curves compute the specific enthalpy, specific entropy, or density on these
 curves. The functions for the saturation pressure and temperature are included in the package <b>Basic</b> because they are part of
 the original <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IAPWS/IF97 standards document</a>. These functions are also aliased to
 be used directly from package <b>Water</b>.
</p>
 <ul>
 <li>Function <b>hl_p</b> computes the liquid specific enthalpy as a function of pressure. For overcritical pressures,
 the critical specific enthalpy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>hv_p</b> computes the vapour specific enthalpy as a function of pressure. For overcritical pressures,
 the critical specific enthalpy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>sl_p</b> computes the liquid specific entropy as a function of pressure. For overcritical pressures,
 the critical  specific entropy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>sv_p</b> computes the vapour  specific entropy as a function of pressure. For overcritical pressures,
 the critical  specific entropyis returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>rhol_T</b> computes the liquid density as a function of temperature. For overcritical temperatures,
 the critical density is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>rhol_T</b> computes the vapour density as a function of temperature. For overcritical temperatures,
 the critical density is returned. An approximation is used for temperatures > 623.15 K.</li>
 </ul>
</p>
 <p>All other functions are auxiliary functions called from the region functions to check a specific boundary.</p>
 <ul>
 <li>Function <b>boundary23ofT</b> computes the boundary pressure between regions 2 and 3 (input temperature)</li>
 <li>Function <b>boundary23ofp</b> computes the boundary temperature between regions 2 and 3 (input pressure)</li>
 <li>Function <b>hlowerofp5</b> computes the lower specific enthalpy limit of region 5 (input p, T=1073.15 K)</li>
 <li>Function <b>hupperofp5</b> computes the upper specific enthalpy limit of region 5 (input p, T=2273.15 K)</li>
 <li>Function <b>slowerofp5</b> computes the lower specific entropy limit of region 5 (input p, T=1073.15 K)</li>
 <li>Function <b>supperofp5</b> computes the upper specific entropy limit of region 5 (input p, T=2273.15 K)</li>
 <li>Function <b>hlowerofp1</b> computes the lower specific enthalpy limit of region 1 (input p, T=273.15 K)</li>
 <li>Function <b>hupperofp1</b> computes the upper specific enthalpy limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>slowerofp1</b> computes the lower specific entropy limit of region 1 (input p, T=273.15 K)</li>
 <li>Function <b>supperofp1</b> computes the upper specific entropy limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>hlowerofp2</b> computes the lower specific enthalpy limit of region 2 (input p, T=623.15 K)</li>
 <li>Function <b>hupperofp2</b> computes the upper specific enthalpy limit of region 2 (input p, T=1073.15 K)</li>
 <li>Function <b>slowerofp2</b> computes the lower specific entropy limit of region 2 (input p, T=623.15 K)</li>
 <li>Function <b>supperofp2</b> computes the upper specific entropy limit of region 2 (input p, T=1073.15 K)</li>
 <li>Function <b>d1n</b> computes the density in region 1 as function of pressure and temperature</li>
 <li>Function <b>d2n</b> computes the density in region 2 as function of pressure and temperature</li>
 <li>Function <b>dhot1ofp</b> computes the hot density limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>dupper1ofT</b>computes the high pressure density limit of region 1 (input T, p=100MPa)</li>
 <li>Function <b>hl_p_R4b</b> computes a high accuracy approximation to the liquid enthalpy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>hv_p_R4b</b> computes a high accuracy approximation to the vapour enthalpy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>sl_p_R4b</b> computes a high accuracy approximation to the liquid entropy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>sv_p_R4b</b> computes a high accuracy approximation to the vapour entropy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>rhol_p_R4b</b> computes a high accuracy approximation to the liquid density for temperatures > 623.15 K (input p)</li>
 <li>Function <b>rhov_p_R4b</b> computes a high accuracy approximation to the vapour density for temperatures > 623.15 K (input p)</li>
 </ul>
</p>
<h4>Version Info and Revision history
</h4>
 <ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
<address>Authors: Hubertus Tummescheit, Jonas Eborn and Falko Jens Wagner<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
 <ul>
 <li>Initial version: July 2000</li>
 <li>Revised and extended for inclusion in Modelica.Thermal: December 2002</li>
</ul>
</HTML>
"));
end Regions;
