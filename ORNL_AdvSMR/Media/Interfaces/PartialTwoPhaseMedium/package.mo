within ORNL_AdvSMR.Media.Interfaces;
partial package PartialTwoPhaseMedium "Base class for two phase medium of one substance"
extends PartialPureSubstance;

constant Boolean smoothModel
  "true if the (derived) model should not generate state events";
constant Boolean onePhase
  "true if the (derived) model should never be called with two-phase inputs";


redeclare replaceable record extends FluidConstants "extended fluid constants"
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

constant FluidConstants[nS] fluidConstants "constant data for the fluid";


redeclare replaceable record extends ThermodynamicState
  "Thermodynamic state of two phase medium"
  FixedPhase phase(min=0, max=2)
    "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
  end ThermodynamicState;


replaceable record SaturationProperties
  "Saturation properties of two phase medium"
  extends Modelica.Icons.Record;
  AbsolutePressure psat "saturation pressure";
  Temperature Tsat "saturation temperature";
  end SaturationProperties;


redeclare replaceable partial model extends BaseProperties
  "Base properties (p, d, T, h, u, R, MM, sat) of two phase medium"
  SaturationProperties sat "Saturation properties at the medium pressure";
  end BaseProperties;


replaceable partial function setDewState
  "Return the thermodynamic state on the dew line"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation point";
  input FixedPhase phase(
    min=1,
    max=2) = 1 "phase: default is one phase";
  output ThermodynamicState state "complete thermodynamic state info";
  end setDewState;


replaceable partial function setBubbleState
  "Return the thermodynamic state on the bubble line"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation point";
  input FixedPhase phase(
    min=1,
    max=2) = 1 "phase: default is one phase";
  output ThermodynamicState state "complete thermodynamic state info";
  end setBubbleState;


redeclare replaceable partial function extends setState_dTX
  "Return thermodynamic state as function of d, T and composition X or Xi"
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_dTX;


redeclare replaceable partial function extends setState_phX
  "Return thermodynamic state as function of p, h and composition X or Xi"
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_phX;


redeclare replaceable partial function extends setState_psX
  "Return thermodynamic state as function of p, s and composition X or Xi"
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_psX;


redeclare replaceable partial function extends setState_pTX
  "Return thermodynamic state as function of p, T and composition X or Xi"
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_pTX;


replaceable function setSat_T
  "Return saturation property record from temperature"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output SaturationProperties sat "saturation property record";
  algorithm
  sat.Tsat := T;
  sat.psat := saturationPressure(T);
  end setSat_T;


replaceable function setSat_p "Return saturation property record from pressure"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "pressure";
  output SaturationProperties sat "saturation property record";
  algorithm
  sat.psat := p;
  sat.Tsat := saturationTemperature(p);
  end setSat_p;


replaceable partial function bubbleEnthalpy
  "Return bubble point specific enthalpy"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output SI.SpecificEnthalpy hl "boiling curve specific enthalpy";
  end bubbleEnthalpy;


replaceable partial function dewEnthalpy "Return dew point specific enthalpy"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output SI.SpecificEnthalpy hv "dew curve specific enthalpy";
  end dewEnthalpy;


replaceable partial function bubbleEntropy
  "Return bubble point specific entropy"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output SI.SpecificEntropy sl "boiling curve specific entropy";
  end bubbleEntropy;


replaceable partial function dewEntropy "Return dew point specific entropy"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output SI.SpecificEntropy sv "dew curve specific entropy";
  end dewEntropy;


replaceable partial function bubbleDensity "Return bubble point density"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output Density dl "boiling curve density";
  end bubbleDensity;


replaceable partial function dewDensity "Return dew point density"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output Density dv "dew curve density";
  end dewDensity;


replaceable partial function saturationPressure "Return saturation pressure"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output AbsolutePressure p "saturation pressure";
  end saturationPressure;


replaceable partial function saturationTemperature
  "Return saturation temperature"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "pressure";
  output Temperature T "saturation temperature";
  end saturationTemperature;


replaceable function saturationPressure_sat "Return saturation temperature"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output AbsolutePressure p "saturation pressure";
  algorithm
  p := sat.psat;
  end saturationPressure_sat;


replaceable function saturationTemperature_sat "Return saturation temperature"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output Temperature T "saturation temperature";
  algorithm
  T := sat.Tsat;
  end saturationTemperature_sat;


replaceable partial function saturationTemperature_derp
  "Return derivative of saturation temperature w.r.t. pressure"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "pressure";
  output Real dTp "derivative of saturation temperature w.r.t. pressure";
  end saturationTemperature_derp;


replaceable function saturationTemperature_derp_sat
  "Return derivative of saturation temperature w.r.t. pressure"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output Real dTp "derivative of saturation temperature w.r.t. pressure";
  algorithm
  dTp := saturationTemperature_derp(sat.psat);
  end saturationTemperature_derp_sat;


replaceable partial function surfaceTension
  "Return surface tension sigma in the two phase region"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output SurfaceTension sigma "Surface tension sigma in the two phase region";
  end surfaceTension;


redeclare replaceable partial function extends molarMass
  "Return the molar mass of the medium"
  algorithm
  MM := fluidConstants[1].molarMass;
  end molarMass;


replaceable partial function dBubbleDensity_dPressure
  "Return bubble point density derivative"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output DerDensityByPressure ddldp "boiling curve density derivative";
  end dBubbleDensity_dPressure;


replaceable partial function dDewDensity_dPressure
  "Return dew point density derivative"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output DerDensityByPressure ddvdp "saturated steam density derivative";
  end dDewDensity_dPressure;


replaceable partial function dBubbleEnthalpy_dPressure
  "Return bubble point specific enthalpy derivative"
  extends Modelica.Icons.Function;
  input SaturationProperties sat "saturation property record";
  output DerEnthalpyByPressure dhldp
    "boiling curve specific enthalpy derivative";
  end dBubbleEnthalpy_dPressure;


replaceable partial function dDewEnthalpy_dPressure
  "Return dew point specific enthalpy derivative"
  extends Modelica.Icons.Function;

  input SaturationProperties sat "saturation property record";
  output DerEnthalpyByPressure dhvdp
    "saturated steam specific enthalpy derivative";
  end dDewEnthalpy_dPressure;


redeclare replaceable function specificEnthalpy_pTX
  "Return specific enthalpy from pressure, temperature and mass fraction"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "Specific enthalpy at p, T, X";
  algorithm
  h := specificEnthalpy(setState_pTX(
      p,
      T,
      X,
      phase));
  end specificEnthalpy_pTX;


redeclare replaceable function temperature_phX
  "Return temperature from p, h, and X or Xi"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := temperature(setState_phX(
      p,
      h,
      X,
      phase));
  end temperature_phX;


redeclare replaceable function density_phX
  "Return density from p, h, and X or Xi"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "density";
  algorithm
  d := density(setState_phX(
      p,
      h,
      X,
      phase));
  end density_phX;


redeclare replaceable function temperature_psX
  "Return temperature from p, s, and X or Xi"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := temperature(setState_psX(
      p,
      s,
      X,
      phase));
  end temperature_psX;


redeclare replaceable function density_psX
  "Return density from p, s, and X or Xi"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  d := density(setState_psX(
      p,
      s,
      X,
      phase));
  end density_psX;


redeclare replaceable function specificEnthalpy_psX
  "Return specific enthalpy from p, s, and X or Xi"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[nX] "Mass fractions";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := specificEnthalpy(setState_psX(
      p,
      s,
      X,
      phase));
  end specificEnthalpy_psX;


redeclare replaceable function setState_pT
  "Return thermodynamic state from p and T"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output ThermodynamicState state "thermodynamic state record";
  algorithm
  state := setState_pTX(
      p,
      T,
      fill(0, 0),
      phase);
  end setState_pT;


redeclare replaceable function setState_ph
  "Return thermodynamic state from p and h"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output ThermodynamicState state "thermodynamic state record";
  algorithm
  state := setState_phX(
      p,
      h,
      fill(0, 0),
      phase);
  end setState_ph;


redeclare replaceable function setState_ps
  "Return thermodynamic state from p and s"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output ThermodynamicState state "thermodynamic state record";
  algorithm
  state := setState_psX(
      p,
      s,
      fill(0, 0),
      phase);
  end setState_ps;


redeclare replaceable function setState_dT
  "Return thermodynamic state from d and T"
  extends Modelica.Icons.Function;
  input Density d "density";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output ThermodynamicState state "thermodynamic state record";
  algorithm
  state := setState_dTX(
      d,
      T,
      fill(0, 0),
      phase);
  end setState_dT;


replaceable function setState_px
  "Return thermodynamic state from pressure and vapour quality"
  input AbsolutePressure p "Pressure";
  input MassFraction x "Vapour quality";
  output ThermodynamicState state "Thermodynamic state record";
  algorithm
  state := setState_ph(
      p,
      (1 - x)*bubbleEnthalpy(setSat_p(p)) + x*dewEnthalpy(setSat_p(p)),
      2);
  end setState_px;


replaceable function setState_Tx
  "Return thermodynamic state from temperature and vapour quality"
  input Temperature T "Temperature";
  input MassFraction x "Vapour quality";
  output ThermodynamicState state "thermodynamic state record";
  algorithm
  state := setState_ph(
      saturationPressure_sat(setSat_T(T)),
      (1 - x)*bubbleEnthalpy(setSat_T(T)) + x*dewEnthalpy(setSat_T(T)),
      2);
  end setState_Tx;


replaceable function vapourQuality "Return vapour quality"
  input ThermodynamicState state "Thermodynamic state record";
  output MassFraction x "Vapour quality";
protected
  constant SpecificEnthalpy eps=1e-8;
  algorithm
  x := min(max((specificEnthalpy(state) - bubbleEnthalpy(setSat_p(pressure(
    state))))/(dewEnthalpy(setSat_p(pressure(state))) - bubbleEnthalpy(setSat_p(
    pressure(state))) + eps), 0), 1);
  end vapourQuality;


redeclare replaceable function density_ph "Return density from p and h"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  d := density_phX(
      p,
      h,
      fill(0, 0),
      phase);
  end density_ph;


redeclare replaceable function temperature_ph "Return temperature from p and h"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := temperature_phX(
      p,
      h,
      fill(0, 0),
      phase);
  end temperature_ph;


redeclare replaceable function pressure_dT "Return pressure from d and T"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output AbsolutePressure p "Pressure";
  algorithm
  p := pressure(setState_dTX(
      d,
      T,
      fill(0, 0),
      phase));
  end pressure_dT;


redeclare replaceable function specificEnthalpy_dT
  "Return specific enthalpy from d and T"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := specificEnthalpy(setState_dTX(
      d,
      T,
      fill(0, 0),
      phase));
  end specificEnthalpy_dT;


redeclare replaceable function specificEnthalpy_ps
  "Return specific enthalpy from p and s"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := specificEnthalpy_psX(
      p,
      s,
      fill(0, 0));
  end specificEnthalpy_ps;


redeclare replaceable function temperature_ps "Return temperature from p and s"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Temperature T "Temperature";
  algorithm
  T := temperature_psX(
      p,
      s,
      fill(0, 0),
      phase);
  end temperature_ps;


redeclare replaceable function density_ps "Return density from p and s"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  d := density_psX(
      p,
      s,
      fill(0, 0),
      phase);
  end density_ps;


redeclare replaceable function specificEnthalpy_pT
  "Return specific enthalpy from p and T"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output SpecificEnthalpy h "specific enthalpy";
  algorithm
  h := specificEnthalpy_pTX(
      p,
      T,
      fill(0, 0),
      phase);
  end specificEnthalpy_pT;


redeclare replaceable function density_pT "Return density from p and T"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Density d "Density";
  algorithm
  d := density(setState_pTX(
      p,
      T,
      fill(0, 0),
      phase));
  end density_pT;
end PartialTwoPhaseMedium;
