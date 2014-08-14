within ORNL_AdvSMR.Functions.PumpCharacteristics;
function constantPower "Constant power consumption characteristic"
  extends basePower;
  input Modelica.SIunits.Power power=0 "Constant power consumption";
algorithm
  consumption := power;
end constantPower;
