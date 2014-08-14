within ORNL_AdvSMR.Media.Interfaces;
partial package State "Mass fraction based models"
import Modelon.Media.Interfaces.State.Units.*;
constant String mediumName="unusablePartialMedium"
  "Name of the medium: must be changed in derived class";
constant String substanceNames[:]={mediumName}
  "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
constant String extraPropertiesNames[:]=fill("", 0)
  "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
final constant Integer nS=size(substanceNames, 1) "Number of substances"
  annotation (Evaluate=true);
final constant Integer nC=size(extraPropertiesNames, 1)
  "Number of extra (outside of standard mass-balance) transported properties"
  annotation (Evaluate=true);
constant ORNL_AdvSMR.Media.Interfaces.Types.Compressibility CompressibilityType
  "Enumeration defining the compressibility assumption";
constant Boolean FixedComposition
  "If true, medium is a mixture with contant composition over time";
constant Boolean hasCriticalData
  "If true, critical point properties for all substances are known";
constant Boolean analyticInverseTfromh
  "If true, an analytic inverse is available to compute temperature, given specific enthalpy";
constant Boolean useExternalMedia=false
  "If set to true the functions getMediumProps, getTransportProps and getSaturationProps are assumed to be implemented and are used to fill the property records";
constant AbsolutePressure reference_p=101325
  "Reference pressure of Medium: default 1 atmosphere";
constant Temperature reference_T=298.15
  "Reference temperature of Medium: default 25 deg Celsius";
constant MassFraction reference_X[nS]=fill(1/nS, nS)
  "Default mass fractions of medium";
constant AbsolutePressure p_default=101325
  "Default value for pressure of medium (for initialization)";
constant Temperature T_default=Modelica.SIunits.Conversions.from_degC(20)
  "Default value for temperature of medium (for initialization)";
constant SpecificEnthalpy h_default=0.0
  "Default value for specific enthalpy of medium (for initialization)";
constant MassFraction X_default[nS]=reference_X
  "Default value for mass fractions of medium (for initialization)";


replaceable record ThermodynamicState
  "Minimal variable set that is available as input argument to every medium function"
  extends Modelica.Icons.Record;
  // String[nS] substanceNames "name of substances";
  annotation (Documentation(info="<html></html>"));
  end ThermodynamicState;


replaceable partial function setState_pTX
  "Return thermodynamic state as function of p, T and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[nS]=reference_X "Mass fractions";
  // input String[:] mediumName "Medium string identifier";
  output ThermodynamicState state "thermodynamic state record";
  annotation (smoothOrder=2);
  end setState_pTX;


replaceable partial function setState_phX
  "Return thermodynamic state as function of p, h and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[nS]=reference_X "Mass fractions";
  // input String[nS] mediumName "Medium string identifier";
  output ThermodynamicState state "thermodynamic state record";
  annotation (Documentation(info="<html></html>"));
  end setState_phX;


replaceable partial function setState_psX
  "Return thermodynamic state as function of p, s and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[nS]=reference_X "Mass fractions";
  // input String[nS] mediumName = substanceNames "Medium string identifier";
  output ThermodynamicState state "thermodynamic state record";
  annotation (Documentation(info="<html></html>"));
  end setState_psX;


replaceable partial function setState_dTX
  "Return thermodynamic state as function of d, T and composition X"
  extends Modelica.Icons.Function;
  input Density d "density";
  input Temperature T "Temperature";
  input MassFraction X[nS]=reference_X "Mass fractions";
  // input String[nS] mediumName = substanceNames "Medium string identifier";
  output ThermodynamicState state "thermodynamic state record";
  annotation (Documentation(info="<html></html>"));
  end setState_dTX;


replaceable partial function getMediumProps
  "Return thermodynamic property record given the thermodynamic state"
  //extends Modelon.Media.Icons.FunctionStateRecordAsInput;
  input ThermodynamicState state;
  output DynamicMinimumTwoPhaseProperties props "thermodynamic property record";
  end getMediumProps;


replaceable partial function getTransportProps
  "Return transport property record given the thermodynamic state"
  //extends Modelon.Media.Icons.FunctionStateRecordAsInput;
  input ThermodynamicState state;
  output DynamicMinimumTransportProperties props "transport property record";
  end getTransportProps;


replaceable partial function getSaturationProps
  "Return saturation property record given the thermodynamic state"
  //extends Modelon.Media.Icons.FunctionStateRecordAsInput;
  input ThermodynamicState state;
  output DynamicMinimumSaturationProperties props "Saturation property record";
  end getSaturationProps;

end State;
