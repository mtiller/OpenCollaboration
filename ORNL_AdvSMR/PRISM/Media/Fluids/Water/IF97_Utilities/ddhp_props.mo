within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function ddhp_props "density derivative by specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.DerDensityByEnthalpy ddhp "density derivative by specific enthalpy";
algorithm
  ddhp := if aux.region == 3 then -aux.rho*aux.rho*aux.pt/(aux.rho*aux.rho*aux.pd
    *aux.cv + aux.T*aux.pt*aux.pt) else if aux.region == 4 then -aux.rho*aux.rho
    /(aux.dpT*aux.T) else -aux.rho*aux.rho*aux.vt/(aux.cp);
  annotation (Inline=false, LateInline=true);
end ddhp_props;
