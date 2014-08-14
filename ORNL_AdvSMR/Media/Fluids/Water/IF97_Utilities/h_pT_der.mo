within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function h_pT_der "derivative function of h_pT"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real p_der "derivative of pressure";
  input Real T_der "derivative of temperature";
  output Real h_der "derivative of specific enthalpy";
algorithm
  if (aux.region == 3) then
    h_der := ((-aux.rho*aux.pd + T*aux.pt)/(aux.rho*aux.rho*aux.pd))*p_der + ((
      aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd))
      *T_der;
  else
    //regions 1,2 or 5
    h_der := (1/aux.rho - aux.T*aux.vt)*p_der + aux.cp*T_der;
  end if;
end h_pT_der;
