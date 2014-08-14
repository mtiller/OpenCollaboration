within ORNL_AdvSMR.Media.Fluids.KFZrF4;
partial package KFZrF4_base "KF-ZrF4 Eutectic (58-42) base properties class"


extends Interfaces.PartialSinglePhaseMedium(
  mediumName="KFZrF4",
  substanceNames={"KFZrF4"},
  singleState=true,
  SpecificEnthalpy(start=6.97e5, nominal=8.125e5),
  Density(start=3070, nominal=3070),
  AbsolutePressure(start=1.802e6, nominal=1.802e6),
  Temperature(start=663.15, nominal=773.15),
  smoothModel=true,
  onePhase=true,
  fluidConstants=ORNL_AdvSMR.Media.Fluids.KFZrF4.zrkfConstants);


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
  "Base properties of water"

  Integer phase(
    min=0,
    max=2,
    start=1,
    fixed=true) "2 for two-phase, 1 for one-phase, 0 if not known";
  SaturationProperties sat(Tsat(start=1705), psat(start=1.01325e5))
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
protected
  Temperature T "Absolute temperature (K)";
  final AbsolutePressure p0=2.145e-5 "Triple-point pressure (Pa)";
  algorithm
  /* T := temperature_ph(
            p,
            h,
            1); */
  // d := (3658.28 - 0.887*T)*(1 + 2.3e-11*exp(0.001*T)*(p - p0));
  d := (3658.28 - 0.887*h/1051)*(1 + 2.3e-11*exp(0.001*h/1051)*(p - p0));
  // rho = rho_T * [ 1 + kappa * (p - p0) ]
  // kappa = 2.3e-11 * exp(0.001 T)    (kappa: isothermal compressibility)
  // Cetiner, Feb. 6, 2013

  // d := (3658.28 - 0.887*h/1051);
  // Pressure-independent density correlation (isothermal compressibilty term eliminated)
  // Cetiner, Feb. 18, 2013
  // d := 3000;
  // Constant density expression for evaluating DAE index reduction...
  end density_ph;


redeclare function density_pT
  "Computes density as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
protected
  final AbsolutePressure p0=2.145e-5 "Triple-point pressure (Pa)";
  algorithm
  d := (3658.28 - 0.887*T)*(1 + 2.3e-11*exp(0.001*T)*(p - p0))
    "T in [800-1080 K]";
  end density_pT;


redeclare function density_ps
  "Computes density as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "density";
  algorithm
  d := 3070.079836555651;
  // Updated: Cetiner, Feb. 6, 2013
  end density_ps;


redeclare function temperature_ph
  "Computes temperature as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
protected
  ThermodynamicState state "Thermodynamic state";
  SpecificHeatCapacity cp "Specific heat capacity of the fluid";
  algorithm
  state.h := h;
  state.p := p;
  // state.d := density_ph(p, h);
  // cp := ORNL_AdvSMR.Media.Fluids.KFZrF4.KFZrF4_ph.specificHeatCapacityCp(state);
  T := h/1051;
  // Specific heat capacity was assumed constant (Updated: Cetiner, Feb. 6, 2013)
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
  h := 1051*T;
  end specificEnthalpy_dT;


redeclare function specificEnthalpy_pT
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 1051*T;
  end specificEnthalpy_pT;


redeclare function specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 1051*(675 + 273.15)
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


redeclare function extends dynamicViscosity "Dynamic viscosity"
  algorithm
  eta := 1.59e-5*exp(3179/state.T)
    "dynamic viscosity; only as a function of temperature (K)";
  end dynamicViscosity;


redeclare function extends thermalConductivity "Thermal conductivity of flibe"
  algorithm
  // Thermal conductivity correlation needs to be updated for KF-ZrF4 (Sacit - April 3)
  lambda := 0.32 "Thermal conductivity (W/m K)";
  // Updated: Cetiner Feb 6, 2013.
  end thermalConductivity;


redeclare function extends surfaceTension
  "Surface tension of flibe; only a function of temperature"
  algorithm
  sigma := 0.182 - 7.134e-5*sat.Tsat
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


redeclare function extends specificEntropy "specific entropy of flibe"
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
  "specific heat capacity at constant pressure of flibe"
  algorithm
  cp := 1051
    "specific heat capacity is considered constant throughout the entire operating regime (Sacit Feb. 9)";
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "specific heat capacity at constant volume of flibe"
  algorithm
  cv := 1051 "specific heat capacity cv is considered equal to cv...";
  // cv = cp (Cetiner: updated Feb. 6, 2013).
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
  "Isothermal compressibility of flibe"
  algorithm
  if ph_explicit then
    kappa := 2.3e-11*exp(0.001*state.T);
  elseif pT_explicit then
    kappa := 2.3e-11*exp(0.001*state.T);
  else
    kappa := 2.3e-11*exp(0.001*state.T);
  end if;
  // Isothermal compressibility of flibe was used as per N. A. Anderson, Nuclear Technology v. 178, p. 335. Cetiner: Updated Feb. 6, 2013
  end isothermalCompressibility;


redeclare function extends isobaricExpansionCoefficient
  "isobaric expansion coefficient of flibe"
  algorithm
  if ph_explicit then
    beta := 1/(3851.18 - (state.T - 273.15));
  elseif pT_explicit then
    beta := 1/(3851.18 - (state.T - 273.15));
  else
    beta := 1/(3851.18 - (state.T - 273.15));
  end if;
  // Isobaric expansion coefficient of flibe was used as per N. A. Anderson, Nuclear Technology v. 178, p. 335. Cetiner: Updated Feb. 6, 2013
  end isobaricExpansionCoefficient;


redeclare function extends velocityOfSound
  "Return velocity of sound as a function of the thermodynamic state record"
  algorithm
  // a := 2500;
  // Constant speed of sound within the operating temperature range
  a := 1/sqrt(2.3e-11*exp(0.001*T)*(3658.28 - 0.887*T));
  // Temperature-dependent speed of sound
  // Velocity of sound in liquid salt was made artificially large to reduce compressibility effect.
  // Cetiner: Update Feb. 6, 2013
  end velocityOfSound;


redeclare function extends isentropicEnthalpy "compute h(p,s)"
  algorithm
  h_is := specificHeatCapacityCp(refState)*(700 + 273.15)
    "temporarily used enthalpy at 675 deg C (Sacit: Feb. 9)";
  end isentropicEnthalpy;


redeclare function extends density_derh_p
  "derivative of density with respect to specific enthalpy at constant pressure"
protected
  final AbsolutePressure p0=2.145e-5 "Triple point pressure of KF-ZrF4 (Pa)";
  algorithm
  ddhp := 1/1051*(-0.887*(1 + 2.3e-11*exp(0.001*state.T)*(state.p - p0)) + (
    3658.28 - 0.887*state.T)*2.3e-14*exp(0.001*state.T)*(state.p - p0));
  // Cetiner: Updated on Feb. 7, 2013
  end density_derh_p;


redeclare function extends density_derp_h
  "derivative of density with respect to pressure at constant specific enthalpy"
  algorithm
  ddph := (3658.28 - 0.887*state.T)*2.3e-11*exp(0.001*state.T);
  end density_derp_h;


redeclare function extends bubbleEnthalpy
  "boiling curve specific enthalpy of saturated liquid salt"
  algorithm
  //   hl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
  hl := 1.52e6;
  end bubbleEnthalpy;


redeclare function extends dewEnthalpy
  "dew curve specific enthalpy of saturated salt gas"
  algorithm
  // hv := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
  hv := 1e8;
  end dewEnthalpy;


redeclare function extends bubbleEntropy
  "boiling curve specific entropy of water"
  algorithm
  //  sl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
  sl := 1e3;
  end bubbleEntropy;


redeclare function extends dewEntropy "dew curve specific entropy of water"
  algorithm
  //  sv := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
  sv := 1e4;
  end dewEntropy;


redeclare function extends bubbleDensity "boiling curve density of KF-ZrF4"
  algorithm
  if ph_explicit or pT_explicit then
    //    dl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat);
    dl := 3070;
  else
    //    dl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
    dl := 3070;
  end if;
  end bubbleDensity;


redeclare function extends dewDensity "dew curve specific density of water"
  algorithm
  if ph_explicit or pT_explicit then
    //    dv := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat);
    dv := 1000;
  else
    //    dv := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
    dv := 1000;
  end if;
  end dewDensity;


redeclare function extends saturationTemperature
  "saturation temperature of water"
protected
  final Real Asat=9.04 "saturation constant";
  final Real Bsat=10500 "saturation constant";
  algorithm
  T := Bsat/(Asat - log10(p/133.32));
  // Correlation from N. A. Anderson, Nuclear Technology v. 178, p. 335, Eq. 21.
  // Update: Cetiner on Feb. 7, 2013.
  end saturationTemperature;


redeclare function extends saturationTemperature_derp
  "derivative of saturation temperature with respect to pressure"
protected
  final Real Asat=9.04 "saturation constant";
  final Real Bsat=10500 "saturation constant";
  algorithm
  dTp := 1/log(10)*Bsat/(p*(Asat - log10(p/133.32))^2);
  // Correlation from N. A. Anderson, Nuclear Technology v. 178, p. 335, Eq. 21.
  // Update: Cetiner on Feb. 7, 2013.
  end saturationTemperature_derp;


redeclare function extends saturationPressure "saturation pressure of water"
protected
  final Real Asat=9.04 "saturation constant";
  final Real Bsat=10500 "saturation constant";
  algorithm
  p := 133.32*10^(Asat - Bsat/T);
  // Correlation from N. A. Anderson, Nuclear Technology v. 178, p. 335, Eq. 21.
  // Update: Cetiner on Feb. 7, 2013.
  end saturationPressure;


redeclare function extends dBubbleDensity_dPressure
  "bubble point density derivative"
  algorithm
  //  ddldp := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
  ddldp := 1e-6;
  end dBubbleDensity_dPressure;


redeclare function extends dDewDensity_dPressure "dew point density derivative"
  algorithm
  //  ddvdp := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
  ddvdp := 1e-6;
  end dDewDensity_dPressure;


redeclare function extends dBubbleEnthalpy_dPressure
  "bubble point specific enthalpy derivative"
  algorithm
  //  dhldp := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
  dhldp := 1e-6;
  end dBubbleEnthalpy_dPressure;


redeclare function extends dDewEnthalpy_dPressure
  "dew point specific enthalpy derivative"
  algorithm
  //  dhvdp := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
  dhvdp := 1e-6;
  end dDewEnthalpy_dPressure;


redeclare function extends setState_dTX
  "Return thermodynamic state of water as function of d and T"
  algorithm
  state := ThermodynamicState(
      d=d,
      T=T,
      phase=0,
      h=specificEnthalpy_dT(d, T),
      p=pressure_dT(d, T));
  end setState_dTX;


redeclare function extends setState_phX
  "Return thermodynamic state of water as function of p and h"
  algorithm
  state := ThermodynamicState(
      d=density_ph(p, h),
      T=temperature_ph(p, h),
      phase=0,
      h=h,
      p=p);
  end setState_phX;


redeclare function extends setState_psX
  "Return thermodynamic state of water as function of p and s"
  algorithm
  state := ThermodynamicState(
      d=density_ps(p, s),
      T=temperature_ps(p, s),
      phase=0,
      h=specificEnthalpy_ps(p, s),
      p=p);
  end setState_psX;


redeclare function extends setState_pTX
  "Return thermodynamic state of water as function of p and T"
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
        textString="IF97"),Text(
        extent={{-94,20},{94,-24}},
        lineColor={127,191,255},
        textString="water")}), Documentation(info="<HTML>
<p>
This model calculates medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"modelica://Modelica.Media.Water.IF97_Utilities\">
Modelica.Media.Water.IF97_Utilities</a>. Three variable pairs can be the
independent variables of the model:
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are the most natural choice for general applications. This is the recommended choice for most general purpose applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural choice for applications where water is always in the same phase, both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit variables of the Helmholtz function in the near-critical region and can be the best choice for applications with super-critical or near-critial states.</li>
</ol>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.</p>
</HTML>
"));
end KFZrF4_base;
