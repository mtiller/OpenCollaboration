within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function cp_props_ph
  "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificHeatCapacity cp "specific heat capacity";
algorithm
  cp := aux.cp;
  annotation (Inline=false, LateInline=true);
end cp_props_ph;
