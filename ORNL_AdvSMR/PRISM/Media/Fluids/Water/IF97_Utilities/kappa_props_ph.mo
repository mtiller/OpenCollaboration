within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function kappa_props_ph
  "isothermal compressibility factor as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.IsothermalCompressibility kappa "isothermal compressibility factor";
algorithm
  kappa := if aux.region == 3 or aux.region == 4 then 1/(aux.rho*aux.pd) else -
    aux.vp*aux.rho;
  annotation (Inline=false, LateInline=true);
end kappa_props_ph;
