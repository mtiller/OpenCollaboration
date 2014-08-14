within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common;
partial package MixtureGasNasa "Medium model of a mixture of ideal gases based on NASA source"

  import Modelica.Math;
  import Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy;


  extends Modelica.Media.Interfaces.PartialMixtureMedium(
    ThermoStates=Choices.IndependentVariables.pTX,
    substanceNames=data[:].name,
    reducedX=false,
    singleState=false,
    reference_X=fill(1/nX, nX),
    SpecificEnthalpy(start=if referenceChoice == ReferenceEnthalpy.ZeroAt0K
           then 3e5 else if referenceChoice == ReferenceEnthalpy.UserDefined
           then h_offset else 0, nominal=1.0e5),
    Density(start=10, nominal=10),
    AbsolutePressure(start=10e5, nominal=10e5),
    Temperature(start=500, nominal=500));


  redeclare record extends ThermodynamicState "thermodynamic state variables"
  end ThermodynamicState;


  redeclare record extends FluidConstants "fluid constants"
  end FluidConstants;

  constant DataRecord[:] data "Data records of ideal gas substances";
  // ={Common.SingleGasesData.N2,Common.SingleGasesData.O2}

  constant Boolean excludeEnthalpyOfFormation=true
  "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant ReferenceEnthalpy referenceChoice=ReferenceEnthalpy.ZeroAt0K
  "Choice of reference enthalpy";
  constant SpecificEnthalpy h_offset=0.0
  "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

  //   constant FluidConstants[nX] fluidConstants
  //     "additional data needed for transport properties";
  constant MolarMass[nX] MMX=data[:].MM "molar masses of components";


  redeclare replaceable model extends BaseProperties(
    T(stateSelect=if preferredMediumStates then StateSelect.prefer
           else StateSelect.default),
    p(stateSelect=if preferredMediumStates then StateSelect.prefer
           else StateSelect.default),
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer
           else StateSelect.default),
    redeclare final constant Boolean standardOrderComponents=true)
  "Base properties (p, d, T, h, u, R, MM, X, and Xi of NASA mixture gas"

    import ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
    //    SpecificEnthalpy h_component[nX];
  equation
    assert(T >= 200 and T <= 6000, "
Temperature T (="
      + String(T) + " K = 200 K) is not in the allowed range
200 K <= T <= 6000 K
required from medium model \""
                   + mediumName + "\".");

    MM = molarMass(state);
    h = h_TX(T, X);
    R = data.R*X;
    u = h - R*T;
    d = p/(R*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
    state.X = if fixedX then reference_X else X;
  end BaseProperties;


  redeclare function setState_pTX
  "Return thermodynamic state as function of p, T and composition X"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state;
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
  end setState_pTX;


  redeclare function setState_phX
  "Return thermodynamic state as function of p, h and composition X"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state;
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
                    p=p,
                    T=T_hX(h, X),
                    X=X) else ThermodynamicState(
                    p=p,
                    T=T_hX(h, X),
                    X=cat(
                      1,
                      X,
                      {1 - sum(X)}));
  end setState_phX;


  redeclare function setState_psX
  "Return thermodynamic state as function of p, s and composition X"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state;
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
                    p=p,
                    T=T_psX(
                      p,
                      s,
                      X),
                    X=X) else ThermodynamicState(
                    p=p,
                    T=T_psX(
                      p,
                      s,
                      X),
                    X=cat(
                      1,
                      X,
                      {1 - sum(X)}));
  end setState_psX;


  redeclare function setState_dTX
  "Return thermodynamic state as function of d, T and composition X"
    extends Modelica.Icons.Function;
    input Density d "density";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state;
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
                    p=d*(data.R*X)*T,
                    T=T,
                    X=X) else ThermodynamicState(
                    p=d*(data.R*cat(
                      1,
                      X,
                      {1 - sum(X)}))*T,
                    T=T,
                    X=cat(
                      1,
                      X,
                      {1 - sum(X)}));
  end setState_dTX;


  redeclare function extends setSmoothState
  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  algorithm
    state := ThermodynamicState(
                    p=Modelica.Media.Common.smoothStep(
                      x,
                      state_a.p,
                      state_b.p,
                      x_small),
                    T=Modelica.Media.Common.smoothStep(
                      x,
                      state_a.T,
                      state_b.T,
                      x_small),
                    X=Modelica.Media.Common.smoothStep(
                      x,
                      state_a.X,
                      state_b.X,
                      x_small));
  end setSmoothState;


  redeclare function extends pressure "Return pressure of ideal gas"
  algorithm
    p := state.p;
  end pressure;


  redeclare function extends temperature "Return temperature of ideal gas"
  algorithm
    T := state.T;
  end temperature;


  redeclare function extends density "Return density of ideal gas"
  algorithm
    d := state.p/((state.X*data.R)*state.T);
    annotation (smoothOrder=3);
  end density;


  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := h_TX(state.T, state.X);
  end specificEnthalpy;


  redeclare function extends specificInternalEnergy
  "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := h_TX(state.T, state.X) - gasConstant(state)*state.T;
  end specificInternalEnergy;


  redeclare function extends specificEntropy "Return specific entropy"
protected
    Real[nX] Y(unit="mol/mol") = massToMoleFractions(state.X, data.MM)
    "Molar fractions";
  algorithm
    s := s_TX(state.T, state.X) - sum(state.X[i]*Modelica.Constants.R
      /MMX[i]*(if state.X[i] < Modelica.Constants.eps then Y[i]
       else Modelica.Math.log(Y[i]*state.p/reference_p)) for i in 1
      :nX);
  end specificEntropy;


  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := h_TX(state.T, state.X) - state.T*specificEntropy(state);
  end specificGibbsEnergy;


  redeclare function extends specificHelmholtzEnergy
  "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := h_TX(state.T, state.X) - gasConstant(state)*state.T -
      state.T*specificEntropy(state);
  end specificHelmholtzEnergy;


  redeclare function extends gasConstant "Return gasConstant"
  algorithm
    R := data.R*state.X;
    annotation (smoothOrder=3);
  end gasConstant;


  redeclare function extends specificHeatCapacityCp
  "Return specific heat capacity at constant pressure"
  algorithm
    cp := {SingleGasNasa.cp_T(data[i], state.T) for i in 1:nX}*
      state.X;
  end specificHeatCapacityCp;


  redeclare function extends specificHeatCapacityCv
  "Return specific heat capacity at constant volume from temperature and gas data"
  algorithm
    cv := {SingleGasNasa.cp_T(data[i], state.T) for i in 1:nX}*
      state.X - data.R*state.X;
    annotation (smoothOrder=1);
  end specificHeatCapacityCv;


  redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
    gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(
      state);
  end isentropicExponent;


  redeclare function extends velocityOfSound "Return velocity of sound"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "properties at upstream location";
  algorithm
    a := sqrt(max(0, gasConstant(state)*state.T*
      specificHeatCapacityCp(state)/specificHeatCapacityCv(state)));
  end velocityOfSound;


  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    input Boolean exact=false
    "flag wether exact or approximate version should be used";
  algorithm
    h_is := if exact then specificEnthalpy_psX(
                    p_downstream,
                    specificEntropy(refState),
                    refState.X) else
      isentropicEnthalpyApproximation(p_downstream, refState);
  end isentropicEnthalpy;


  redeclare replaceable function extends dynamicViscosity
  "Return mixture dynamic viscosity"
protected
    DynamicViscosity[nX] etaX "component dynamic viscosities";
  algorithm
    for i in 1:nX loop
      etaX[i] := SingleGasNasa.dynamicViscosityLowPressure(
                      state.T,
                      fluidConstants[i].criticalTemperature,
                      fluidConstants[i].molarMass,
                      fluidConstants[i].criticalMolarVolume,
                      fluidConstants[i].acentricFactor,
                      fluidConstants[i].dipoleMoment);
    end for;
    eta := gasMixtureViscosity(
                    massToMoleFractions(state.X, fluidConstants[:].molarMass),
                    fluidConstants[:].molarMass,
                    etaX);
    annotation (smoothOrder=2);
  end dynamicViscosity;


  redeclare replaceable function extends thermalConductivity
  "Return thermal conductivity for low pressure gas mixtures"
    input Integer method=1
    "method to compute single component thermal conductivity";
protected
    ThermalConductivity[nX] lambdaX "component thermal conductivities";
    DynamicViscosity[nX] eta "component thermal dynamic viscosities";
    SpecificHeatCapacity[nX] cp "component heat capacity";
  algorithm
    for i in 1:nX loop
      assert(fluidConstants[i].hasCriticalData,
        "Critical data for " + fluidConstants[i].chemicalFormula +
        " not known. Can not compute thermal conductivity.");
      eta[i] := SingleGasNasa.dynamicViscosityLowPressure(
                      state.T,
                      fluidConstants[i].criticalTemperature,
                      fluidConstants[i].molarMass,
                      fluidConstants[i].criticalMolarVolume,
                      fluidConstants[i].acentricFactor,
                      fluidConstants[i].dipoleMoment);
      cp[i] := SingleGasNasa.cp_T(data[i], state.T);
      lambdaX[i] := SingleGasNasa.thermalConductivityEstimate(
                      Cp=cp[i],
                      eta=eta[i],
                      method=method);
    end for;
    lambda := lowPressureThermalConductivity(
                    massToMoleFractions(state.X, fluidConstants[:].molarMass),
                    state.T,
                    fluidConstants[:].criticalTemperature,
                    fluidConstants[:].criticalPressure,
                    fluidConstants[:].molarMass,
                    lambdaX);
    annotation (smoothOrder=2);
  end thermalConductivity;


  redeclare function extends isobaricExpansionCoefficient
  "Return isobaric expansion coefficient beta"
  algorithm
    beta := 1/state.T;
  end isobaricExpansionCoefficient;


  redeclare function extends isothermalCompressibility
  "Return isothermal compressibility factor"
  algorithm
    kappa := 1.0/state.p;
  end isothermalCompressibility;


  redeclare function extends density_derp_T
  "Return density derivative by pressure at constant temperature"
  algorithm
    ddpT := 1/(state.T*gasConstant(state));
  end density_derp_T;


  redeclare function extends density_derT_p
  "Return density derivative by temperature at constant pressure"
  algorithm
    ddTp := -state.p/(state.T*state.T*gasConstant(state));
  end density_derT_p;


  redeclare function density_derX "Return density derivative by mass fraction"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "thermodynamic state record";
    output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
  algorithm
    dddX := {-state.p/(state.T*gasConstant(state))*molarMass(state)
      /data[i].MM for i in 1:nX};
  end density_derX;


  redeclare function extends molarMass "Return molar mass of mixture"
  algorithm
    MM := 1/sum(state.X[j]/data[j].MM for j in 1:size(state.X, 1));
  end molarMass;

  //   redeclare function extends specificEnthalpy_psX
  //   protected
  //     Temperature T "temperature";
  //   algorithm
  //     T := temperature_psX(p,s,X);
  //     h := specificEnthalpy_pTX(p,T,X);
  //   end extends;

  //   redeclare function extends density_phX
  //     "Compute density from pressure, specific enthalpy and mass fraction"
  //     protected
  //     Temperature T "temperature";
  //     SpecificHeatCapacity R "gas constant";
  //   algorithm
  //     T := temperature_phX(p,h,X);
  //     R := if (not reducedX) then
  //       sum(data[i].R*X[i] for i in 1:size(substanceNames, 1)) else
  //       sum(data[i].R*X[i] for i in 1:size(substanceNames, 1)-1) + data[end].R*(1-sum(X[i]));
  //     d := p/(R*T);
  //   end density_phX;


  annotation (Documentation(info="<HTML>
<p>
This model calculates the medium properties for single component ideal gases.
</p>
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
This model has been copied from the ThermoFluid library.
It has been developed by Hubertus Tummescheit.
</p>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics));
end MixtureGasNasa;
