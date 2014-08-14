within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package TwoPhase "steam properties in the two-phase rgion and on the phase boundaries"


  extends Modelica.Icons.Package;


  annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package TwoPhase provides functions to compute the steam properties
          in the two-phase region and on the phase boundaries</p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>WaterLiq_p</b> computes properties on the boiling boundary as a function of p</li>
          <li>Function <b>WaterVap_p</b> computes properties on the dew line boundary as a function of p</li>
          <li>Function <b>WaterSat_ph</b> computes properties on both phase boundaries and in the two
          phase region as a function of p</li>
          <li>Function <b>WaterR4_ph</b> computes dynamic simulation properties in region 4 with (p,h) as inputs</li>
          <li>Function <b>WaterR4_dT</b> computes dynamic simulation properties in region 4 with (d,T) as inputs</li>
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
end TwoPhase;
