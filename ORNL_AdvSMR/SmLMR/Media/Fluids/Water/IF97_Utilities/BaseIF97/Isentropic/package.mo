within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package Isentropic "functions for calculating the isentropic enthalpy from pressure p and specific entropy s"


  extends Modelica.Icons.Package;

  // for isentropic specific enthalpy get T(p,s), then use this

  // region 3 extra functions

  // for isentropic specific enthalpy get (d,T) = f(p,s), then use this
  // which needs a bloody iteration, ...
  // this is one thing that needs to be done somehow, ...


  annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p></p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>hofpT1</b> computes h(p,T) in region 1.</li>
          <li>Function <b>handsofpT1</b> computes (s,h)=f(p,T) in region 1, needed for two-phase properties.</li>
          <li>Function <b>hofps1</b> computes h(p,s) in region 1.</li>
          <li>Function <b>hofpT2</b> computes h(p,T) in region 2.</li>
          <li>Function <b>handsofpT2</b> computes (s,h)=f(p,T) in region 2, needed for two-phase properties.</li>
          <li>Function <b>hofps2</b> computes h(p,s) in region 2.</li>
          <li>Function <b>hofdT3</b> computes h(d,T) in region 3.</li>
          <li>Function <b>hofpsdt3</b> computes h(p,s,dguess,Tguess) in region 3, where dguess and Tguess are initial guess
          values for the density and temperature consistent with p and s.</li>
          <li>Function <b>hofps4</b> computes h(p,s) in region 4.</li>
          <li>Function <b>hofpT5</b> computes h(p,T) in region 5.</li>
          <li>Function <b>water_hisentropic</b> computes h(p,s,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary.</li>
          <li>Function <b>water_hisentropic_dyn</b> computes h(p,s,dguess,Tguess,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary. Tguess and dguess are initial guess
          values for the density and temperature consistent with p and s. This function should be preferred in
          dynamic simulations where good guesses are often available.</li>
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
end Isentropic;
