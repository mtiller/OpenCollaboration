within ORNL_AdvSMR.Choices.Init;
type Options = enumeration(
    noInit "No initial equations",
    steadyState "Steady-state initialisation",
    steadyStateNoP "Steady-state initialisation except pressures",
    steadyStateNoT "Steady-state initialisation except temperatures",
    steadyStateNoPT
      "Steady-state initialisation except pressures and temperatures")
  "Type, constants and menu choices to select the initialisation options";
