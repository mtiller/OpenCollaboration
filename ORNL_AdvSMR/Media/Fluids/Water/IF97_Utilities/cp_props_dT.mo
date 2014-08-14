within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function cp_props_dT
  "specific heat capacity at constant pressure as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificHeatCapacity cp "specific heat capacity";
algorithm
  cp := aux.cp;
  annotation (Inline=false, LateInline=true);
end cp_props_dT;
