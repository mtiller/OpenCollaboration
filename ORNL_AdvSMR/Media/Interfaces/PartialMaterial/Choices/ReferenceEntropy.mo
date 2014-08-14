within ORNL_AdvSMR.Media.Interfaces.PartialMaterial.Choices;
type ReferenceEntropy = enumeration(
    ZeroAt0K "The entropy is 0 at 0 K (default)",
    ZeroAt0C "The entropy is 0 at 0 degC",
    UserDefined
      "The user-defined reference entropy is used at 293.15 K (25 degC)")
  "Enumeration defining the reference entropy of a medium" annotation (Evaluate
    =true);
