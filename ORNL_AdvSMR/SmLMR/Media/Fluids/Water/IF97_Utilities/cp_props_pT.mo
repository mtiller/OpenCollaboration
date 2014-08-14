within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function cp_props_pT
  "specific heat capacity at constant pressure as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificHeatCapacity cp "specific heat capacity";
algorithm
  cp := if aux.region == 3 then (aux.rho*aux.rho*aux.pd*aux.cv +
    aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd) else aux.cp;
  annotation (Inline=false, LateInline=true);
end cp_props_pT;
