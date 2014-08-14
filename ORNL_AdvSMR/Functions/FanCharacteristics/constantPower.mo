within ORNL_AdvSMR.Functions.FanCharacteristics;
function constantPower "Constant power consumption characteristic"
  extends FanCharacteristics.basePower;
  input Modelica.SIunits.Power power=0 "Constant power consumption";
algorithm
  consumption := power;
end constantPower;
