within ORNL_AdvSMR.Media.Interfaces.Types;
type ReferenceEnthalpy = enumeration(
    ZeroAt0K
      "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",

    ZeroAt25C
      "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",

    UserDefined
      "The user-defined reference enthalpy is used at 298.15 K (25 degC)")
  "Enumeration defining the reference enthalpy of a medium" annotation (
    Evaluate=true);

