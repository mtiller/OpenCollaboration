within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function rho_pT_der "derivative function of rho_pT"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real p_der "derivative of pressure";
  input Real T_der "derivative of temperature";
  output Real rho_der "derivative of density";
algorithm
  if (aux.region == 3) then
    rho_der := (1/aux.pd)*p_der - (aux.pt/aux.pd)*T_der;
  else
    //regions 1,2 or 5
    rho_der := (-aux.rho*aux.rho*aux.vp)*p_der + (-aux.rho*aux.rho*aux.vt)*
      T_der;
  end if;
end rho_pT_der;
