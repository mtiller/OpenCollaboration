within ORNL_AdvSMR.PRISM.Media.Interfaces;
partial package PartialCondensingGases "Base class for mixtures of condensing and non-condensing gases"
extends PartialMixtureMedium(ThermoStates=Choices.IndependentVariables.pTX);


replaceable partial function saturationPressure
  "Return saturation pressure of condensing fluid"
  extends Modelica.Icons.Function;
  input Temperature Tsat "saturation temperature";
  output AbsolutePressure psat "saturation pressure";
  end saturationPressure;


replaceable partial function enthalpyOfVaporization
  "Return vaporization enthalpy of condensing fluid"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output SpecificEnthalpy r0 "vaporization enthalpy";
  end enthalpyOfVaporization;


replaceable partial function enthalpyOfLiquid
  "Return liquid enthalpy of condensing fluid"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfLiquid;


replaceable partial function enthalpyOfGas
  "Return enthalpy of non-condensing gas mixture"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  input MassFraction[:] X "vector of mass fractions";
  output SpecificEnthalpy h "specific enthalpy";
  end enthalpyOfGas;


replaceable partial function enthalpyOfCondensingGas
  "Return enthalpy of condensing gas (most often steam)"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output SpecificEnthalpy h "specific enthalpy";
  end enthalpyOfCondensingGas;


replaceable partial function enthalpyOfNonCondensingGas
  "Return enthalpy of the non-condensing species"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output SpecificEnthalpy h "specific enthalpy";
  end enthalpyOfNonCondensingGas;
end PartialCondensingGases;
