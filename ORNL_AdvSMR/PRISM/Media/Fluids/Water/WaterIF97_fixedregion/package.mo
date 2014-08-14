within ORNL_AdvSMR.PRISM.Media.Fluids.Water;
partial package WaterIF97_fixedregion "Water: Steam properties as defined by IAPWS/IF97 standard"


extends Interfaces.PartialTwoPhaseMedium(
  mediumName="WaterIF97",
  substanceNames={"water"},
  singleState=false,
  SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
  Density(start=150, nominal=500),
  AbsolutePressure(start=50e5, nominal=10e5),
  Temperature(start=500, nominal=500),
  smoothModel=false,
  onePhase=false,
  fluidConstants=waterConstants);


redeclare record extends ThermodynamicState "thermodynamic state"
  SpecificEnthalpy h "specific enthalpy";
  Density d "density";
  Temperature T "temperature";
  AbsolutePressure p "pressure";
  end ThermodynamicState;

constant Integer Region "region of IF97, if known";
constant Boolean ph_explicit
  "true if explicit in pressure and specific enthalpy";
constant Boolean dT_explicit "true if explicit in density and temperature";
constant Boolean pT_explicit "true if explicit in pressure and temperature";


redeclare replaceable model extends BaseProperties(
  h(stateSelect=if ph_explicit then StateSelect.prefer else StateSelect.default),

  d(stateSelect=if dT_explicit then StateSelect.prefer else StateSelect.default),

  T(stateSelect=if (pT_explicit or dT_explicit) then StateSelect.prefer else
        StateSelect.default),
  p(stateSelect=if (pT_explicit or ph_explicit) then StateSelect.prefer else
        StateSelect.default)) "Base properties of water"

  Integer phase(min=0, max=2)
    "2 for two-phase, 1 for one-phase, 0 if not known";
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
          "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!");
      else
        assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
          fluidConstants[1].criticalTemperature),
          "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!");
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
        phase,
        Region);
    h = specificEnthalpy_dT(
        d,
        T,
        phase,
        Region);
    sat.Tsat = T;
    sat.psat = saturationPressure(T);
  elseif ph_explicit then
    d = density_ph(
        p,
        h,
        phase,
        Region);
    T = temperature_ph(
        p,
        h,
        phase,
        Region);
    sat.Tsat = saturationTemperature(p);
    sat.psat = p;
  else
    h = specificEnthalpy_pT(
        p,
        T,
        Region);
    d = density_pT(
        p,
        T,
        Region);
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
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Density d "Density";
  algorithm
  d := IF97_Utilities.rho_ph(
      p,
      h,
      phase,
      region);
  end density_ph;


redeclare function temperature_ph
  "Computes temperature as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Temperature T "Temperature";
  algorithm
  T := IF97_Utilities.T_ph(
      p,
      h,
      phase,
      region);
  end temperature_ph;


redeclare function temperature_ps
  "Compute temperature from pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Temperature T "Temperature";
  algorithm
  T := IF97_Utilities.T_ps(
      p,
      s,
      phase,
      region);
  end temperature_ps;


redeclare function density_ps
  "Computes density as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Density d "density";
  algorithm
  d := IF97_Utilities.rho_ps(
      p,
      s,
      phase,
      region);
  end density_ps;


redeclare function pressure_dT
  "Computes pressure as a function of density and temperature"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output AbsolutePressure p "Pressure";
  algorithm
  p := IF97_Utilities.p_dT(
      d,
      T,
      phase,
      region);
  end pressure_dT;


redeclare function specificEnthalpy_dT
  "Computes specific enthalpy as a function of density and temperature"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := IF97_Utilities.h_dT(
      d,
      T,
      phase,
      region);
  end specificEnthalpy_dT;


redeclare function specificEnthalpy_pT
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := IF97_Utilities.h_pT(
      p,
      T,
      region);
  end specificEnthalpy_pT;


redeclare function specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := IF97_Utilities.h_ps(
      p,
      s,
      phase,
      region);
  end specificEnthalpy_ps;


redeclare function density_pT
  "Computes density as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  output Density d "Density";
  algorithm
  d := IF97_Utilities.rho_pT(
      p,
      T,
      region);
  end density_pT;


redeclare function extends setDewState
  "set the thermodynamic state on the dew line"
  algorithm
  state.phase := phase;
  state.p := sat.psat;
  state.T := sat.Tsat;
  state.h := dewEnthalpy(sat);
  state.d := dewDensity(sat);
  end setDewState;


redeclare function extends setBubbleState
  "set the thermodynamic state on the bubble line"
  algorithm
  state.phase := phase;
  state.p := sat.psat;
  state.T := sat.Tsat;
  state.h := bubbleEnthalpy(sat);
  state.d := bubbleDensity(sat);
  end setBubbleState;


redeclare function extends dynamicViscosity "Dynamic viscosity of water"
  algorithm
  eta := IF97_Utilities.dynamicViscosity(
      state.d,
      state.T,
      state.p,
      state.phase);
  end dynamicViscosity;


redeclare function extends thermalConductivity "Thermal conductivity of water"
  algorithm
  lambda := IF97_Utilities.thermalConductivity(
      state.d,
      state.T,
      state.p,
      state.phase);
  end thermalConductivity;


redeclare function extends surfaceTension
  "Surface tension in two phase region of water"
  algorithm
  sigma := IF97_Utilities.surfaceTension(sat.Tsat);
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


redeclare function extends specificEntropy "specific entropy of water"
  algorithm
  if dT_explicit then
    s := IF97_Utilities.s_dT(
        state.d,
        state.T,
        state.phase,
        Region);
  elseif pT_explicit then
    s := IF97_Utilities.s_pT(
        state.p,
        state.T,
        Region);
  else
    s := IF97_Utilities.s_ph(
        state.p,
        state.h,
        state.phase,
        Region);
  end if;
  end specificEntropy;


redeclare function extends specificHeatCapacityCp
  "specific heat capacity at constant pressure of water"
  algorithm
  if dT_explicit then
    cp := IF97_Utilities.cp_dT(
        state.d,
        state.T,
        Region);
  elseif pT_explicit then
    cp := IF97_Utilities.cp_pT(
        state.p,
        state.T,
        Region);
  else
    cp := IF97_Utilities.cp_ph(
        state.p,
        state.h,
        Region);
  end if;
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "specific heat capacity at constant volume of water"
  algorithm
  if dT_explicit then
    cv := IF97_Utilities.cv_dT(
        state.d,
        state.T,
        state.phase,
        Region);
  elseif pT_explicit then
    cv := IF97_Utilities.cv_pT(
        state.p,
        state.T,
        Region);
  else
    cv := IF97_Utilities.cv_ph(
        state.p,
        state.h,
        state.phase,
        Region);
  end if;
  end specificHeatCapacityCv;


redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
  if dT_explicit then
    gamma := IF97_Utilities.isentropicExponent_dT(
        state.d,
        state.T,
        state.phase,
        Region);
  elseif pT_explicit then
    gamma := IF97_Utilities.isentropicExponent_pT(
        state.p,
        state.T,
        Region);
  else
    gamma := IF97_Utilities.isentropicExponent_ph(
        state.p,
        state.h,
        state.phase,
        Region);
  end if;
  end isentropicExponent;


redeclare function extends isothermalCompressibility
  "Isothermal compressibility of water"
  algorithm
  //    assert(state.phase <> 2, "isothermal compressibility can not be computed with 2-phase inputs!");
  if dT_explicit then
    kappa := IF97_Utilities.kappa_dT(
        state.d,
        state.T,
        state.phase,
        Region);
  elseif pT_explicit then
    kappa := IF97_Utilities.kappa_pT(
        state.p,
        state.T,
        Region);
  else
    kappa := IF97_Utilities.kappa_ph(
        state.p,
        state.h,
        state.phase,
        Region);
  end if;
  end isothermalCompressibility;


redeclare function extends isobaricExpansionCoefficient
  "isobaric expansion coefficient of water"
  algorithm
  //    assert(state.phase <> 2, "the isobaric expansion coefficient can not be computed with 2-phase inputs!");
  if dT_explicit then
    beta := IF97_Utilities.beta_dT(
        state.d,
        state.T,
        state.phase,
        Region);
  elseif pT_explicit then
    beta := IF97_Utilities.beta_pT(
        state.p,
        state.T,
        Region);
  else
    beta := IF97_Utilities.beta_ph(
        state.p,
        state.h,
        state.phase,
        Region);
  end if;
  end isobaricExpansionCoefficient;


redeclare function extends velocityOfSound
  "Return velocity of sound as a function of the thermodynamic state record"
  algorithm
  if dT_explicit then
    a := IF97_Utilities.velocityOfSound_dT(
        state.d,
        state.T,
        state.phase,
        Region);
  elseif pT_explicit then
    a := IF97_Utilities.velocityOfSound_pT(
        state.p,
        state.T,
        Region);
  else
    a := IF97_Utilities.velocityOfSound_ph(
        state.p,
        state.h,
        state.phase,
        Region);
  end if;
  end velocityOfSound;


redeclare function extends isentropicEnthalpy "compute h(s,p)"
  algorithm
  h_is := IF97_Utilities.isentropicEnthalpy(
      p_downstream,
      specificEntropy(refState),
      0);
  end isentropicEnthalpy;


redeclare function extends density_derh_p
  "density derivative by specific enthalpy"
  algorithm
  ddhp := IF97_Utilities.ddhp(
      state.p,
      state.h,
      state.phase,
      Region);
  end density_derh_p;


redeclare function extends density_derp_h "density derivative by pressure"
  algorithm
  ddph := IF97_Utilities.ddph(
      state.p,
      state.h,
      state.phase,
      Region);
  end density_derp_h;


redeclare function extends bubbleEnthalpy
  "boiling curve specific enthalpy of water"
  algorithm
  hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
  end bubbleEnthalpy;


redeclare function extends dewEnthalpy "dew curve specific enthalpy of water"
  algorithm
  hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
  end dewEnthalpy;


redeclare function extends bubbleEntropy
  "boiling curve specific entropy of water"
  algorithm
  sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
  end bubbleEntropy;


redeclare function extends dewEntropy "dew curve specific entropy of water"
  algorithm
  sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
  end dewEntropy;


redeclare function extends bubbleDensity
  "boiling curve specific density of water"
  algorithm
  if ph_explicit or pT_explicit then
    dl := IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat);
  else
    dl := IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
  end if;
  end bubbleDensity;


redeclare function extends dewDensity "dew curve specific density of water"
  algorithm
  if ph_explicit or pT_explicit then
    dv := IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat);
  else
    dv := IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
  end if;
  end dewDensity;


redeclare function extends saturationTemperature
  "saturation temperature of water"
  algorithm
  T := IF97_Utilities.BaseIF97.Basic.tsat(p);
  end saturationTemperature;


redeclare function extends saturationTemperature_derp
  "derivative of saturation temperature w.r.t. pressure"
  algorithm
  dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
  end saturationTemperature_derp;


redeclare function extends saturationPressure "saturation pressure of water"
  algorithm
  p := IF97_Utilities.BaseIF97.Basic.psat(T);
  end saturationPressure;


redeclare function extends dBubbleDensity_dPressure
  "bubble point density derivative"
  algorithm
  ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
  end dBubbleDensity_dPressure;


redeclare function extends dDewDensity_dPressure "dew point density derivative"
  algorithm
  ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
  end dDewDensity_dPressure;


redeclare function extends dBubbleEnthalpy_dPressure
  "bubble point specific enthalpy derivative"
  algorithm
  dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
  end dBubbleEnthalpy_dPressure;


redeclare function extends dDewEnthalpy_dPressure
  "dew point specific enthalpy derivative"
  algorithm
  dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
  end dDewEnthalpy_dPressure;


redeclare function extends setState_dTX
  "Return thermodynamic state of water as function of d, T, and optional region"
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  algorithm
  state := ThermodynamicState(
      d=d,
      T=T,
      phase=if region == 0 then IF97_Utilities.phase_dT(d, T) else if region
       == 4 then 2 else 1,
      h=specificEnthalpy_dT(
        d,
        T,
        region=region),
      p=pressure_dT(
        d,
        T,
        region=region));
  end setState_dTX;


redeclare function extends setState_phX
  "Return thermodynamic state of water as function of p, h, and optional region"
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  algorithm
  state := ThermodynamicState(
      d=density_ph(
        p,
        h,
        region=region),
      T=temperature_ph(
        p,
        h,
        region=region),
      phase=if region == 0 then IF97_Utilities.phase_ph(p, h) else if region
       == 4 then 2 else 1,
      h=h,
      p=p);
  end setState_phX;


redeclare function extends setState_psX
  "Return thermodynamic state of water as function of p, s, and optional region"
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  algorithm
  state := ThermodynamicState(
      d=density_ps(
        p,
        s,
        region=region),
      T=temperature_ps(
        p,
        s,
        region=region),
      phase=IF97_Utilities.phase_ps(p, s),
      h=specificEnthalpy_ps(
        p,
        s,
        region=region),
      p=p);
  end setState_psX;


redeclare function extends setState_pTX
  "Return thermodynamic state of water as function of p, T, and optional region"
  input Integer region=0
    "if 0, region is unknown, otherwise known and this input";
  algorithm
  state := ThermodynamicState(
      d=density_pT(
        p,
        T,
        region=region),
      T=T,
      phase=1,
      h=specificEnthalpy_pT(
        p,
        T,
        region=region),
      p=p);
  end setState_pTX;


redeclare function extends setSmoothState
  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  import ORNL_AdvSMR.PRISM.Media.Common.smoothStep;
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
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
</HTML>
"));
end WaterIF97_fixedregion;
