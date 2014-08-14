within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package Basic "Base functions as described in IAWPS/IF97"


  extends Modelica.Icons.Package;

  // Inverses p_hs from the 2001 assition to IAPWS97

  // Inverses from the 2003 additions to IF97


  annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package BaseIF97/Basic computes the the fundamental functions for the 5 regions of the steam tables
          as described in the standards document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>. The code of these
          functions has been generated using <b><i>Mathematica</i></b> and the add-on packages \"Format\" and \"Optimize\"
          to generate highly efficient, expression-optimized C-code from a symbolic representation of the thermodynamic
          functions. The C-code has than been transformed into Modelica code. An important feature of this optimization was to
          simultaneously optimize the functions and the directional derivatives because they share many common subexpressions.</p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>g1</b> computes the dimensionless Gibbs function for region 1 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>g2</b> computes the dimensionless Gibbs function  for region 2 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>g2metastable</b> computes the dimensionless Gibbs function for metastable vapour
          (adjacent to region 2 but 2-phase at equilibrium) and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>f3</b> computes the dimensionless Helmholtz function  for region 3 and all derivatives up
          to order 2 w.r.t. delta and tau. Inputs: d and T.</li>
          <li>Function <b>g5</b>computes the dimensionless Gibbs function for region 5 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>tph1</b> computes the inverse function T(p,h) in region 1.</li>
          <li>Function <b>tph2</b> computes the inverse function T(p,h) in region 2.</li>
          <li>Function <b>tps2a</b> computes the inverse function T(p,s) in region 2a.</li>
          <li>Function <b>tps2b</b> computes the inverse function T(p,s) in region 2b.</li>
          <li>Function <b>tps2c</b> computes the inverse function T(p,s) in region 2c.</li>
          <li>Function <b>tps2</b> computes the inverse function T(p,s) in region 2.</li>
          <li>Function <b>tsat</b> computes the saturation temperature as a function of pressure.</li>
          <li>Function <b>dtsatofp</b> computes the derivative of the saturation temperature w.r.t. pressure as
          a function of pressure.</li>
          <li>Function <b>tsat_der</b> computes the Modelica derivative function of tsat.</li>
          <li>Function <b>psat</b> computes the saturation pressure as a function of temperature.</li>
          <li>Function <b>dptofT</b>  computes the derivative of the saturation pressure w.r.t. temperature as
          a function of temperature.</li>
          <li>Function <b>psat_der</b> computes the Modelica derivative function of psat.</li>
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
          "),
Documentation(info="<html>
       <p>
       &nbsp;Equation from:<br>
       <div style=\"text-align: center;\">&nbsp;[1] The international Association
       for the Properties of Water and Steam<br>
       &nbsp;Vejle, Denmark<br>
       &nbsp;August 2003<br>
       &nbsp;Supplementary Release on Backward Equations for the Fucnctions
       T(p,h), v(p,h) and T(p,s), <br>
       &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
       the Thermodynamic Properties of<br>
       &nbsp;Water and Steam</div>
    </p>
       </html>"));
end Basic;
