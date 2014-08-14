within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids;
package PolyBased "EoS for a liquid with properties defined by polynomials"
extends ORNL_AdvSMR.Media.EquationsOfState.Interfaces.Liquids(final
    analyticInverseTfromh=(not data.npol_Cp > 1 and data.npol_rho < 1));
import ORNL_AdvSMR.Media.Interfaces.State.Units;
import Poly = Modelon.Math.Polynomials;
import ORNL_AdvSMR.Media.Interfaces.Types.Compressibility;
constant ORNL_AdvSMR.Media.DataDefinitions.PolyBased.PolyBasedFluid data
  "data record";
constant ORNL_AdvSMR.Media.Interfaces.Types.ValidityLimits limits(
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
constant Modelica.SIunits.SpecificVolume v0=if CompressibilityType ==
    Compressibility.FullyCompressible or CompressibilityType == Compressibility.TemperatureDependent
     then 1/max(Poly.evaluate(data.polyDensity, T0), limits.DMIN) else 1/data.reference_d;
constant Units.MolarMass MM_const=0.1 "Molar mass";


redeclare function extends h_pTX
protected
  Real cp_int=Poly.integralValue(
        data.polyHeatCapacity,
        T,
        T0) "Integral value of cp(T,p0) from T0 to T";
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T)
    "Density derivative wrt T at p0";
  Modelica.SIunits.Pressure p0=data.reference_p;
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible then
    h := data.reference_h + cp_int + (p - p0)*(1/rhoT + T*drhoT/rhoT/rhoT + p0*
      data.kappa_const*v0) - data.kappa_const*v0*(p^2 - p0^2)/2;
  elseif CompressibilityType == Compressibility.TemperatureDependent then
    h := data.reference_h + cp_int + (p - p0)*(1/rhoT + T*drhoT/rhoT/rhoT);
  elseif CompressibilityType == Compressibility.PressureDependent then
    h := data.reference_h + cp_int + (p - p0)*v0*(1 + p0*data.kappa_const) -
      data.kappa_const*v0*(p^2 - p0^2)/2;
  else
    h := data.reference_h + cp_int + (p - p0)*v0;
  end if;
  annotation (derivative(noDerivative=X) = h_pT_der);
  end h_pTX;


redeclare function extends T_phX
protected
  Real tmp "temporary variable for increased readability of code";
  Modelica.SIunits.Pressure p0=data.reference_p;
  constant Real cp[data.npol_Cp + 1]=data.polyHeatCapacity
    "cp polynomial where the coefficients are given for temperatures in Kelvin";
  algorithm
  assert(analyticInverseTfromh,
    "T_phX: No analytic inverse for polynomials with npol_Cp > 1 or npol_rho >0");
  tmp := h - data.reference_h - (p - p0)*(1/data.polyDensity[1] + p0*data.kappa_const
    *v0) + data.kappa_const*v0*(p^2 - p0^2)/2;
  T := if data.npol_Cp == 0 then (tmp + T0*cp[1])/cp[1] else (-cp[2] + sqrt(cp[
    2]^2 + 2*cp[1]*tmp + cp[1]^2*T0^2 + 2*cp[1]*cp[2]*T0))/cp[1];
  end T_phX;


redeclare function extends d_pTX
  algorithm
  d := max(1.0/v_pTX(
      p,
      T,
      X), limits.DMIN);
  end d_pTX;


redeclare function extends v_pTX
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible then
    v := (data.reference_p - p)*data.kappa_const*v0 + 1/rhoT;
  elseif CompressibilityType == Compressibility.TemperatureDependent then
    v := 1/rhoT;
  elseif CompressibilityType == Compressibility.PressureDependent then
    v := (data.reference_p - p)*data.kappa_const*v0 + v0;
  else
    v := v0;
  end if;
  annotation (derivative(noDerivative=X) = v_pT_der);
  end v_pTX;


redeclare function extends cp_pTX
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
  Real ddrhoT=Poly.secondDerivativeValue(data.polyDensity, T);
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible or
      CompressibilityType == Compressibility.TemperatureDependent then
    cp := Poly.evaluate(data.polyHeatCapacity, T) + (p - data.reference_p)*T/(
      rhoT*rhoT)*(ddrhoT - 2*drhoT*drhoT/rhoT);
  else
    cp := Poly.evaluate(data.polyHeatCapacity, T);
  end if;
  end cp_pTX;


redeclare function extends beta_pTX "1/v*(dv/dT)"
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
  algorithm
  beta := -drhoT/(v_pTX(
      p,
      T,
      X)*rhoT*rhoT);
  end beta_pTX;


redeclare function extends kappa_pTX "-1/v*(dv/dp)"
  algorithm
  kappa := data.kappa_const*v0/v_pTX(
      p,
      T,
      X);
  end kappa_pTX;


redeclare function extends s_pTX
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible or
      CompressibilityType == Compressibility.TemperatureDependent then
    s := data.reference_s - (p - data.reference_p)*(drhoT/(rhoT*rhoT)) +
      Poly.integralValue(
        data.polyHeatCapacity[1:data.npol_Cp],
        T,
        T0) + Modelica.Math.log(T/T0)*data.polyHeatCapacity[data.npol_Cp + 1];
  else
    s := data.reference_s + Poly.integralValue(
        data.polyHeatCapacity[1:data.npol_Cp],
        T,
        T0) + Modelica.Math.log(T/T0)*data.polyHeatCapacity[data.npol_Cp + 1];
  end if;
  end s_pTX;


redeclare function extends dddp_pTX
protected
  Units.SpecificVolume v=v_pTX(
        p,
        T,
        X);
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible or
      CompressibilityType == Compressibility.PressureDependent then
    dddp := data.kappa_const*v0/(v*v);
  else
    dddp := 0;
  end if;
  end dddp_pTX;


redeclare function extends dddT_pTX
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
  Modelica.SIunits.SpecificVolume v=v_pTX(
        p,
        T,
        X);
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible or
      CompressibilityType == Compressibility.TemperatureDependent then
    dddT := drhoT/(v*v*rhoT*rhoT);
  else
    dddT := 0;
  end if;
  end dddT_pTX;


redeclare function extends dddX_pTX
  algorithm
  dddX := fill(0.0, size(X, 1));
  end dddX_pTX;


redeclare function extends dudp_pTX
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible then
    dudp := T*drhoT/(rhoT*rhoT) + p*data.kappa_const*v0;
  elseif CompressibilityType == Compressibility.TemperatureDependent then
    dudp := T*drhoT/(rhoT*rhoT);
  elseif CompressibilityType == Compressibility.PressureDependent then
    dudp := p*data.kappa_const*v0;
  else
    dudp := 0;
  end if;
  end dudp_pTX;


redeclare function extends dudT_pTX
protected
  Modelica.SIunits.Density rhoT=max(Poly.evaluate(data.polyDensity, T), limits.DMIN)
    "Density rho(T,p0)";
  Real drhoT=Poly.derivativeValue(data.polyDensity, T);
  algorithm
  if CompressibilityType == Compressibility.FullyCompressible or
      CompressibilityType == Compressibility.TemperatureDependent then
    dudT := cp_pTX(
        p,
        T,
        X) + p*drhoT/(rhoT*rhoT);
  else
    dudT := cp_pTX(
        p,
        T,
        X);
  end if;
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
<p>Compressible liquid model with states p, T, X. Specific enthalpy formulation accounts for pressure dependency. <p>Analytic T(h) only for constant density and constant or linear cp. If an analytic inverse is desired <p><h4><font color=\"#008000\">Parameterization</font></h4></p>
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
<li>Specific enthalpy is calculated by integration from the reference state over cp(T,p0)*dT + (v-T*dv/dT)*</ul></p>
<p><br/>Following the above assumptions cp(T,p) is defined for pressures other than p0 so that it cp(T,p) <p>Partial derivatives for rho and specific internal energy are also defined to be consistent with the above <p><h4><font color=\"#008000\">Compressibility types</font></h4></p>
<p>The constant <code>CompressibilityType</code> can be set to four different choices giving different behaviour:
<p><ul>
<li><code>FullyCompressible: </code>The case described above. v0 is defined as 1/rho(T0,p0) and calculated <li><code>TemperatureDependent: </code>Density is independent of pressure. Specific volume is given by v(<li><code>PressureDependent: </code>Density is independent of temperature. Specific volume is given by v(<li><code>ConstantDensity: </code>Incompressible medium, density is constant = <code>data.reference_d.
</ul></p>
<p>Note that the compressibility factors beta and kappa can always be obtained from the respective function <p><h4><font color=\"#008000\">Analytic derivatives</font></h4></p>
<p>Analytic derivatives are specified for the specific enthalpy and specific volume functions.
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Baehr: <i>Thermodynamik 9. Auflage</i>, 1996, Springer</p>
</html>"));
end PolyBased;
