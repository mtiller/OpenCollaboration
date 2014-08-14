within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function beta_props_dT
  "isobaric expansion coefficient as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
algorithm
  beta := if aux.region == 3 or aux.region == 4 then aux.pt/(aux.rho*aux.pd)
     else aux.vt*aux.rho;
  annotation (Inline=false, LateInline=true);
end beta_props_dT;
