within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function beta_props_ph
  "isobaric expansion coefficient as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
algorithm
  beta := if aux.region == 3 or aux.region == 4 then aux.pt/(aux.rho*aux.pd)
     else aux.vt*aux.rho;
  annotation (Inline=false, LateInline=true);
end beta_props_ph;
