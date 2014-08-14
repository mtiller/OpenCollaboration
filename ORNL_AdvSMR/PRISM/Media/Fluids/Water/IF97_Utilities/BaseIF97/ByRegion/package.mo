within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package ByRegion "simple explicit functions for one region only"


  extends Modelica.Icons.Package;


  annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package ByRegion provides fast forward calls for dynamic property calculation records for all
          one phase regions of IAPWS/IF97
       </p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>waterR1_pT</b> computes dynamic properties for region 1 using  (p,T) as inputs</li>
          <li>Function <b>waterR2_pT</b> computes dynamic properties for region 2 using  (p,T) as inputs</li>
          <li>Function <b>waterR3_dT</b> computes dynamic properties for region 3 using  (d,T) as inputs</li>
          <li>Function <b>waterR5_pT</b> computes dynamic properties for region 5 using  (p,T) as inputs</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documented and re-organized: January 2003</li>
          </ul>
          </HTML>
          "));
end ByRegion;
