within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function velocityOfSound_props_pT
  "speed of sound as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.Velocity v_sound "speed of sound";
algorithm
  // dp/drho at constant s
  v_sound := if aux.region == 3 then sqrt(max(0, (aux.pd*aux.rho*
    aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv)))
     else sqrt(max(0, -aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt
    *aux.vt*aux.T))));
  annotation (Inline=false, LateInline=true);
end velocityOfSound_props_pT;
