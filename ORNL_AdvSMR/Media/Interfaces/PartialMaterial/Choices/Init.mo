within ORNL_AdvSMR.Media.Interfaces.PartialMaterial.Choices;
type Init = enumeration(
    NoInit "NoInit (no initialization)",
    InitialStates "InitialStates (initialize medium states)",
    SteadyState "SteadyState (initialize in steady state)",
    SteadyMass "SteadyMass (initialize density or pressure in steady state)")
  "Enumeration defining initialization for fluid flow" annotation (Evaluate=
      true);
