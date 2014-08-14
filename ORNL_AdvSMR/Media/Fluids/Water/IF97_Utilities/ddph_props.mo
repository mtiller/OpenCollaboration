within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function ddph_props "density derivative by pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.DerDensityByPressure ddph "density derivative by pressure";
algorithm
  ddph := if aux.region == 3 then ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho
    *aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)) else if aux.region == 4
     then (aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T)) else (-aux.rho
    *aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt*aux.vt)/aux.cp);
  annotation (Inline=false, LateInline=true);
end ddph_props;
