within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function p_dT_der "derivative function of p_dT"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real d_der "derivative of density";
  input Real T_der "derivative of temperature";
  output Real p_der "derivative of pressure";
algorithm
  if (aux.region == 3) then
    p_der := aux.pd*d_der + aux.pt*T_der;
  elseif (aux.region == 4) then
    p_der := aux.dpT*T_der;
    /*density derivative is 0.0*/
  else
    //regions 1,2 or 5
    p_der := (-1/(d*d*aux.vp))*d_der + (-aux.vt/aux.vp)*T_der;
  end if;
end p_dT_der;
