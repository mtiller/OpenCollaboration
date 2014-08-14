within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models;
package MoistAir "Air: Moist air model (240 ... 400 K)"
extends Interfaces.PartialCondensingGases(
  mediumName="Moist air",
  substanceNames={"water","air"},
  final reducedX=true,
  final singleState=false,
  reference_X={0.01,0.99},
  fluidConstants={IdealGases.Common.FluidData.H2O,IdealGases.Common.FluidData.N2});

constant Integer Water=1
  "Index of water (in substanceNames, massFractions X, etc.)";
constant Integer Air=2
  "Index of air (in substanceNames, massFractions X, etc.)";
//     constant SI.Pressure psat_low=saturationPressureWithoutLimits(200.0);
//     constant SI.Pressure psat_high=saturationPressureWithoutLimits(422.16);
constant Real k_mair=steam.MM/dryair.MM "ratio of molar weights";

constant IdealGases.Common.DataRecord dryair=IdealGases.Common.SingleGasesData.Air;
constant IdealGases.Common.DataRecord steam=IdealGases.Common.SingleGasesData.H2O;
constant SI.MolarMass[2] MMX={steam.MM,dryair.MM} "Molar masses of components";

import ORNL_AdvSMR.Media.Interfaces;
import Modelica.Math;
import SI = Modelica.SIunits;
import Cv = Modelica.SIunits.Conversions;
import Modelica.Constants;
import ORNL_AdvSMR.Media.IdealGases.Common.SingleGasNasa;


redeclare record extends ThermodynamicState
  "ThermodynamicState record for moist air"
  end ThermodynamicState;


redeclare replaceable model extends BaseProperties(
  T(stateSelect=if preferredMediumStates then StateSelect.prefer else
        StateSelect.default),
  p(stateSelect=if preferredMediumStates then StateSelect.prefer else
        StateSelect.default),
  Xi(stateSelect=if preferredMediumStates then StateSelect.prefer else
        StateSelect.default),
  redeclare final constant Boolean standardOrderComponents=true)
  "Moist air base properties record"

  /* p, T, X = X[Water] are used as preferred states, since only then all
     other quantities can be computed in a recursive sequence.
     If other variables are selected as states, static state selection
     is no longer possible and non-linear algebraic equations occur.
      */
  MassFraction x_water "Mass of total water/mass of dry air";
  Real phi "Relative humidity";

protected
  MassFraction X_liquid "Mass fraction of liquid or solid water";
  MassFraction X_steam "Mass fraction of steam water";
  MassFraction X_air "Mass fraction of air";
  MassFraction X_sat
    "Steam water mass fraction of saturation boundary in kg_water/kg_moistair";
  MassFraction x_sat
    "Steam water mass content of saturation boundary in kg_water/kg_dryair";
  AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
  equation
  assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T =" + String(T) + " K) <= 423.15 K
required from medium model \"" + mediumName + "\".");
  MM = 1/(Xi[Water]/MMX[Water] + (1.0 - Xi[Water])/MMX[Air]);

  p_steam_sat = min(saturationPressure(T), 0.999*p);
  X_sat = min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 -
    Xi[Water]), 1.0)
    "Water content at saturation with respect to actual water content";
  X_liquid = max(Xi[Water] - X_sat, 0.0);
  X_steam = Xi[Water] - X_liquid;
  X_air = 1 - Xi[Water];

  h = specificEnthalpy_pTX(
      p,
      T,
      Xi);
  R = dryair.R*(X_air/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
  //
  u = h - R*T;
  d = p/(R*T);
  /* Note, u and d are computed under the assumption that the volume of the liquid
         water is neglible with respect to the volume of air and of steam
      */
  state.p = p;
  state.T = T;
  state.X = X;

  // these x are per unit mass of DRY air!
  x_sat = k_mair*p_steam_sat/max(100*Constants.eps, p - p_steam_sat);
  x_water = Xi[Water]/max(X_air, 100*Constants.eps);
  phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
  annotation (Documentation(info="<html>
<p>This model computes thermodynamic properties of moist air from three independent (thermodynamic or/and numerical) state variables. Preferred numerical states are temperature T, pressure p and the reduced composition vector Xi, which contains the water mass fraction only. As an EOS the <b>ideal gas law</b> is used and associated restrictions apply. The model can also be used in the <b>fog region</b>, when moisture is present in its liquid state. However, it is assumed that the liquid water volume is negligible compared to that of the gas phase. Computation of thermal properties is based on property data of <a href=\"modelica://Modelica.Media.Air.DryAirNasa\"> dry air</a> and water (source: VDI-W&auml;rmeatlas), respectively. Besides the standard thermodynamic variables <b>absolute and relative humidity</b>, x_water and phi, respectively, are given by the model. Upper case X denotes absolute humidity with respect to mass of moist air while absolute humidity with respect to mass of dry air only is denoted by a lower case x throughout the model. See <a href=\"modelica://Modelica.Media.Air.MoistAir\">package description</a> for further information.</p>
</html>"));
  end BaseProperties;


redeclare function setState_pTX
  "Return thermodynamic state as function of pressure p, temperature T and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state "Thermodynamic state";
  algorithm
  state := if size(X, 1) == nX then ThermodynamicState(
      p=p,
      T=T,
      X=X) else ThermodynamicState(
      p=p,
      T=T,
      X=cat(
        1,
        X,
        {1 - sum(X)}));
  annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, temperature T and composition X.
</html>"));
  end setState_pTX;


redeclare function setState_phX
  "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state "Thermodynamic state";
  algorithm
  state := if size(X, 1) == nX then ThermodynamicState(
      p=p,
      T=T_phX(
        p,
        h,
        X),
      X=X) else ThermodynamicState(
      p=p,
      T=T_phX(
        p,
        h,
        X),
      X=cat(
        1,
        X,
        {1 - sum(X)}));
  annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
</html>"));
  end setState_phX;


redeclare function setState_dTX
  "Return thermodynamic state as function of density d, temperature T and composition X"
  extends Modelica.Icons.Function;
  input Density d "density";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state "Thermodynamic state";
  algorithm
  state := if size(X, 1) == nX then ThermodynamicState(
      p=d*({steam.R,dryair.R}*X)*T,
      T=T,
      X=X) else ThermodynamicState(
      p=d*({steam.R,dryair.R}*cat(
        1,
        X,
        {1 - sum(X)}))*T,
      T=T,
      X=cat(
        1,
        X,
        {1 - sum(X)}));
  annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from density d, temperature T and composition X.
</html>"));
  end setState_dTX;


redeclare function extends setSmoothState
  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  algorithm
  state := ThermodynamicState(
      p=Common.smoothStep(
        x,
        state_a.p,
        state_b.p,
        x_small),
      T=Common.smoothStep(
        x,
        state_a.T,
        state_b.T,
        x_small),
      X=Common.smoothStep(
        x,
        state_a.X,
        state_b.X,
        x_small));
  end setSmoothState;

/*
    redeclare function setState_psX "Return thermodynamic state as function of p, s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_psX(s,p,X),X=X)
        else ThermodynamicState(p=p,T=T_psX(p,s,X), X=cat(1,X,{1-sum(X)}));
    end setState_psX;
*/


redeclare function extends gasConstant
  "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

  algorithm
  R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
  annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
  end gasConstant;


redeclare function extends saturationPressure
  "Return saturation pressure of water as a function of temperature T between 223.16 and 373.16 K"

  algorithm
  psat := Utilities.spliceFunction(
      saturationPressureLiquid(Tsat),
      sublimationPressureIce(Tsat),
      Tsat - 273.16,
      1.0);
  annotation (
    Inline=false,
    smoothOrder=5,
    derivative=saturationPressure_der,
    Documentation(info="<html>
Saturation pressure of water in the liquid and the solid region is computed using an Antoine-type correlation. It's range of validity is between 223.16 and 373.16 K. Outside of these limits a (less accurate) result is returned. Functions for the
<a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">solid</a> and the <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\"> liquid</a> region, respectively, are combined using the first derivative continuous <a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">spliceFunction</a>.
</html>"));
  end saturationPressure;


redeclare function extends enthalpyOfVaporization
  "Return enthalpy of vaporization of water as a function of temperature T, 0 - 130 degC"

  algorithm
  /*r0 := 1e3*(2501.0145 - (T - 273.15)*(2.3853 + (T - 273.15)*(0.002969 - (T
      - 273.15)*(7.5293e-5 + (T - 273.15)*4.6084e-7))));*/
  //katrin: replaced by linear correlation, simpler and more accurate in the entire region
  //source VDI-Waermeatlas, linear inter- and extrapolation between values for 0.01 &deg;C and 40 &deg;C.
  r0 := (2405900 - 2500500)/(40 - 0)*(T - 273.16) + 2500500;
  annotation (smoothOrder=2, Documentation(info="<html>
Enthalpy of vaporization of water is computed from temperature in the region of 0 to 130 &deg;C.
</html>"));
  end enthalpyOfVaporization;


redeclare function extends enthalpyOfLiquid
  "Return enthalpy of liquid water as a function of temperature T(use enthalpyOfWater instead)"

  algorithm
  h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333333*(T -
    273.15)*(0.00010295 - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)*
    7.3221e-9))));
  annotation (
    Inline=false,
    smoothOrder=5,
    Documentation(info="<html>
Specific enthalpy of liquid water is computed from temperature using a polynomial approach. Kept for compatibility reasons, better use <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a> instead.
</html>"));
  end enthalpyOfLiquid;


redeclare function extends enthalpyOfGas
  "Return specific enthalpy of gas (air and steam) as a function of temperature T and composition X"

  algorithm
  h := SingleGasNasa.h_Tlow(
      data=steam,
      T=T,
      refChoice=3,
      h_off=46479.819 + 2501014.5)*X[Water] + SingleGasNasa.h_Tlow(
      data=dryair,
      T=T,
      refChoice=3,
      h_off=25104.684)*(1.0 - X[Water]);
  annotation (
    Inline=false,
    smoothOrder=5,
    Documentation(info="<html>
Specific enthalpy of moist air is computed from temperature, provided all water is in the gaseous state. The first entry in the composition vector X must be the mass fraction of steam. For a function that also covers the fog region please refer to <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
  end enthalpyOfGas;


redeclare function extends enthalpyOfCondensingGas
  "Return specific enthalpy of steam as a function of temperature T"

  algorithm
  h := SingleGasNasa.h_Tlow(
      data=steam,
      T=T,
      refChoice=3,
      h_off=46479.819 + 2501014.5);
  annotation (
    Inline=false,
    smoothOrder=5,
    Documentation(info="<html>
Specific enthalpy of steam is computed from temperature.
</html>"));
  end enthalpyOfCondensingGas;


redeclare function extends enthalpyOfNonCondensingGas
  "Return specific enthalpy of dry air as a function of temperature T"

  algorithm
  h := SingleGasNasa.h_Tlow(
      data=dryair,
      T=T,
      refChoice=3,
      h_off=25104.684);
  annotation (
    Inline=false,
    smoothOrder=1,
    Documentation(info="<html>
Specific enthalpy of dry air is computed from temperature.
</html>"));
  end enthalpyOfNonCondensingGas;


redeclare function extends pressure
  "Returns pressure of ideal gas as a function of the thermodynamic state record"

  algorithm
  p := state.p;
  annotation (smoothOrder=2, Documentation(info="<html>
Pressure is returned from the thermodynamic state record input as a simple assignment.
</html>"));
  end pressure;


redeclare function extends temperature
  "Return temperature of ideal gas as a function of the thermodynamic state record"

  algorithm
  T := state.T;
  annotation (smoothOrder=2, Documentation(info="<html>
Temperature is returned from the thermodynamic state record input as a simple assignment.
</html>"));
  end temperature;


redeclare function extends density
  "Returns density of ideal gas as a function of the thermodynamic state record"

  algorithm
  d := state.p/(gasConstant(state)*state.T);
  annotation (smoothOrder=2, Documentation(info="<html>
Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law.
</html>"));
  end density;


redeclare function extends specificEnthalpy
  "Return specific enthalpy of moist air as a function of the thermodynamic state record"

  algorithm
  h := h_pTX(
      state.p,
      state.T,
      state.X);
  annotation (smoothOrder=2, Documentation(info="<html>
Specific enthalpy of moist air is computed from the thermodynamic state record. The fog region is included for both, ice and liquid fog.
</html>"));
  end specificEnthalpy;


redeclare function extends isentropicExponent
  "Return isentropic exponent (only for gas fraction!)"
  algorithm
  gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
  end isentropicExponent;


redeclare function extends specificInternalEnergy
  "Return specific internal energy of moist air as a function of the thermodynamic state record"
  extends Modelica.Icons.Function;
  output SI.SpecificInternalEnergy u "Specific internal energy";
  algorithm
  u := specificInternalEnergy_pTX(
      state.p,
      state.T,
      state.X);

  annotation (smoothOrder=2, Documentation(info="<html>
Specific internal energy is determined from the thermodynamic state record, assuming that the liquid or solid water volume is negligible.
</html>"));
  end specificInternalEnergy;


redeclare function extends specificEntropy
  "Return specific entropy from thermodynamic state record, only valid for phi<1"

protected
  MoleFraction[2] Y=massToMoleFractions(state.X, {steam.MM,dryair.MM})
    "molar fraction";
  algorithm
  s := SingleGasNasa.s0_Tlow(dryair, state.T)*(1 - state.X[Water]) +
    SingleGasNasa.s0_Tlow(steam, state.T)*state.X[Water] - (state.X[Water]*
    Modelica.Constants.R/MMX[Water]*(if state.X[Water] < Modelica.Constants.eps
     then state.X[Water] else Modelica.Math.log(Y[Water]*state.p/reference_p))
     + (1 - state.X[Water])*Modelica.Constants.R/MMX[Air]*(if (1 - state.X[
    Water]) < Modelica.Constants.eps then (1 - state.X[Water]) else
    Modelica.Math.log(Y[Air]*state.p/reference_p)));
  annotation (
    Inline=false,
    smoothOrder=2,
    Documentation(info="<html>
Specific entropy is calculated from the thermodynamic state record, assuming ideal gas behavior and including entropy of mixing. Liquid or solid water is not taken into account, the entire water content X[1] is assumed to be in the vapor state (relative humidity below 1.0).
</html>"));
  end specificEntropy;


redeclare function extends specificGibbsEnergy
  "Return specific Gibbs energy as a function of the thermodynamic state record, only valid for phi<1"
  extends Modelica.Icons.Function;
  algorithm
  g := h_pTX(
      state.p,
      state.T,
      state.X) - state.T*specificEntropy(state);
  annotation (smoothOrder=2, Documentation(info="<html>
The Gibbs Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
  end specificGibbsEnergy;


redeclare function extends specificHelmholtzEnergy
  "Return specific Helmholtz energy as a function of the thermodynamic state record, only valid for phi<1"
  extends Modelica.Icons.Function;
  algorithm
  f := h_pTX(
      state.p,
      state.T,
      state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
  annotation (smoothOrder=2, Documentation(info="<html>
The Specific Helmholtz Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
  end specificHelmholtzEnergy;


redeclare function extends specificHeatCapacityCp
  "Return specific heat capacity at constant pressure as a function of the thermodynamic state record"

protected
  Real dT(unit="s/K") = 1.0;
  algorithm
  cp := h_pTX_der(
      state.p,
      state.T,
      state.X,
      0.0,
      1.0,
      zeros(size(state.X, 1)))*dT "Definition of cp: dh/dT @ constant p";
  //      cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
  //        + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
  annotation (
    Inline=false,
    smoothOrder=2,
    Documentation(info="<html>
The specific heat capacity at constant pressure <b>cp</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "Return specific heat capacity at constant volume as a function of the thermodynamic state record"

  algorithm
  cv := SingleGasNasa.cp_Tlow(dryair, state.T)*(1 - state.X[Water]) +
    SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water] - gasConstant(state);
  annotation (
    Inline=false,
    smoothOrder=2,
    Documentation(info="<html>
The specific heat capacity at constant density <b>cv</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
  end specificHeatCapacityCv;


redeclare function extends dynamicViscosity
  "Return dynamic viscosity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"

  import ORNL_AdvSMR.Media.Incompressible.TableBased.Polynomials_Temp;
  algorithm
  eta := Polynomials_Temp.evaluate({(-4.96717436974791E-011),
    5.06626785714286E-008,1.72937731092437E-005}, Cv.to_degC(state.T));
  annotation (smoothOrder=2, Documentation(info="<html>
Dynamic viscosity is computed from temperature using a simple polynomial for dry air, assuming that moisture influence is small. Range of  validity is from 73.15 K to 373.15 K.
</html>"));
  end dynamicViscosity;


redeclare function extends thermalConductivity
  "Return thermal conductivity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"

  import ORNL_AdvSMR.Media.Incompressible.TableBased.Polynomials_Temp;
  algorithm
  lambda := Polynomials_Temp.evaluate({(-4.8737307422969E-008),
    7.67803133753502E-005,0.0241814385504202}, Cv.to_degC(state.T));
  annotation (smoothOrder=2, Documentation(info="<html>
Thermal conductivity is computed from temperature using a simple polynomial for dry air, assuming that moisture influence is small. Range of  validity is from 73.15 K to 373.15 K.
</html>"));
  end thermalConductivity;


annotation (Documentation(info="<html>
<h4>Thermodynamic Model</h4>
<p>This package provides a full thermodynamic model of moist air including the fog region and temperatures below zero degC.
The governing assumptions in this model are:</p>
<ul>
<li>the perfect gas law applies</li>
<li>water volume other than that of steam is neglected</li></ul>
<p>All extensive properties are expressed in terms of the total mass in order to comply with other media in this libary. However, for moist air it is rather common to express the absolute humidity in terms of mass of dry air only, which has advantages when working with charts. In addition, care must be taken, when working with mass fractions with respect to total mass, that all properties refer to the same water content when being used in mathematical operations (which is always the case if based on dry air only). Therefore two absolute humidities are computed in the <b>BaseProperties</b> model: <b>X</b> denotes the absolute humidity in terms of the total mass while <b>x</b> denotes the absolute humitity per unit mass of dry air. In addition, the relative humidity <b>phi</b> is also computed.</p>
<p>At the triple point temperature of water of 0.01 &deg;C or 273.16 K and a relative humidity greater than 1 fog may be present as liquid and as ice resulting in a specific enthalpy somewhere between those of the two isotherms for solid and liquid fog, respectively. For numerical reasons a coexisting mixture of 50% solid and 50% liquid fog is assumed in the fog region at the triple point in this model.</p>

<h4>Range of validity</h4>
<p>From the assumptions mentioned above it follows that the <b>pressure</b> should be in the region around <b>atmospheric</b> conditions or below (a few bars may still be fine though). Additionally a very high water content at low temperatures would yield incorrect densities, because the volume of the liquid or solid phase would not be negligible anymore. The model does not provide information on limits for water drop size in the fog region or transport information for the actual condensation or evaporation process in combination with surfaces. All excess water which is not in its vapour state is assumed to be still present in the air regarding its energy but not in terms of its spatial extent.<br><br>
The thermodynamic model may be used for <b>temperatures</b> ranging from <b>240 - 400 K</b>. This holds for all functions unless otherwise stated in their description. However, although the model works at temperatures above the saturation temperature it is questionable to use the term \"relative humidity\" in this region. Please note, that although several functions compute pure water properties, they are designed to be used within the moist air medium model where properties are dominated by air and steam in their vapor states, and not for pure liquid water applications.</p>

<h4>Transport Properties</h4>
<p>Several additional functions that are not needed to describe the thermodynamic system, but are required to model transport processes, like heat and mass transfer, may be called. They usually neglect the moisture influence unless otherwise stated.</p>

<h4>Application</h4>
<p>The model's main area of application is all processes that involve moist air cooling under near atmospheric pressure with possible moisture condensation. This is the case in all domestic and industrial air conditioning applications. Another large domain of moist air applications covers all processes that deal with dehydration of bulk material using air as a transport medium. Engineering tasks involving moist air are often performed (or at least visualized) by using charts that contain all relevant thermodynamic data for a moist air system. These so called psychrometric charts can be generated from the medium properties in this package. The model <a href=\"modelica://Modelica.Media.Air.MoistAir.PsychrometricData\">PsychrometricData</a> may be used for this purpose in order to obtain data for figures like those below (the plotting itself is not part of the model though).</p>

<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\">

<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">

<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

</html>"));
end MoistAir;
