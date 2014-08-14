within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function T_ph_der "derivative function of T_ph"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real p_der "derivative of pressure";
  input Real h_der "derivative of specific enthalpy";
  output Real T_der "derivative of temperature";
algorithm
  if (aux.region == 4) then
    T_der := 1/aux.dpT*p_der;
  elseif (aux.region == 3) then
    T_der := ((-aux.rho*aux.pd + aux.T*aux.pt)/(aux.rho*aux.rho*aux.pd*aux.cv
       + aux.T*aux.pt*aux.pt))*p_der + ((aux.rho*aux.rho*aux.pd)/(aux.rho*aux.rho
      *aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
  else
    //regions 1,2 or 5
    T_der := ((-1/aux.rho + aux.T*aux.vt)/aux.cp)*p_der + (1/aux.cp)*h_der;
  end if;
end T_ph_der;
