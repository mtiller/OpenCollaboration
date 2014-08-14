within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97;
package Transport "transport properties for water according to IAPWS/IF97"


  extends Modelica.Icons.Package;


  annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p></p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>visc_dTp</b> implements a function to compute the industrial formulation of the
          dynamic viscosity of water as a function of density and temperature.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a>.</li>
          <li>Function <b>cond_dTp</b> implements a function to compute  the industrial formulation of the thermal conductivity of water as
          a function of density, temperature and pressure. <b>Important note</b>: Obviously only two of the three
          inputs are really needed, but using three inputs speeds up the computation and the three variables are known in most models anyways.
          The inputs d,T and p have to be consistent.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a>.</li>
          <li>Function <b>surfaceTension</b> implements a function to compute the surface tension between vapour
          and liquid water as a function of temperature.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a>.</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>October, 2002</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Authors: Hubertus Tummescheit and Jonas Eborn<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: October 2002</li>
          </ul>
          </HTML>
          "));
end Transport;
