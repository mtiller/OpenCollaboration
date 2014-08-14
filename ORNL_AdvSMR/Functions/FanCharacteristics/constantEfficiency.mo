within ORNL_AdvSMR.Functions.FanCharacteristics;
function constantEfficiency "Constant efficiency characteristic"
  extends baseEfficiency;
  input Real eta_nom "Nominal efficiency";
algorithm
  eta := eta_nom;
end constantEfficiency;
