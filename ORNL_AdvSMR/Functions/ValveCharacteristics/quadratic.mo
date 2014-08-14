within ORNL_AdvSMR.Functions.ValveCharacteristics;
function quadratic "Quadratic characteristic"
  extends baseFun;
algorithm
  rc := pos*pos;
end quadratic;
