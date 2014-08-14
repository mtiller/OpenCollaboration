within ORNL_AdvSMR.Choices.HeatTransfer;
type MetallicFluidRodBundleCorrelations = enumeration(
    KazimiCarelli
      "Kazimi and Carelli correlation (1.1 <= P/D <= 1.4 and 10 <= Pe <= 5000)",

    SchadModified
      "Schad-modified correlation (1.1 <= P/D <= 1.5 and 150 <= Pe <= 1000)",
    SchadModifiednLowPeclet
      "Schad-modified correlation for low Peclet numbers (Pe <= 150)",
    GraberRieger
      "Graber and Rieger correlation (1.25 <= P/D <= 1.95 and 150 <= Pe <= 3000)",

    Borishanskii
      "Borishanskii correlation (1.1 <= P/D <= 1.5 and 200 <= Pe <= 2000)",
    BorishanskiiLowPeclet
      "Borishanskii correlation for low Peclet numbers (Pe <= 200)")
  "Menu choices for single-phase heat transfer correlations for metallic fluids in a rod bundle";

