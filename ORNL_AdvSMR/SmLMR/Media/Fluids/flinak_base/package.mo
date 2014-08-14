within ORNL_AdvSMR.SmLMR.Media.Fluids;
partial package flinak_base "Flinak properties"


extends Interfaces.PartialSinglePhaseMedium(
  mediumName="flinak",
  substanceNames={"flinak"},
  singleState=false,
  SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
  Density(start=150, nominal=500),
  AbsolutePressure(start=50e5, nominal=10e5),
  Temperature(start=500, nominal=500),
  smoothModel=false,
  onePhase=true,
  fluidConstants=Modelica.Media.Water.waterConstants);


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
  d := (2413.3 - 0.4884*h/2380)*(1 + 5.9361e-11*p);
  end density_ph;


redeclare function temperature_ph
  "Computes temperature as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := h/2380;
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


redeclare function density_ps
  "Computes density as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "density";
  algorithm
  d := 1950.6;
  end density_ps;


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
  h := 2380*T;
  end specificEnthalpy_dT;


redeclare function specificEnthalpy_pT
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 2380*T;
  end specificEnthalpy_pT;


redeclare function specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := 2380*(675 + 273.15)
    "Constant pressure; entropy relations are not known... Enthalpy value at 675 deg C is generated.";
  end specificEnthalpy_ps;


redeclare function density_pT
  "Computes density as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=1 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  d := (2413.3 - 0.4884*T)*(1 + 5.9361e-11*p) "T in [800-1080 K]";
  end density_pT;


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


redeclare function extends dynamicViscosity "Dynamic viscosity of flibe"
  algorithm
  eta := 1.16e-4*exp(3755/state.T)
    "dynamic viscosity; only as a function of temperature (K)";
  end dynamicViscosity;


redeclare function extends thermalConductivity "Thermal conductivity of flibe"
  algorithm
  lambda := 0.0005*state.T + 32/33.0126 - 0.34
    "Ignatiev & Kholkov correlation; only a function of temperature (K) (Sacit Feb. 9)";
  end thermalConductivity;


redeclare function extends surfaceTension
  "Surface tension of flibe; only a function of temperature"
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
  if ph_explicit then
    cp := 2380;
  elseif pT_explicit then
    cp := 2380;
  else
    cp := 2380;
  end if
    "specific heat capacity is considered constant throughout the entire operating regime (Sacit Feb. 9)";
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "specific heat capacity at constant volume of flibe"
  algorithm
  if ph_explicit then
    cv := 2380/1.333;
  elseif pT_explicit then
    cv := 2380/1.333;
  else
    cv := 2380/1.333;
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
  "Isothermal compressibility of flibe"
  algorithm
  if ph_explicit then
    kappa := 4.6e-10;
  elseif pT_explicit then
    kappa := 4.6e-10;
  else
    kappa := 4.6e-10;
  end if
    "isothermal compressibility of water at 25 deg C is used (Sacit: Feb 9)";
  end isothermalCompressibility;


redeclare function extends isobaricExpansionCoefficient
  "isobaric expansion coefficient of flibe"
  algorithm
  if ph_explicit then
    beta := 0.4884/(2413.3 - 0.4884*state.h/2380) - (2.3e-14*(state.p -
      6.367e-4))/(1 + 2.3e-11*(state.p - 6.367e-4));
  elseif pT_explicit then
    beta := 0.4884/(2413.3 - 0.4884*state.T) - (2.3e-14*(state.p - 6.367e-4))/(
      1 + 2.3e-11*(state.p - 6.367e-4));
  else
    beta := 0.4884/(2413.3 - 0.4884*state.h/2380) - (2.3e-14*(state.p -
      6.367e-4))/(1 + 2.3e-11*(state.p - 6.367e-4));
  end if;
  end isobaricExpansionCoefficient;


redeclare function extends velocityOfSound
  "Return velocity of sound as a function of the thermodynamic state record"
  algorithm
  if ph_explicit then
    a := 1484;
  elseif pT_explicit then
    a := 1484;
  else
    a := 1484;
  end if "velocity of sound in water at 20 deg C is used (Sacit: Feb. 9)";
  end velocityOfSound;


redeclare function extends isentropicEnthalpy "compute h(p,s)"
  algorithm
  h_is := 2380*(675 + 273.15)
    "temporarily used enthalpy at 675 deg C (Sacit: Feb. 9)";
  end isentropicEnthalpy;


redeclare function extends density_derh_p
  "density derivative by specific enthalpy"
  algorithm
  //   ddhp := Modelica.Media.Water.IF97_Utilities.ddhp(
  //       state.p,
  //       state.h,
  //       state.phase);
  ddhp := -0.4884/2380*(1 + 5.9361e-11*state.p);
  end density_derh_p;


redeclare function extends density_derp_h "density derivative by pressure"
  algorithm
  //   ddph := Modelica.Media.Water.IF97_Utilities.ddph(
  //       state.p,
  //       state.h,
  //       state.phase);
  ddph := 5.9361e-11*(2413.3 - 0.4884*state.h/2380);
  end density_derp_h;


redeclare function extends bubbleEnthalpy
  "boiling curve specific enthalpy of water"
  algorithm
  //   hl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
  hl := 1e7;
  end bubbleEnthalpy;


redeclare function extends dewEnthalpy "dew curve specific enthalpy of water"
  algorithm
  //  hv := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
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


redeclare function extends bubbleDensity
  "boiling curve specific density of water"
  algorithm
  if ph_explicit or pT_explicit then
    //    dl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat);
    dl := 2279.7;
  else
    //    dl := Modelica.Media.Water.IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
    dl := 2279.7;
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
  algorithm
  //  T := Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.tsat(p);
  T := 1800;
  end saturationTemperature;


redeclare function extends saturationTemperature_derp
  "derivative of saturation temperature w.r.t. pressure"
  algorithm
  //  dTp := Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
  dTp := 1e-6;
  end saturationTemperature_derp;


redeclare function extends saturationPressure "saturation pressure of water"
  algorithm
  //  p := Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.psat(T);
  p := 101325;
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
end flinak_base;
