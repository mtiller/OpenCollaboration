within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function isentropicExponent_props_dT
  "isentropic exponent as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output Real gamma "isentropic exponent";
algorithm
  gamma := if aux.region == 3 then 1/(aux.rho*aux.p)*((aux.pd*aux.cv*aux.rho*
    aux.rho + aux.pt*aux.pt*aux.T)/(aux.cv)) else if aux.region == 4 then 1/(
    aux.rho*aux.p)*aux.dpT*aux.dpT*aux.T/aux.cv else -1/(aux.rho*aux.p)*aux.cp/
    (aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
  annotation (Inline=false, LateInline=true);
end isentropicExponent_props_dT;
