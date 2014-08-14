within ORNL_AdvSMR.Choices.Flow1D;
type FFtypes = enumeration(
    Kfnom "Kfnom friction factor",
    OpPoint "Friction factor defined by operating point",
    Cfnom "Cfnom friction factor",
    Colebrook "Colebrook's equation",
    NoFriction "No friction")
  "Type, constants and menu choices to select the friction factor";
