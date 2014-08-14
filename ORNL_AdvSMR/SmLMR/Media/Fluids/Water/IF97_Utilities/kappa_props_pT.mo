within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function kappa_props_pT
  "isothermal compressibility factor as function of pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.IsothermalCompressibility kappa "isothermal compressibility factor";
algorithm
  kappa := if aux.region == 3 then 1/(aux.rho*aux.pd) else -aux.vp*
    aux.rho;
  annotation (Inline=false, LateInline=true);
end kappa_props_pT;
