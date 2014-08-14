within ORNL_AdvSMR.Thermal;
model HeatSource1Dhtc_out "Distributed Heat Flow Source"
  extends HeatSource1D(redeclare DHThtc wall);
end HeatSource1Dhtc_out;
