within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids;
package PolyBased_p "EoS for a liquid, density independent of T, properties defined by polynomials"
extends ORNL_AdvSMR.Media.EquationsOfState.Interfaces.Liquids(final
    analyticInverseTfromh=(not data.npol_Cp > 2), final CompressibilityType=
      Compressibility.PressureDependent);
import Modelon.Media.Interfaces.State.Units;
import Poly = Modelon.Math.Polynomials;
import Modelon.Media.Interfaces.Types.Compressibility;
constant Modelon.Media.DataDefinitions.PolyBased.PolyBasedFluid data
  "data record";
constant Modelon.Media.Interfaces.Types.ValidityLimits limits(
  TMIN=200.0,
  TMAX=400.0,
  PMIN=0.001,
  PMAX=100.0e6,
  DMIN=1e-6,
  DMAX=1500.0)
  "Validity limits: several are arbitrarily chosen to provide good iteration bounds";
constant Boolean densityOfT=size(data.polyDensity, 1) > 1
  "true if density is a function of temperature";
constant Units.Temperature T0=298.15 "reference Temperature";
constant Modelica.SIunits.SpecificVolume v0=1/data.reference_d;
constant Units.MolarMass MM_const=0.1 "Molar mass";


redeclare function extends h_pTX
  algorithm
  h := h_T(T);
  annotation (derivative(noDerivative=X) = h_pT_der);
  end h_pTX;


redeclare function extends T_phX
  algorithm
  T := T_h(h);
  end T_phX;


redeclare function extends d_pTX
  algorithm
  d := max(1.0/v_pTX(
      p,
      T,
      X), limits.DMIN);
  end d_pTX;


redeclare function extends v_pTX
  algorithm
  v := (data.reference_p - p)*data.kappa_const*v0 + v0;
  annotation (derivative(noDerivative=X) = v_pT_der);
  end v_pTX;


redeclare function extends cp_pTX
  algorithm
  cp := cp_T(T);
  end cp_pTX;


redeclare function extends beta_pTX "1/v*(dv/dT)"
  algorithm
  beta := -Poly.derivativeValue(data.polyDensity, T)/(v_pTX(
      p,
      T,
      X)*max(Poly.evaluate(data.polyDensity, T), limits.DMIN)*max(Poly.evaluate(
    data.polyDensity, T), limits.DMIN));
  end beta_pTX;


redeclare function extends kappa_pTX "-1/v*(dv/dp)"
  algorithm
  kappa := data.kappa_const*v0/v_pTX(
      p,
      T,
      X);
  end kappa_pTX;


redeclare function extends s_pTX
  algorithm
  s := data.reference_s + Poly.integralValue(
      data.polyHeatCapacity[1:data.npol_Cp],
      T,
      T0) + Modelica.Math.log(T/T0)*data.polyHeatCapacity[data.npol_Cp + 1];
  end s_pTX;


redeclare function extends dddp_pTX
  algorithm
  dddp := data.kappa_const*v0/(v_pTX(
      p,
      T,
      X)*v_pTX(
      p,
      T,
      X));
  end dddp_pTX;


redeclare function extends dddT_pTX
  algorithm
  dddT := 0;
  end dddT_pTX;


redeclare function extends dddX_pTX
  algorithm
  dddX := fill(0.0, size(X, 1));
  end dddX_pTX;


redeclare function extends dudp_pTX
  algorithm
  dudp := ((2*p - data.reference_p)*data.kappa_const - 1)*v0;
  end dudp_pTX;


redeclare function extends dudT_pTX
  algorithm
  dudT := cp_pTX(
      p,
      T,
      X);
  end dudT_pTX;


redeclare function extends dudX_pTX
  algorithm
  dudX := fill(0.0, size(X, 1));
  end dudX_pTX;


redeclare function extends vaporPressure_pTX
  algorithm
  pVap := 10^(Poly.evaluate(data.polyVaporPressure, 1/T));
  end vaporPressure_pTX;


annotation (Documentation(info="<html>
<p>Compressible liquid model with states p, T, X. Density is a function of pressure only, incompressible <p>This implementation is similar to <a href=\"modelica://Modelon.Media.EquationsOfState.Templates.Liquids.<p>Analytic calculation of the inverse of h(T) is provided for polynomial degrees for cp of 2 or lower. <p><h4><font color=\"#008000\">Parameterization</font></h4></p>
<p>Medium properties for extending medium models are set by:</p>
<p>Fitted coefficients for the following as functions of temperature:</p>
<p><ul>
<li>Density</li>
<li>Heat capacity</li>
<li>Thermal conductivity</li>
<li>Viscosity</li>
<li>Vapor pressure</li>
</ul></p>
<p>Additionally, values for a reference state must be specified for:</p>
<p><ul>
<li>Pressure</li>
<li>Density</li>
<li>Specific enthalpy</li>
<li>Specific entropy</li>
</ul></p>
<p>The above properties are set by redeclaring the record <code>data. </code>The package constant T0 must <p><i>NOTE:</i> The reference density parameter is only used in certain cases, see <i>Compressibility types
<p><h4><font color=\"#008000\">Model description</font></h4></p>
<p>The properties are defined by polynomials for density, rho, and specific heat capacity, cp, defines rho(<p>The function <code>T_phX </code>(temperature from p,h,X) can only be calculated if there is an analytic <p><h4><font color=\"#008000\">Assumptions</font></h4></p>
<p><ul>
<li>dv/dT is assumed constant, i.e. specific volume is given by v(T,p) = (p0-p)*kappa0*v0 + 1/rho(T,p0).
<li>Specific enthalpy is calculated by integration from the reference state over cp(T,p0)*dT. Independent </ul></p>
<p><br/>Following the above assumptions cp(T,p) is defined for pressures other than p0 so that it cp(T,p) <p>Partial derivatives for rho and specific internal energy are also defined to be consistent with the above <p><h4><font color=\"#008000\">Compressibility types</font></h4></p>
<p>The constant <code>CompressibilityType</code> is forced to <code>PressureDependent</code>
<p><ul>
<li><code>PressureDependent: </code>Density is independent of temperature. Specific volume is given by v(</ul></p>
<p>Note that the compressibility factors beta and kappa can always be obtained from the respective function <p><h4><font color=\"#008000\">Analytic derivatives</font></h4></p>
<p>Analytic derivatives are specified for the specific enthalpy and specific volume functions.
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Baehr: <i>Thermodynamik 9. Auflage</i>, 1996, Springer</p>
</html>"));
end PolyBased_p;
