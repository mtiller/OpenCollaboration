within ORNL_AdvSMR.Media.Fluids.IdealGases.Common;
partial package SingleGasNasa "Medium model of an ideal gas based on NASA source"


extends Modelica.Media.Interfaces.PartialPureSubstance(
  ThermoStates=Choices.IndependentVariables.pT,
  mediumName=data.name,
  substanceNames={data.name},
  singleState=false,
  Temperature(
    min=200,
    max=6000,
    start=500,
    nominal=500),
  SpecificEnthalpy(start=if referenceChoice == ReferenceEnthalpy.ZeroAt0K then
        data.H0 else if referenceChoice == ReferenceEnthalpy.UserDefined then
        h_offset else 0, nominal=1.0e5),
  Density(start=10, nominal=10),
  AbsolutePressure(start=10e5, nominal=10e5));


redeclare record extends ThermodynamicState
  "thermodynamic state variables for ideal gases"
  AbsolutePressure p "Absolute pressure of medium";
  Temperature T "Temperature of medium";
  end ThermodynamicState;


redeclare record extends FluidConstants "Extended fluid constants"
  Temperature criticalTemperature "critical temperature";
  AbsolutePressure criticalPressure "critical pressure";
  MolarVolume criticalMolarVolume "critical molar Volume";
  Real acentricFactor "Pitzer acentric factor";
  Temperature triplePointTemperature "triple point temperature";
  AbsolutePressure triplePointPressure "triple point pressure";
  Temperature meltingPoint "melting point at 101325 Pa";
  Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
  DipoleMoment dipoleMoment
    "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
  Boolean hasIdealGasHeatCapacity=false
    "true if ideal gas heat capacity is available";
  Boolean hasCriticalData=false "true if critical data are known";
  Boolean hasDipoleMoment=false "true if a dipole moment known";
  Boolean hasFundamentalEquation=false "true if a fundamental equation";
  Boolean hasLiquidHeatCapacity=false
    "true if liquid heat capacity is available";
  Boolean hasSolidHeatCapacity=false "true if solid heat capacity is available";
  Boolean hasAccurateViscosityData=false
    "true if accurate data for a viscosity function is available";
  Boolean hasAccurateConductivityData=false
    "true if accurate data for thermal conductivity is available";
  Boolean hasVapourPressureCurve=false
    "true if vapour pressure data, e.g., Antoine coefficents are known";
  Boolean hasAcentricFactor=false "true if Pitzer accentric factor is known";
  SpecificEnthalpy HCRIT0=0.0
    "Critical specific enthalpy of the fundamental equation";
  SpecificEntropy SCRIT0=0.0
    "Critical specific entropy of the fundamental equation";
  SpecificEnthalpy deltah=0.0
    "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
  SpecificEntropy deltas=0.0
    "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
  end FluidConstants;

import SI = Modelica.SIunits;
import Modelica.Math;
import Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy;

constant Boolean excludeEnthalpyOfFormation=true
  "If true, enthalpy of formation Hf is not included in specific enthalpy h";
constant ReferenceEnthalpy referenceChoice=Choices.ReferenceEnthalpy.ZeroAt0K
  "Choice of reference enthalpy";
constant SpecificEnthalpy h_offset=0.0
  "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

constant DataRecord data "Data record of ideal gas substance";

constant FluidConstants[nS] fluidConstants "constant data for the fluid";


redeclare model extends BaseProperties(T(stateSelect=if preferredMediumStates
         then StateSelect.prefer else StateSelect.default), p(stateSelect=if
        preferredMediumStates then StateSelect.prefer else StateSelect.default))
  "Base properties of ideal gas medium"
  equation
  assert(T >= 200 and T <= 6000, "
Temperature T (= " + String(T) + " K) is not in the allowed range
200 K <= T <= 6000 K required from medium model \"" + mediumName + "\".
");
  MM = data.MM;
  R = data.R;
  h = h_T(
      data,
      T,
      excludeEnthalpyOfFormation,
      referenceChoice,
      h_offset);
  u = h - R*T;

  // Has to be written in the form d=f(p,T) in order that static
  // state selection for p and T is possible
  d = p/(R*T);
  // connect state with BaseProperties
  state.T = T;
  state.p = p;
  end BaseProperties;


redeclare function setState_pTX
  "Return thermodynamic state as function of p, T and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state;
  algorithm
  state := ThermodynamicState(p=p, T=T);
  end setState_pTX;


redeclare function setState_phX
  "Return thermodynamic state as function of p, h and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state;
  algorithm
  state := ThermodynamicState(p=p, T=T_h(h));
  end setState_phX;


redeclare function setState_psX
  "Return thermodynamic state as function of p, s and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state;
  algorithm
  state := ThermodynamicState(p=p, T=T_ps(p, s));
  end setState_psX;


redeclare function setState_dTX
  "Return thermodynamic state as function of d, T and composition X"
  extends Modelica.Icons.Function;
  input Density d "density";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state;
  algorithm
  state := ThermodynamicState(p=d*data.R*T, T=T);
  end setState_dTX;


redeclare function extends setSmoothState
  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  algorithm
  state := ThermodynamicState(p=Modelica.Media.Common.smoothStep(
      x,
      state_a.p,
      state_b.p,
      x_small), T=Modelica.Media.Common.smoothStep(
      x,
      state_a.T,
      state_b.T,
      x_small));
  end setSmoothState;


redeclare function extends pressure "return pressure of ideal gas"
  algorithm
  p := state.p;
  end pressure;


redeclare function extends temperature "return temperature of ideal gas"
  algorithm
  T := state.T;
  end temperature;


redeclare function extends density "return density of ideal gas"
  algorithm
  d := state.p/(data.R*state.T);
  end density;


redeclare function extends specificEnthalpy "Return specific enthalpy"
  extends Modelica.Icons.Function;
  algorithm
  h := h_T(data, state.T);
  end specificEnthalpy;


redeclare function extends specificInternalEnergy
  "Return specific internal energy"
  extends Modelica.Icons.Function;
  algorithm
  u := h_T(data, state.T) - data.R*state.T;
  end specificInternalEnergy;


redeclare function extends specificEntropy "Return specific entropy"
  extends Modelica.Icons.Function;
  algorithm
  s := s0_T(data, state.T) - data.R*Modelica.Math.log(state.p/reference_p);
  end specificEntropy;


redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
  extends Modelica.Icons.Function;
  algorithm
  g := h_T(data, state.T) - state.T*specificEntropy(state);
  end specificGibbsEnergy;


redeclare function extends specificHelmholtzEnergy
  "Return specific Helmholtz energy"
  extends Modelica.Icons.Function;
  algorithm
  f := h_T(data, state.T) - data.R*state.T - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;


redeclare function extends specificHeatCapacityCp
  "Return specific heat capacity at constant pressure"
  algorithm
  cp := cp_T(data, state.T);
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "Compute specific heat capacity at constant volume from temperature and gas data"
  algorithm
  cv := cp_T(data, state.T) - data.R;
  end specificHeatCapacityCv;


redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
  gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
  end isentropicExponent;


redeclare function extends velocityOfSound "Return velocity of sound"
  extends Modelica.Icons.Function;
  algorithm
  a := sqrt(max(0, data.R*state.T*cp_T(data, state.T)/specificHeatCapacityCv(
    state)));
  end velocityOfSound;


redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
  input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  input ReferenceEnthalpy refChoice=referenceChoice
    "Choice of reference enthalpy";
  input SpecificEnthalpy h_off=h_offset
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
  algorithm
  h_is := isentropicEnthalpyApproximation(
      p_downstream,
      refState,
      exclEnthForm,
      refChoice,
      h_off);
  end isentropicEnthalpy;


redeclare function extends isobaricExpansionCoefficient
  "Returns overall the isobaric expansion coefficient beta"
  algorithm
  beta := 1/state.T;
  end isobaricExpansionCoefficient;


redeclare function extends isothermalCompressibility
  "Returns overall the isothermal compressibility factor"
  algorithm
  kappa := 1.0/state.p;
  end isothermalCompressibility;


redeclare function extends density_derp_T
  "Returns the partial derivative of density with respect to pressure at constant temperature"
  algorithm
  ddpT := 1/(state.T*data.R);
  end density_derp_T;


redeclare function extends density_derT_p
  "Returns the partial derivative of density with respect to temperature at constant pressure"
  algorithm
  ddTp := -state.p/(state.T*state.T*data.R);
  end density_derT_p;


redeclare function extends density_derX
  "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
  algorithm
  dddX := fill(0, nX);
  end density_derX;


redeclare replaceable function extends dynamicViscosity "dynamic viscosity"
  algorithm
  assert(fluidConstants[1].hasCriticalData,
    "Failed to compute dynamicViscosity: For the species \"" + mediumName +
    "\" no critical data is available.");
  assert(fluidConstants[1].hasDipoleMoment,
    "Failed to compute dynamicViscosity: For the species \"" + mediumName +
    "\" no critical data is available.");
  eta := dynamicViscosityLowPressure(
      state.T,
      fluidConstants[1].criticalTemperature,
      fluidConstants[1].molarMass,
      fluidConstants[1].criticalMolarVolume,
      fluidConstants[1].acentricFactor,
      fluidConstants[1].dipoleMoment);
  annotation (smoothOrder=2);
  end dynamicViscosity;


redeclare replaceable function extends thermalConductivity
  "thermal conductivity of gas"
  input Integer method=1 "1: Eucken Method, 2: Modified Eucken Method";
  algorithm
  assert(fluidConstants[1].hasCriticalData,
    "Failed to compute thermalConductivity: For the species \"" + mediumName +
    "\" no critical data is available.");
  lambda := thermalConductivityEstimate(
      specificHeatCapacityCp(state),
      dynamicViscosity(state),
      method=method);
  annotation (smoothOrder=2);
  end thermalConductivity;


redeclare function extends molarMass "return the molar mass of the medium"
  algorithm
  MM := data.MM;
  end molarMass;


annotation (
  Documentation(info="<HTML>
<p>
This model calculates medium properties
for an ideal gas of a single substance, or for an ideal
gas consisting of several substances where the
mass fractions are fixed. Independent variables
are temperature <b>T</b> and pressure <b>p</b>.
Only density is a function of T and p. All other quantities
are solely a function of T. The properties
are valid in the range:
</p>
<pre>
   200 K &le; T &le; 6000 K
</pre>
<p>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy h = h(T)</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy u = u(T)</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density d = d(p,T)</td></tr>
</table>
<p>
For the other variables, see the functions in
Modelica.Media.IdealGases.Common.SingleGasNasa.
Note, dynamic viscosity and thermal conductivity are only provided
for gases that use a data record from Modelica.Media.IdealGases.FluidData.
Currently these are the following gases:
</p>
<pre>
  Ar
  C2H2_vinylidene
  C2H4
  C2H5OH
  C2H6
  C3H6_propylene
  C3H7OH
  C3H8
  C4H8_1_butene
  C4H9OH
  C4H10_n_butane
  C5H10_1_pentene
  C5H12_n_pentane
  C6H6
  C6H12_1_hexene
  C6H14_n_heptane
  C7H14_1_heptene
  C8H10_ethylbenz
  CH3OH
  CH4
  CL2
  CO
  CO2
  F2
  H2
  H2O
  He
  N2
  N2O
  NH3
  NO
  O2
  SO2
  SO3
</pre>
<p>
<b>Sources for model and literature:</b><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><b>Known limits of validity:</b></br>
The data is valid for
temperatures between 200 K and 6000 K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000 K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library
and adapted to the Modelica.Media package.
</p>
</HTML>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics),
  Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
          100}}), graphics));
end SingleGasNasa;
