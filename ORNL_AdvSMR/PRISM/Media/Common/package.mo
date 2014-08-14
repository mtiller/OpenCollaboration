within ORNL_AdvSMR.PRISM.Media;
package Common "data structures and fundamental functions for fluid properties"


extends Modelica.Icons.Package;


protected 
type Rate = Real (final quantity="Rate", final unit="s-1");


type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");


type MolarReactionRate = Real (final quantity="MolarReactionRate", final unit=
        "mol/(m3.s)");


type MolarEnthalpy = Real (final quantity="MolarEnthalpy", final unit="J/mol");


type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final
      unit="kg2.K/(m3.J)");


type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final
      unit="J/Pa");


type DerEnergyByMoles = Real (final quantity="DerEnergyByMoles", final unit=
        "J/mol");


type DerEntropyByTemperature = Real (final quantity="DerEntropyByTemperature",
      final unit="J/K2");


type DerEntropyByPressure = Real (final quantity="DerEntropyByPressure", final
      unit="J/(K.Pa)");


type DerEntropyByMoles = Real (final quantity="DerEntropyByMoles", final unit=
        "J/(mol.K)");


type DerPressureByDensity = Real (final quantity="DerPressureByDensity", final
      unit="Pa.m3/kg");


type DerPressureBySpecificVolume = Real (final quantity=
        "DerPressureBySpecificVolume", final unit="Pa.kg/m3");


type DerPressureByTemperature = Real (final quantity="DerPressureByTemperature",
      final unit="Pa/K");


type DerVolumeByTemperature = Real (final quantity="DerVolumeByTemperature",
      final unit="m3/K");


type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final
      unit="m3/Pa");


type DerVolumeByMoles = Real (final quantity="DerVolumeByMoles", final unit=
        "m3/mol");


type IsenthalpicExponent = Real (final quantity="IsenthalpicExponent", unit="1");


type IsentropicExponent = Real (final quantity="IsentropicExponent", unit="1");


type IsobaricVolumeExpansionCoefficient = Real (final quantity=
        "IsobaricVolumeExpansionCoefficient", unit="1/K");


type IsochoricPressureCoefficient = Real (final quantity=
        "IsochoricPressureCoefficient", unit="1/K");


type IsothermalCompressibility = Real (final quantity=
        "IsothermalCompressibility", unit="1/Pa");


type JouleThomsonCoefficient = Real (final quantity="JouleThomsonCoefficient",
      unit="K/Pa");
// introduce min-manx-nominal values
constant Real MINPOS=1.0e-9
  "minimal value for physical variables which are always > 0.0";

constant SI.Area AMIN=MINPOS "minimal init area";
constant SI.Area AMAX=1.0e5 "maximal init area";
constant SI.Area ANOM=1.0 "nominal init area";
constant SI.AmountOfSubstance MOLMIN=-1.0*MINPOS "minimal Mole Number";
constant SI.AmountOfSubstance MOLMAX=1.0e8 "maximal Mole Number";
constant SI.AmountOfSubstance MOLNOM=1.0 "nominal Mole Number";
constant SI.Density DMIN=MINPOS "minimal init density";
constant SI.Density DMAX=1.0e5 "maximal init density";
constant SI.Density DNOM=1.0 "nominal init density";
constant SI.ThermalConductivity LAMMIN=MINPOS "minimal thermal conductivity";
constant SI.ThermalConductivity LAMNOM=1.0 "nominal thermal conductivity";
constant SI.ThermalConductivity LAMMAX=1000.0 "maximal thermal conductivity";
constant SI.DynamicViscosity ETAMIN=MINPOS "minimal init dynamic viscosity";
constant SI.DynamicViscosity ETAMAX=1.0e8 "maximal init dynamic viscosity";
constant SI.DynamicViscosity ETANOM=100.0 "nominal init dynamic viscosity";
constant SI.Energy EMIN=-1.0e10 "minimal init energy";
constant SI.Energy EMAX=1.0e10 "maximal init energy";
constant SI.Energy ENOM=1.0e3 "nominal init energy";
constant SI.Entropy SMIN=-1.0e6 "minimal init entropy";
constant SI.Entropy SMAX=1.0e6 "maximal init entropy";
constant SI.Entropy SNOM=1.0e3 "nominal init entropy";
constant SI.MassFlowRate MDOTMIN=-1.0e5 "minimal init mass flow rate";
constant SI.MassFlowRate MDOTMAX=1.0e5 "maximal init mass flow rate";
constant SI.MassFlowRate MDOTNOM=1.0 "nominal init mass flow rate";
constant SI.MassFraction MASSXMIN=-1.0*MINPOS "minimal init mass fraction";
constant SI.MassFraction MASSXMAX=1.0 "maximal init mass fraction";
constant SI.MassFraction MASSXNOM=0.1 "nominal init mass fraction";
constant SI.Mass MMIN=-1.0*MINPOS "minimal init mass";
constant SI.Mass MMAX=1.0e8 "maximal init mass";
constant SI.Mass MNOM=1.0 "nominal init mass";
constant SI.MolarMass MMMIN=0.001 "minimal initial molar mass";
constant SI.MolarMass MMMAX=250.0 "maximal initial molar mass";
constant SI.MolarMass MMNOM=0.2 "nominal initial molar mass";
constant SI.MoleFraction MOLEYMIN=-1.0*MINPOS "minimal init mole fraction";
constant SI.MoleFraction MOLEYMAX=1.0 "maximal init mole fraction";
constant SI.MoleFraction MOLEYNOM=0.1 "nominal init mole fraction";
constant SI.MomentumFlux GMIN=-1.0e8 "minimal init momentum flux";
constant SI.MomentumFlux GMAX=1.0e8 "maximal init momentum flux";
constant SI.MomentumFlux GNOM=1.0 "nominal init momentum flux";
constant SI.Power POWMIN=-1.0e8 "minimal init power or heat";
constant SI.Power POWMAX=1.0e8 "maximal init power or heat";
constant SI.Power POWNOM=1.0e3 "nominal init power or heat";
constant SI.Pressure PMIN=1.0e4 "minimal init pressure";
constant SI.Pressure PMAX=1.0e8 "maximal init pressure";
constant SI.Pressure PNOM=1.0e5 "nominal init pressure";
constant SI.Pressure COMPPMIN=-1.0*MINPOS "minimal init pressure";
constant SI.Pressure COMPPMAX=1.0e8 "maximal init pressure";
constant SI.Pressure COMPPNOM=1.0e5 "nominal init pressure";
constant SI.RatioOfSpecificHeatCapacities KAPPAMIN=1.0
  "minimal init isentropic exponent";
constant SI.RatioOfSpecificHeatCapacities KAPPAMAX=1.7
  "maximal init isentropic exponent";
constant SI.RatioOfSpecificHeatCapacities KAPPANOM=1.2
  "nominal init isentropic exponent";
constant SI.SpecificEnergy SEMIN=-1.0e8 "minimal init specific energy";
constant SI.SpecificEnergy SEMAX=1.0e8 "maximal init specific energy";
constant SI.SpecificEnergy SENOM=1.0e6 "nominal init specific energy";
constant SI.SpecificEnthalpy SHMIN=-1.0e8 "minimal init specific enthalpy";
constant SI.SpecificEnthalpy SHMAX=1.0e8 "maximal init specific enthalpy";
constant SI.SpecificEnthalpy SHNOM=1.0e6 "nominal init specific enthalpy";
constant SI.SpecificEntropy SSMIN=-1.0e6 "minimal init specific entropy";
constant SI.SpecificEntropy SSMAX=1.0e6 "maximal init specific entropy";
constant SI.SpecificEntropy SSNOM=1.0e3 "nominal init specific entropy";
constant SI.SpecificHeatCapacity CPMIN=MINPOS
  "minimal init specific heat capacity";
constant SI.SpecificHeatCapacity CPMAX=1.0e6
  "maximal init specific heat capacity";
constant SI.SpecificHeatCapacity CPNOM=1.0e3
  "nominal init specific heat capacity";
constant SI.Temperature TMIN=MINPOS "minimal init temperature";
constant SI.Temperature TMAX=1.0e5 "maximal init temperature";
constant SI.Temperature TNOM=320.0 "nominal init temperature";
constant SI.ThermalConductivity LMIN=MINPOS "minimal init thermal conductivity";
constant SI.ThermalConductivity LMAX=500.0 "maximal init thermal conductivity";
constant SI.ThermalConductivity LNOM=1.0 "nominal init thermal conductivity";
constant SI.Velocity VELMIN=-1.0e5 "minimal init speed";
constant SI.Velocity VELMAX=1.0e5 "maximal init speed";
constant SI.Velocity VELNOM=1.0 "nominal init speed";
constant SI.Volume VMIN=0.0 "minimal init volume";
constant SI.Volume VMAX=1.0e5 "maximal init volume";
constant SI.Volume VNOM=1.0e-3 "nominal init volume";


package ThermoFluidSpecial "property records used by the ThermoFluid library"

  record FixedIGProperties "constant properties for ideal gases"
    extends Modelica.Icons.Record;
    parameter Integer nspecies(min=1) "number of components";
    SI.MolarMass[nspecies] MM "molar mass of components";
    Real[nspecies] invMM "inverse of molar mass of components";
    SI.SpecificHeatCapacity[nspecies] R "gas constant";
    SI.SpecificEnthalpy[nspecies] Hf "enthalpy of formation at 298.15K";
    SI.SpecificEnthalpy[nspecies] H0 "H0(298.15K) - H0(0K)";
    end FixedIGProperties;

  record ThermoBaseVars
    extends Modelica.Icons.Record;
    parameter Integer n(min=1) "discretization number";
    parameter Integer nspecies(min=1) "number of species";
    SI.Pressure[n] p(
      min=PMIN,
      max=PMAX,
      nominal=PNOM,
      start=fill(1.0e5, n)) "Pressure";
    SI.Temperature[n] T(
      min=TMIN,
      max=TMAX,
      nominal=TNOM) "temperature";
    SI.Density[n] d(
      min=DMIN,
      max=DMAX,
      nominal=DNOM) "density";
    SI.SpecificEnthalpy[n] h(
      min=SHMIN,
      max=SHMAX,
      nominal=SHNOM) "specific enthalpy";
    SI.SpecificEntropy[n] s(
      min=SSMIN,
      max=SSMAX,
      nominal=SSNOM) "specific entropy";
    SI.RatioOfSpecificHeatCapacities[n] kappa "ratio of cp/cv";
    SI.Mass[n] M(
      min=MMIN,
      max=MMAX,
      nominal=MNOM) "Total mass";
    SI.Energy[n] U(
      min=EMIN,
      max=EMAX,
      nominal=ENOM) "Inner energy";
    SI.MassFlowRate[n] dM(
      min=MDOTMIN,
      max=MDOTMAX,
      nominal=MDOTNOM) "Change in total mass";
    SI.Power[n] dU(
      min=POWMIN,
      max=POWMAX,
      nominal=POWNOM) "Change in inner energy";
    SI.Volume[n] V(
      min=VMIN,
      max=VMAX,
      nominal=VNOM) "Volume";
    SI.MassFraction[n, nspecies] mass_x(
      min=MASSXMIN,
      max=MASSXMAX,
      nominal=MASSXNOM) "mass fraction";
    SI.MoleFraction[n, nspecies] mole_y(
      min=MOLEYMIN,
      max=MOLEYMAX,
      nominal=MOLEYNOM) "mole fraction";
    SI.Mass[n, nspecies] M_x(
      min=MMIN,
      max=MMAX,
      nominal=MNOM) "component mass";
    SI.MassFlowRate[n, nspecies] dM_x(
      min=MDOTMIN,
      max=MDOTMAX,
      nominal=MDOTNOM) "rate of change in component mass";
    MolarFlowRate[n, nspecies] dZ(
      min=-1.0e6,
      max=1.0e6,
      nominal=0.0) "rate of change in component moles";
    MolarFlowRate[n, nspecies] rZ(
      min=-1.0e6,
      max=1.0e6,
      nominal=0.0) "Reaction(source) mole rates";
    SI.MolarMass[n] MM(
      min=MMMIN,
      max=MMMAX,
      nominal=MMNOM) "molar mass of mixture";
    SI.AmountOfSubstance[n] Moles(
      min=MOLMIN,
      max=MOLMAX,
      nominal=MOLNOM) "total moles";
    SI.AmountOfSubstance[n, nspecies] Moles_z(
      min=MOLMIN,
      max=MOLMAX,
      nominal=MOLNOM) "mole vector";
    annotation (Documentation(info="<HTML>
                         <h4>Model description</h4>
                              <p>
                              <b>ThermoBaseVars</b> is inherited by all medium property models
                              and by all models defining the dynamic states for the conservation
                              of mass and energy. Thus it is a good choice as a restricting class
                              for any medium model or dynamic state model.
                           </p>
                              </HTML>
                              "));
    end ThermoBaseVars;

  record ThermoProperties
    "Thermodynamic base property data for all state models"
    extends Modelica.Icons.Record;
    parameter Integer nspecies(min=1) "number of species";
    SI.Temperature T(
      min=TMIN,
      max=TMAX,
      nominal=TNOM) "temperature";
    SI.Density d(
      min=DMIN,
      max=DMAX,
      nominal=DNOM) "density";
    SI.Pressure p(
      min=PMIN,
      max=PMAX,
      nominal=PNOM) "pressure";
    SI.Volume V(
      min=VMIN,
      max=VMAX,
      nominal=VNOM) "Volume";
    SI.SpecificEnthalpy h(
      min=SHMIN,
      max=SHMAX,
      nominal=SHNOM) "specific enthalpy";
    SI.SpecificEnergy u(
      min=SEMIN,
      max=SEMAX,
      nominal=SENOM) "specific inner energy";
    SI.SpecificEntropy s(
      min=SSMIN,
      max=SSMAX,
      nominal=SSNOM) "specific entropy";
    SI.SpecificGibbsFreeEnergy g(
      min=SHMIN,
      max=SHMAX,
      nominal=SHNOM) "specific Gibbs free energy";
    SI.SpecificHeatCapacity cp(
      min=CPMIN,
      max=CPMAX,
      nominal=CPNOM) "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv(
      min=CPMIN,
      max=CPMAX,
      nominal=CPNOM) "heat capacity at constant volume";
    SI.SpecificHeatCapacity R(
      min=CPMIN,
      max=CPMAX,
      nominal=CPNOM) "gas constant";
    SI.MolarMass MM(
      min=MMMIN,
      max=MMMAX,
      nominal=MMNOM) "molar mass of mixture";
    SI.MassFraction[nspecies] mass_x(
      min=MASSXMIN,
      max=MASSXMAX,
      nominal=MASSXNOM) "mass fraction";
    SI.MoleFraction[nspecies] mole_y(
      min=MOLEYMIN,
      max=MOLEYMAX,
      nominal=MOLEYNOM) "mole fraction";
    SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
    SI.DerDensityByTemperature ddTp
      "derivative of density by temperature at constant pressure";
    SI.DerDensityByPressure ddpT
      "derivative of density by pressure at constant temperature";
    Real dupT(unit="m3.kg-1")
      "derivative of inner energy by pressure at constant T";
    Real dudT(unit="(J.m3)/(kg2)")
      "derivative of inner energy by density at constant T";
    SI.SpecificHeatCapacity duTp
      "derivative of inner energy by temperature at constant p";
    SI.SpecificEnergy ddx[nspecies]
      "derivative vector of density by change in mass composition";
    SI.SpecificEnergy[nspecies] compu(
      min=SEMIN,
      max=SEMAX,
      nominal=SENOM) "inner energy of the components";
    SI.Pressure[nspecies] compp(
      min=COMPPMIN,
      max=COMPPMAX,
      nominal=COMPPNOM) "partial pressures of the components";
    SI.Velocity a(
      min=VELMIN,
      max=VELMAX,
      nominal=VELNOM) "speed of sound";
    SI.HeatCapacity dUTZ
      "derivative of inner energy by temperature at constant moles";
    SI.MolarInternalEnergy[nspecies] dUZT
      "derivative of inner energy by moles at constant temperature";
    SI.SpecificEnthalpy[nspecies] dHMxT(
      min=SEMIN,
      max=SEMAX,
      nominal=SENOM)
      "derivative of total enthalpy w.r.t. component mass at constant T";
    Real dpT "derivative of pressure w.r.t. temperature";
    Real dpZ[nspecies] "derivative of pressure w.r.t. moles";
    annotation (Documentation(info="<HTML>
        <h4>Model description</h4>
        <p>
        A base class for medium property models which work with most of the
        versions of dynamic states that are available in the ThermoFluid
        library. Currently used by all ideal gas models.
     </p>
        </HTML>
        "));
    end ThermoProperties;

  record ThermoProperties_ph
    "Thermodynamic property data for pressure p and specific enthalpy h as dynamic states"

    extends Modelica.Icons.Record;
    SI.Temperature T(
      min=1.0e-9,
      max=10000.0,
      nominal=298.15) "temperature";
    SI.Density d(
      min=1.0e-9,
      max=10000.0,
      nominal=10.0) "density";
    SI.SpecificEnergy u(
      min=-1.0e8,
      max=1.0e8,
      nominal=1.0e6) "specific inner energy";
    SI.SpecificEntropy s(
      min=-1.0e6,
      max=1.0e6,
      nominal=1.0e3) "specific entropy";
    SI.SpecificHeatCapacity cp(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "heat capacity at constant volume";
    SI.SpecificHeatCapacity R(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
    SI.Velocity a(
      min=1.0,
      max=10000.0,
      nominal=300.0) "speed of sound";
    SI.DerDensityByEnthalpy ddhp
      "derivative of density by enthalpy at constant pressure";
    SI.DerDensityByPressure ddph
      "derivative of density by pressure at constant enthalpy";
    Real duph(unit="m3/kg")
      "derivative of inner energy by pressure at constant enthalpy";
    Real duhp(unit="1")
      "derivative of inner energy by enthalpy at constant pressure";
    annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which
use pressure and enthalpy as dynamic states.
This is the preferred model for fluids that can also be in the
two phase and liquid regions.
</p>
</HTML>
"));
    end ThermoProperties_ph;

  record ThermoProperties_pT
    "Thermodynamic property data for pressure p and temperature T as dynamic states"

    extends Modelica.Icons.Record;
    SI.Density d(
      min=1.0e-9,
      max=10000.0,
      nominal=10.0) "density";
    SI.SpecificEnthalpy h(
      min=-1.0e8,
      max=1.0e8,
      nominal=1.0e6) "specific enthalpy";
    SI.SpecificEnergy u(
      min=-1.0e8,
      max=1.0e8,
      nominal=1.0e6) "specific inner energy";
    SI.SpecificEntropy s(
      min=-1.0e6,
      max=1.0e6,
      nominal=1.0e3) "specific entropy";
    SI.SpecificHeatCapacity cp(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "heat capacity at constant volume";
    SI.SpecificHeatCapacity R(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
    SI.Velocity a(
      min=1.0,
      max=10000.0,
      nominal=300.0) "speed of sound";
    SI.DerDensityByTemperature ddTp
      "derivative of density by temperature at constant pressure";
    SI.DerDensityByPressure ddpT
      "derivative of density by pressure at constant temperature";
    Real dupT(unit="m3.kg-1")
      "derivative of inner energy by pressure at constant T";
    SI.SpecificHeatCapacity duTp
      "derivative of inner energy by temperature at constant p";
    annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which use pressure and temperature as dynamic states.
This is a reasonable model for fluids that can also be in the gas and
liquid regions, but never in the two-phase region.
</p>
</HTML>
"));
    end ThermoProperties_pT;

  record ThermoProperties_dT
    "Thermodynamic property data for density d and temperature T as dynamic states"

    extends Modelica.Icons.Record;
    SI.Pressure p(
      min=1.0,
      max=1.0e9,
      nominal=1.0e5) "pressure";
    SI.SpecificEnthalpy h(
      min=-1.0e8,
      max=1.0e8,
      nominal=1.0e6) "specific enthalpy";
    SI.SpecificEnergy u(
      min=-1.0e8,
      max=1.0e8,
      nominal=1.0e6) "specific inner energy";
    SI.SpecificEntropy s(
      min=-1.0e6,
      max=1.0e6,
      nominal=1.0e3) "specific entropy";
    SI.SpecificHeatCapacity cp(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "heat capacity at constant volume";
    SI.SpecificHeatCapacity R(
      min=1.0,
      max=1.0e6,
      nominal=1000.0) "gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
    SI.Velocity a(
      min=1.0,
      max=10000.0,
      nominal=300.0) "speed of sound";
    Real dudT(unit="m5/(kg.s2)")
      "derivative of inner energy by density at constant T";
    annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which use density and temperature as dynamic states.
This is a reasonable model for fluids that can be in the gas, liquid
and two-phase region. The model is numerically not well suited for
liquids except if the pressure is always above approx. 80% of the
critical pressure.
</p>
</HTML>
"));
    end ThermoProperties_dT;

  //   record GibbsDerivs

  //     "derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"
  //     extends Modelica.Icons.Record;
  //     Real pi "dimensionless pressure";
  //     Real tau "dimensionless temperature";
  //     Real g "dimensionless Gibbs-function";
  //     Real gpi "derivative of g w.r.t. pi";
  //     Real gpipi "2nd derivative of g w.r.t. pi";
  //     Real gtau "derivative of g w.r.t. tau";
  //     Real gtautau "2nd derivative of g w.r.t. tau";
  //     Real gtaupi "mixed derivative of g w.r.t. pi and tau";
  //   end GibbsDerivs;

  //   record HelmholtzDerivs

  //     "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressuredensity and temperature"
  //     extends Modelica.Icons.Record;
  //     Real delta "dimensionless density";
  //     Real tau "dimensionless temperature";
  //     Real f "dimensionless Helmholtz-function";
  //     Real fdelta "derivative of f w.r.t. delta";
  //     Real fdeltadelta "2nd derivative of f w.r.t. delta";
  //     Real ftau "derivative of f w.r.t. tau";
  //     Real ftautau "2nd derivative of f w.r.t. tau";
  //     Real fdeltatau "mixed derivative of f w.r.t. delta and tau";
  //   end HelmholtzDerivs;

  record TransportProps "record with transport properties"
    extends Modelica.Icons.Record;
    SI.DynamicViscosity eta;
    SI.ThermalConductivity lam;
    end TransportProps;

  function gibbsToProps_ph
    "calulate property record for pressure and specific enthalpy as states from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output ThermoProperties_ph pro
      "property record for pressure and specific enthalpy as dynamic states";
  protected
    Real vt(unit="m3.kg-1.K-1")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "derivative of specific volume w.r.t. pressure";
    algorithm
    pro.T := g.T;
    pro.R := g.R;
    pro.d := g.p/(pro.R*pro.T*g.pi*g.gpi);
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.s := pro.R*(g.tau*g.gtau - g.g);
    pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
    pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/(g.gpipi));
    pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*
      g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
    pro.ddhp := -pro.d*pro.d*vt/(pro.cp);
    pro.ddph := -pro.d*pro.d*(vp*pro.cp - vt/pro.d + g.T*vt*vt)/pro.cp;
    pro.duph := -1/pro.d + g.p/(pro.d*pro.d)*pro.ddph;
    pro.duhp := 1 + g.p/(pro.d*pro.d)*pro.ddhp;
    end gibbsToProps_ph;

  function gibbsToBoundaryProps
    "calulate phase boundary property record from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output PhaseBoundaryProperties sat "phase boundary properties";
  protected
    Real vt(unit="m3.kg-1.K-1")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "derivative of specific volume w.r.t. pressure";
    algorithm
    sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
    sat.h := g.R*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R*(g.tau*g.gtau - g.g);
    sat.cp := -g.R*g.tau*g.tau*g.gtautau;
    sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/(g.gpipi));
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
    end gibbsToBoundaryProps;

  function gibbsToProps_dT
    "calulate property record for density and temperature as states from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output ThermoProperties_dT pro
      "property record for density and temperature as dynamic states";
  protected
    Real vt(unit="m3.kg-1.K-1")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "derivative of specific volume w.r.t. pressure";
    Modelica.SIunits.Density d;
    algorithm
    pro.R := g.R;
    pro.p := g.p;
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.h := g.R*g.T*g.tau*g.gtau;
    pro.s := pro.R*(g.tau*g.gtau - g.g);
    pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
    pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi);
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    pro.kappa := -1/((g.p/(pro.R*g.T*g.pi*g.gpi))*g.p)*pro.cp/(vp*pro.cp + vt*
      vt*g.T);
    pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*
      g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;

    d := g.p/(pro.R*g.T*g.pi*g.gpi);
    pro.dudT := (pro.p - g.T*vt/vp)/(d*d);
    end gibbsToProps_dT;

  function gibbsToProps_pT
    "calulate property record for pressure and temperature as states from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output ThermoProperties_pT pro
      "property record for pressure and temperature as dynamic states";
  protected
    Real vt(unit="m3.kg-1.K-1")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "derivative of specific volume w.r.t. pressure";
    algorithm
    pro.R := g.R;
    pro.d := g.p/(pro.R*g.T*g.pi*g.gpi);
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.h := g.R*g.T*g.tau*g.gtau;
    pro.s := pro.R*(g.tau*g.gtau - g.g);
    pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
    pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi);
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
    pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*
      g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
    pro.ddpT := -(pro.d*pro.d)*vp;
    pro.ddTp := -(pro.d*pro.d)*vt;
    pro.duTp := pro.cp - g.p*vt;
    pro.dupT := -g.T*vt - g.p*vp;
    end gibbsToProps_pT;

  function helmholtzToProps_ph
    "calulate property record for pressure and specific enthalpy as states from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output ThermoProperties_ph pro
      "property record for pressure and specific enthalpy as dynamic states";
  protected
    SI.Pressure p "pressure";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "derivative of pressure w.r.t. specific volume";
    algorithm
    pro.d := f.d;
    pro.T := f.T;
    pro.R := f.R;
    pro.s := f.R*(f.tau*f.ftau - f.f);
    pro.u := f.R*f.T*f.tau*f.ftau;
    p := pro.d*pro.R*pro.T*f.delta*f.fdelta;
    pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    pv := -pd*f.d*f.d;

    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
    pro.kappa := 1/(f.d*f.R*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.T)
      /(pro.cv));
    pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta -
      ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta - f.delta
      *f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
    pro.ddph := (f.d*(pro.cv*f.d + pt))/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
    pro.ddhp := -f.d*f.d*pt/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
    pro.duph := -1/pro.d + p/(pro.d*pro.d)*pro.ddph;
    pro.duhp := 1 + p/(pro.d*pro.d)*pro.ddhp;
    end helmholtzToProps_ph;

  function helmholtzToProps_pT
    "calulate property record for pressure and temperature as states from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output ThermoProperties_pT pro
      "property record for pressure and temperature as dynamic states";
  protected
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "derivative of pressure w.r.t. specific volume";
    IsobaricVolumeExpansionCoefficient alpha
      "isobaric volume expansion coefficient";
    // beta in Bejan
    IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
    SI.Pressure p "Pressure";
    algorithm
    pro.d := f.d;
    pro.R := f.R;
    pro.s := f.R*(f.tau*f.ftau - f.f);
    pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    pro.u := f.R*f.T*f.tau*f.ftau;
    pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    pv := -(f.d*f.d)*pd;
    alpha := -f.d*pt/pv;
    gamma := -f.d/pv;
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
    pro.kappa := 1/(f.d*f.R*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.T)
      /(pro.cv));
    pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta -
      ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta - f.delta
      *f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
    pro.ddTp := -pt/pd;
    pro.ddpT := 1/pd;
    //problem with units in last two lines
    pro.dupT := gamma*p/f.d - alpha*f.T/f.d;
    pro.duTp := pro.cp - alpha*p/f.d;
    end helmholtzToProps_pT;

  function helmholtzToProps_dT
    "calulate property record for density and temperature as states from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output ThermoProperties_dT pro
      "property record for density and temperature as dynamic states";
  protected
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv "derivative of pressure w.r.t. pressure";
    algorithm
    pro.p := f.R*f.d*f.T*f.delta*f.fdelta;
    pro.R := f.R;
    pro.s := f.R*(f.tau*f.ftau - f.f);
    pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    pro.u := f.R*f.T*f.tau*f.ftau;
    pv := -(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);

    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
    pro.kappa := 1/(f.d*pro.p)*((-pv*pro.cv + pt*pt*f.T)/(pro.cv));
    pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta -
      ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta - f.delta
      *f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
    pro.dudT := (pro.p - f.T*pt)/(f.d*f.d);
    end helmholtzToProps_dT;

  function TwoPhaseToProps_ph
    "compute property record for pressure and specific enthalpy as states from saturation properties"

    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation property record";
    output ThermoProperties_ph pro
      "property record for pressure and specific enthalpy as dynamic states";
  protected
    Real dht(unit="(J/kg)/K")
      "derivative of specific enthalpy w.r.t. temperature";
    Real dhd(unit="(J/kg)/(kg/m3)")
      "derivative of specific enthalpy w.r.t. density";
    Real detph(unit="m4.s4/(K.s8)") "thermodynamic determinant";
    algorithm
    pro.d := sat.d;
    pro.T := sat.T;
    pro.u := sat.u;
    pro.s := sat.s;
    pro.cv := sat.cv;
    pro.R := sat.R;
    pro.cp := Modelica.Constants.inf;
    pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
    pro.a := Modelica.Constants.inf;
    dht := sat.cv + sat.dpT/sat.d;
    dhd := -sat.T*sat.dpT/(sat.d*sat.d);
    detph := -sat.dpT*dhd;
    pro.ddph := dht/detph;
    pro.ddhp := -sat.dpT/detph;
    end TwoPhaseToProps_ph;

  function TwoPhaseToProps_dT
    "compute property record for density and temperature as states from saturation properties"

    extends Modelica.Icons.Function;
    input SaturationProperties sat "saturation properties";
    output ThermoProperties_dT pro
      "property record for density and temperature as dynamic states";
    algorithm
    pro.p := sat.p;
    pro.h := sat.h;
    pro.u := sat.u;
    pro.s := sat.s;
    pro.cv := sat.cv;
    pro.cp := Modelica.Constants.inf;
    pro.R := sat.R;
    pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
    pro.a := Modelica.Constants.inf;
    pro.dudT := (sat.p - sat.T*sat.dpT)/(sat.d*sat.d);
    end TwoPhaseToProps_dT;

  end ThermoFluidSpecial;


annotation (Documentation(info="<HTML><h4>Package description</h4>
      <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
      High accuracy fluid property models share a lot of common structure, even if the actual models are different.
      Common data structures and computations shared by these property models are collected in this library.
   </p>

</HTML>
", revisions="<html>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
      for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions: <i>December, 2002</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a> and move to Modelica
                            properties library.</li>
      <li>Inclusion into Modelica.Media: September 2003 </li>
      </ul>

      <address>Author: Hubertus Tummescheit, <br>
      Lund University<br>
      Department of Automatic Control<br>
      Box 118, 22100 Lund, Sweden<br>
      email: hubertus@control.lth.se
      </address>
</html>"));
end Common;
