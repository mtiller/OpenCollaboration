within ORNL_AdvSMR.Media.Interfaces.Types;
type Interfaces = enumeration(
    SimpleMedium "Simplest model for fluids, e.g. hydraulic fluids",
    HomogeneousMedium "Standard model for single phase fluids",
    GasWithCondensingLiquid
      "Gas mixed with a liquid or solid, interacting through phase change",
    GasWithCondensedMatter "Gas mixed with a liquid or solid, not interacting",

    TwoPhase "Standard model for two phase fluids",
    SingleSubstanceTwoPhase "Two phase model for single substances")
  "Enumeration of interfaces";

