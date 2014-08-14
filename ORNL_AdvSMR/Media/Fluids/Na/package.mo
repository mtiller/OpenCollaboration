within ORNL_AdvSMR.Media.Fluids;
package Na "Liquid sodium (incompressible model)"

constant Interfaces.PartialSinglePhaseMedium.FluidConstants[1] sodiumConstants(
  each chemicalFormula="Na",
  each structureFormula="Na",
  each casRegistryNumber="",
  each iupacName="sodium",
  each molarMass=0.0229897697,
  each criticalTemperature=2573,
  each criticalPressure=35e6,
  each criticalMolarVolume=1/322.0*0.0229897697,
  each normalBoilingPoint=1156,
  each meltingPoint=370.87,
  each triplePointTemperature=273.16,
  each triplePointPressure=611.657,
  each acentricFactor=0.344,
  each dipoleMoment=1.8,
  each hasCriticalData=true);

constant Interfaces.PartialMedium.FluidConstants[1] simpleSodiumConstants(
  each chemicalFormula="Na",
  each structureFormula="Na",
  each casRegistryNumber="",
  each iupacName="sodium",
  each molarMass=0.0229897697);


extends Interfaces.PartialSinglePhaseMedium(
  mediumName="sodium",
  substanceNames={"sodium"},
  singleState=true,
  SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
  Density(start=900, nominal=800),
  AbsolutePressure(start=1.01325e5, nominal=1.01325e5),
  Temperature(start=400, nominal=700),
  smoothModel=true,
  onePhase=true,
  fluidConstants=sodiumConstants);


redeclare record extends ThermodynamicState "thermodynamic state"
  SpecificEnthalpy h "specific enthalpy";
  Density d "density";
  Temperature T "temperature";
  AbsolutePressure p "pressure";
  end ThermodynamicState;

constant Boolean ph_explicit
  "true if explicit in pressure and specific enthalpy";
constant Boolean dT_explicit "true if explicit in density and temperature";
constant Boolean pT_explicit "true if explicit in pressure and temperature";


redeclare replaceable model extends BaseProperties(
  h(stateSelect=if ph_explicit and preferredMediumStates then StateSelect.prefer
         else StateSelect.default),
  d(stateSelect=if dT_explicit and preferredMediumStates then StateSelect.prefer
         else StateSelect.default),
  T(stateSelect=if (pT_explicit or dT_explicit) and preferredMediumStates then
        StateSelect.prefer else StateSelect.default),
  p(stateSelect=if (pT_explicit or ph_explicit) and preferredMediumStates then
        StateSelect.prefer else StateSelect.default))
  "Base properties of sodium"

  Integer phase(
    min=0,
    max=2,
    start=1,
    fixed=false) "2 for two-phase, 1 for one-phase, 0 if not known";
  SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5))
    "saturation temperature and pressure";
  equation
  MM = fluidConstants[1].molarMass;
  if smoothModel then
    if onePhase then
      phase = 1;
      if ph_explicit then
        assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
          fluidConstants[1].criticalPressure),
          "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!"
           + "(p = " + String(p) + ", h = " + String(h) + ")");
      else
        if dT_explicit then
          assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
            fluidConstants[1].criticalTemperature),
            "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!"
             + "(d = " + String(d) + ", T = " + String(T) + ")");
        else
          assert(true, "no events for pT-model");
        end if;
      end if;
    else
      phase = 0;
    end if;
  else
    if ph_explicit then
      phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
        fluidConstants[1].criticalPressure) then 1 else 2;
    elseif dT_explicit then
      phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
        fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase = 1;
      //this is for the one-phase only case pT
    end if;
  end if;
  if dT_explicit then
    p = pressure_dT(
        d,
        T,
        phase);
    h = specificEnthalpy_dT(
        d,
        T,
        phase);
    sat.Tsat = T;
    sat.psat = saturationPressure(T);
  elseif ph_explicit then
    d = density_ph(
        p,
        h,
        phase);
    T = temperature_ph(
        p,
        h,
        phase);
    sat.Tsat = saturationTemperature(p);
    sat.psat = p;
  else
    h = specificEnthalpy_pT(p, T);
    d = density_pT(p, T);
    sat.psat = p;
    sat.Tsat = saturationTemperature(p);
  end if;
  u = h - p/d;
  R = Modelica.Constants.R/fluidConstants[1].molarMass;
  h = state.h;
  p = state.p;
  T = state.T;
  d = state.d;
  phase = state.phase;
  end BaseProperties;


redeclare function density_ph
  "Computes density as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  // d := 1011.8 - 0.22054*T - 1.9226e-5*T^2 + 5.6371e-9*T^3 "Stone et al. from J.K. Fink, ANL, CONF-8106164--5";
  d := 1017.0 - 0.239*(-22.6502 + 0.7841e-3*h)
    "Linearized version of density equation by Stone et al.";
  end density_ph;


redeclare function density_pT
  "Computes density as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  // d := 1011.8 - 0.22054*T - 1.9226e-5*T^2 + 5.6371e-9*T^3 "Stone et al. from J.K. Fink, ANL, CONF-8106164--5";
  d := 1017.0 - 0.239*T
    "Linearized version of density equation by Stone et al.";
  end density_pT;


redeclare function density_ps
  "Computes density as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "density";
  algorithm
  d := 750;
  end density_ps;


redeclare function temperature_ph
  "Computes temperature as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := -22.6502 + 0.7841e-3*h;
  end temperature_ph;


redeclare function temperature_ps
  "Compute temperature from pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := 675;
  end temperature_ps;


redeclare function pressure_dT
  "Computes pressure as a function of density and temperature"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output AbsolutePressure p "Pressure";
  algorithm
  p := 101325 "Constant pressure system at 1-atm (101325-Pa) pressure";
  end pressure_dT;


redeclare function specificEnthalpy_dT
  "Computes specific enthalpy as a function of density and temperature"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 28.8858e3 + 1.2753e3*T;
  end specificEnthalpy_dT;


redeclare function specificEnthalpy_pT
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 28.8858e3 + 1.2753e3*T;
  end specificEnthalpy_pT;


redeclare function specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 922
    "Constant pressure; entropy relations are not known... Enthalpy value at 675 deg C is generated.";
  end specificEnthalpy_ps;


redeclare function extends setDewState
  "set the thermodynamic state on the dew line"
  algorithm
  state := ThermodynamicState(
      phase=phase,
      p=sat.psat,
      T=sat.Tsat,
      h=dewEnthalpy(sat),
      d=dewDensity(sat));
  end setDewState;


redeclare function extends setBubbleState
  "set the thermodynamic state on the bubble line"
  algorithm
  state := ThermodynamicState(
      phase=phase,
      p=sat.psat,
      T=sat.Tsat,
      h=bubbleEnthalpy(sat),
      d=bubbleDensity(sat));
  end setBubbleState;


redeclare function extends dynamicViscosity "Dynamic viscosity of sodium"
  algorithm
  // eta := 11.3962e-3 - 1.0364e-6*state.T //
  // eta := 11.3962e-5 - 1.0364e-8*state.T
  //   "linearized dynamic viscosity as a function of temperature (K)";
  // conversion error corrected (c.g.s. to Pa.s)

  eta := 0.000000000834489*state.T^2 - 0.000001677553330*state.T +
    0.001031792005641 "quadratic fit (Feb 11, 2014) - Cetiner";

  end dynamicViscosity;


redeclare function extends thermalConductivity "Thermal conductivity of sodium"
  algorithm
  // lambda := 109.7 - 0.0645*state.T + 1.173e-5*(state.T)^2 "(Sacit May 17, 2013)";
  lambda := 102.82 - 0.0457*state.T
    "Linearized version of thermal conductivity (Sacit May 17, 2013)";
  end thermalConductivity;


redeclare function extends surfaceTension
  "Surface tension of sodium; only a function of temperature"
  algorithm
  sigma := 0.2928 - 1.2e-4*sat.Tsat
    "Cantor (1968) correlation for surface tension; only a function of temperature (K)";
  end surfaceTension;


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
  d := state.d;
  end density;


redeclare function extends specificEnthalpy "Return specific enthalpy"
  extends Modelica.Icons.Function;
  algorithm
  h := state.h;
  end specificEnthalpy;


redeclare function extends specificInternalEnergy
  "Return specific internal energy"
  extends Modelica.Icons.Function;
  algorithm
  u := state.h - state.p/state.d;
  end specificInternalEnergy;


redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
  extends Modelica.Icons.Function;
  algorithm
  g := state.h - state.T*specificEntropy(state);
  end specificGibbsEnergy;


redeclare function extends specificHelmholtzEnergy
  "Return specific Helmholtz energy"
  extends Modelica.Icons.Function;
  algorithm
  f := state.h - state.p/state.d - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;


redeclare function extends specificEntropy "specific entropy of sodium"
  algorithm
  if ph_explicit then
    s := 0;
  elseif pT_explicit then
    s := 0;
  else
    s := 0;
  end if;
  end specificEntropy;


redeclare function extends specificHeatCapacityCp
  "specific heat capacity at constant pressure of sodium"
  algorithm
  if ph_explicit then
    // cp := 1275.3;
    // cp := 1.2451 + 4.1532e-5*state.T "linear temperature dependence";
    cp := 1.434665477080000e+03 + (-5.797211904000000e-01)*state.T +
      4.620643060000000e-04*state.T^2;
  elseif pT_explicit then
    // cp := 1275.3;
    cp := 1.434665477080000e+03 + (-5.797211904000000e-01)*state.T +
      4.620643060000000e-04*state.T^2;
  else
    // cp := 1275.3;
    cp := 1.434665477080000e+03 + (-5.797211904000000e-01)*state.T +
      4.620643060000000e-04*state.T^2;
  end if
    "specific heat capacity is considered constant throughout the entire operating regime (Sacit, May 16)";
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "specific heat capacity at constant volume of sodium"
  algorithm
  if ph_explicit then
    cv := 1253.1;
    // cv := 1.2531e3 - 2.8250e-1*state.T "linear temperature dependence";
  elseif pT_explicit then
    cv := 1253.1;
    // cv := 1.2531e3 - 2.8250e-1*state.T "linear temperature dependence";
  else
    cv := 1253.1;
    // cv := 1.2531e3 - 2.8250e-1*state.T "linear temperature dependence";
  end if;
  end specificHeatCapacityCv;


redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
  if ph_explicit then
    gamma := 1.333;
  elseif pT_explicit then
    gamma := 1.333;
  else
    gamma := 1.333;
  end if "gamma = 1.333 comes from water at room temperature (Sacit: Feb 9)";
  end isentropicExponent;


redeclare function extends isothermalCompressibility
  "Isothermal compressibility of sodium"
  algorithm
  if ph_explicit then
    kappa := 4.6e-10;
  elseif pT_explicit then
    kappa := 4.6e-10;
  else
    kappa := 4.6e-10;
  end if;
  end isothermalCompressibility;


redeclare function extends isobaricExpansionCoefficient
  "isobaric expansion coefficient of sodium"
  algorithm
  if ph_explicit then
    beta := 0.239/(1017 - 0.239*state.T);
  elseif pT_explicit then
    beta := 0.239/(1017 - 0.239*state.T);
  else
    beta := 0.239/(1017 - 0.239*state.T);
  end if;
  end isobaricExpansionCoefficient;


redeclare function extends velocityOfSound
  "Return velocity of sound as a function of the thermodynamic state record"
  algorithm
  if ph_explicit then
    a := +Modelica.Constants.inf;
  elseif pT_explicit then
    a := +Modelica.Constants.inf;
  else
    a := +Modelica.Constants.inf;
  end if "velocity of sound in water at 20 deg C is used (Sacit: Feb. 9)";
  end velocityOfSound;


redeclare function extends isentropicEnthalpy "compute h(p,s)"
  algorithm
  h_is := 28.8858e3 + 1275.3*(400 + 273.15)
    "temporarily used enthalpy at 675 deg C (Sacit: Feb. 9)";
  end isentropicEnthalpy;


redeclare function extends density_derh_p
  "density derivative by specific enthalpy"
  algorithm
  ddhp := -0.239/1275.3;
  end density_derh_p;


redeclare function extends density_derp_h "density derivative by pressure"
  algorithm
  ddph := 0;
  end density_derp_h;


redeclare function extends bubbleEnthalpy
  "boiling curve specific enthalpy of sodium"
  algorithm
  hl := 1e7;
  end bubbleEnthalpy;


redeclare function extends dewEnthalpy "dew curve specific enthalpy of sodium"
  algorithm
  hv := 1e8;
  end dewEnthalpy;


redeclare function extends bubbleEntropy
  "boiling curve specific entropy of sodium"
  algorithm
  sl := 1e3;
  end bubbleEntropy;


redeclare function extends dewEntropy "dew curve specific entropy of sodium"
  algorithm
  sv := 1e4;
  end dewEntropy;


redeclare function extends bubbleDensity
  "boiling curve specific density of sodium"
  algorithm
  if ph_explicit or pT_explicit then
    dl := 1017.0;
  else
    dl := 1017.0;
  end if;
  end bubbleDensity;


redeclare function extends dewDensity "dew curve specific density of sodium"
  algorithm
  if ph_explicit or pT_explicit then
    dv := 1000;
  else
    dv := 1000;
  end if;
  end dewDensity;


redeclare function extends saturationTemperature
  "saturation temperature of sodium"
  algorithm
  T := 1156;
  end saturationTemperature;


redeclare function extends saturationTemperature_derp
  "derivative of saturation temperature w.r.t. pressure"
  algorithm
  dTp := 0;
  end saturationTemperature_derp;


redeclare function extends saturationPressure "saturation pressure of sodium"
  algorithm
  p := 101325;
  end saturationPressure;


redeclare function extends dBubbleDensity_dPressure
  "bubble point density derivative"
  algorithm
  ddldp := 1e-6;
  end dBubbleDensity_dPressure;


redeclare function extends dDewDensity_dPressure "dew point density derivative"
  algorithm
  ddvdp := 1e-6;
  end dDewDensity_dPressure;


redeclare function extends dBubbleEnthalpy_dPressure
  "bubble point specific enthalpy derivative"
  algorithm
  dhldp := 1e-6;
  end dBubbleEnthalpy_dPressure;


redeclare function extends dDewEnthalpy_dPressure
  "dew point specific enthalpy derivative"
  algorithm
  dhvdp := 1e-6;
  end dDewEnthalpy_dPressure;


redeclare function extends setState_dTX
  "Return thermodynamic state of sodium as function of d and T"
  algorithm
  state := ThermodynamicState(
      d=d,
      T=T,
      phase=0,
      h=specificEnthalpy_dT(d, T),
      p=pressure_dT(d, T));
  end setState_dTX;


redeclare function extends setState_phX
  "Return thermodynamic state of sodium as function of p and h"
  algorithm
  state := ThermodynamicState(
      d=density_ph(p, h),
      T=temperature_ph(p, h),
      phase=0,
      h=h,
      p=p);
  end setState_phX;


redeclare function extends setState_psX
  "Return thermodynamic state of sodium as function of p and s"
  algorithm
  state := ThermodynamicState(
      d=density_ps(p, s),
      T=temperature_ps(p, s),
      phase=0,
      h=specificEnthalpy_ps(p, s),
      p=p);
  end setState_psX;


redeclare function extends setState_pTX
  "Return thermodynamic state of sodium as function of p and T"
  algorithm
  state := ThermodynamicState(
      d=density_pT(p, T),
      T=T,
      phase=1,
      h=specificEnthalpy_pT(p, T),
      p=p);
  end setState_pTX;


redeclare function extends setSmoothState
  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  import Modelica.Media.Common.smoothStep;
  algorithm
  state := ThermodynamicState(
      p=smoothStep(
        x,
        state_a.p,
        state_b.p,
        x_small),
      h=smoothStep(
        x,
        state_a.h,
        state_b.h,
        x_small),
      d=density_ph(smoothStep(
        x,
        state_a.p,
        state_b.p,
        x_small), smoothStep(
        x,
        state_a.h,
        state_b.h,
        x_small)),
      T=temperature_ph(smoothStep(
        x,
        state_a.p,
        state_b.p,
        x_small), smoothStep(
        x,
        state_a.h,
        state_b.h,
        x_small)),
      phase=0);
  end setSmoothState;


annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics={Text(
        extent={{-94,84},{94,40}},
        lineColor={127,191,255},
        textString="Na"),Text(
        extent={{-94,20},{94,-24}},
        lineColor={127,191,255},
        textString="sodium")}), Documentation(info=""));
end Na;
