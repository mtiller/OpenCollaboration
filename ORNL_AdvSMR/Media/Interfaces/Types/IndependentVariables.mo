within ORNL_AdvSMR.Media.Interfaces.Types;
type IndependentVariables = enumeration(
    pTX "Pressure, Temperature, Mass Fractions",
    phX "Pressure, Specific Enthalpy, Mass Fractions",
    pTY "Pressure, Temperature, Mole Fractions",
    phY "Pressure, Specific Enthapy, Mole Fractions",
    dTX "Density, Temperature, Mass Fractions")
  "Enumeration defining the independent variables of a medium";
