within ORNL_AdvSMR.Functions.ValveCharacteristics;
function sinusoidal "Sinusoidal characteristic"
  extends baseFun;
  import Modelica.Math.*;
  import Modelica.Constants.*;
algorithm
  rc := sin(pos*pi/2);
end sinusoidal;
