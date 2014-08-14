within ORNL_AdvSMR.Choices.System;
type Dynamics = enumeration(
    DynamicFreeInitial
      "DynamicFreeInitial -- Dynamic balance, Initial guess value",
    FixedInitial "FixedInitial -- Dynamic balance, Initial value fixed",
    SteadyStateInitial
      "SteadyStateInitial -- Dynamic balance, Steady state initial with guess value",

    SteadyState "SteadyState -- Steady state balance, Initial guess value")
  "Enumeration to define definition of balance equations";

