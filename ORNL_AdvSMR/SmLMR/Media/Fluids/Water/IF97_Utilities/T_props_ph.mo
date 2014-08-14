within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function T_props_ph "temperature as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase properties "auxiliary record";
  output SI.Temperature T "temperature";
algorithm
  T := properties.T;
  annotation (
    derivative(noDerivative=properties) = T_ph_der,
    Inline=false,
    LateInline=true);
end T_props_ph;
