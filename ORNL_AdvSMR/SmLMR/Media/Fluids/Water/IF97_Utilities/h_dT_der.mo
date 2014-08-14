within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function h_dT_der "derivative function of h_dT"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real d_der "derivative of density";
  input Real T_der "derivative of temperature";
  output Real h_der "derivative of specific enthalpy";
algorithm
  if (aux.region == 3) then
    h_der := ((-d*aux.pd + T*aux.pt)/(d*d))*d_der + ((aux.cv*d +
      aux.pt)/d)*T_der;
  elseif (aux.region == 4) then
    h_der := T*aux.dpT/(d*d)*d_der + ((aux.cv*d + aux.dpT)/d)*T_der;
  else
    //regions 1,2 or 5
    h_der := (-(-1/d + T*aux.vt)/(d*d*aux.vp))*d_der + ((aux.vp*aux.cp
       - aux.vt/d + T*aux.vt*aux.vt)/aux.vp)*T_der;
  end if;
end h_dT_der;
