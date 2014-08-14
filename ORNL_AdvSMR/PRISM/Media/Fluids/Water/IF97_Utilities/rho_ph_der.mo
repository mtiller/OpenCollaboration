within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function rho_ph_der "derivative function of rho_ph"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real p_der "derivative of pressure";
  input Real h_der "derivative of specific enthalpy";
  output Real rho_der "derivative of density";
algorithm
  if (aux.region == 4) then
    rho_der := (aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T))*p_der
       + (-aux.rho*aux.rho/(aux.dpT*aux.T))*h_der;
  elseif (aux.region == 3) then
    rho_der := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*aux.cv
       + aux.T*aux.pt*aux.pt))*p_der + (-aux.rho*aux.rho*aux.pt/(aux.rho*aux.rho
      *aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
  else
    //regions 1,2,5
    rho_der := (-aux.rho*aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt
      *aux.vt)/aux.cp)*p_der + (-aux.rho*aux.rho*aux.vt/(aux.cp))*h_der;
  end if;
end rho_ph_der;
