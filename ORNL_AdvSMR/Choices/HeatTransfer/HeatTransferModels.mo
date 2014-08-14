within ORNL_AdvSMR.Choices.HeatTransfer;
type HeatTransferModels = enumeration(
    Constant "Constant heat transfer coefficient",
    Laminar "Laminar flow",
    Turbulent "Turbulent flow",
    Full "Full treatment of heat transfer")
  "Menu choices to select the heat transfer model";
