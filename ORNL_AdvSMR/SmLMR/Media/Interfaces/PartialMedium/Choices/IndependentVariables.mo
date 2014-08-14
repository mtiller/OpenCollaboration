within ORNL_AdvSMR.SmLMR.Media.Interfaces.PartialMedium.Choices;
type IndependentVariables = enumeration(
    T "Temperature",
    pT "Pressure, Temperature",
    ph "Pressure, Specific Enthalpy",
    phX "Pressure, Specific Enthalpy, Mass Fraction",
    pTX "Pressure, Temperature, Mass Fractions",
    dTX "Density, Temperature, Mass Fractions")
  "Enumeration defining the independent variables of a medium";
