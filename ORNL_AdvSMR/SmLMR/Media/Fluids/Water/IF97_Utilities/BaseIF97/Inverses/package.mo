within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package Inverses "efficient inverses for selected pairs of variables"


  extends Modelica.Icons.Package;

  //===================================================================
  //            Iterative version for some pairs/regions

  //===================================================================

  // for all iteration functions: project to bounadries possible
  // if p is input. Step 1 get dofpt_efficient(p,T) at boundary
  // for T, use boundary itself if off limits, for d a bit inside


  annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p></p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>fixdT</b> constrains density and temperature to allowed region</li>
          <li>Function <b>dofp13</b> computes d as a function of p at boundary between regions 1 and 3</li>
          <li>Function <b>dofp23</b> computes d as a function of p at boundary between regions 2 and 3</li>
          <li>Function <b>dofpt3</b> iteration to compute d as a function of p and T in region 3</li>
          <li>Function <b>dtofph3</b> iteration to compute d and T as a function of p and h in region 3</li>
          <li>Function <b>dtofps3</b> iteration to compute d and T as a function of p and s in region 3</li>
          <li>Function <b>dtofpsdt3</b> iteration to compute d and T as a function of p and s in region 3,
          with initial guesses</li>
          <li>Function <b>pofdt125</b> iteration to compute p as a function of p and T in regions 1, 2 and 5</li>
          <li>Function <b>tofph5</b> iteration to compute T as a function of p and h in region 5</li>
          <li>Function <b>tofps5</b> iteration to compute T as a function of p and s in region 5</li>
          <li>Function <b>tofpst5</b> iteration to compute T as a function of p and s in region 5, with initial guess in T</li>
          <li>Function <b></b></li>
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
          <li>Documentation added: December 2002</li>
          </ul>
          </HTML>
          "));
end Inverses;
