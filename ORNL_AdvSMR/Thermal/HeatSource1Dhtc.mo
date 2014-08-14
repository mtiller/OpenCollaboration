within ORNL_AdvSMR.Thermal;
model HeatSource1Dhtc "Distributed Heat Flow Source"
  extends HeatSource1D(redeclare DHThtc_in wall);
end HeatSource1Dhtc;
