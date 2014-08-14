within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function s_props_ph
  "specific entropy as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase properties "auxiliary record";
  output SI.SpecificEntropy s "specific entropy";
algorithm
  s := properties.s;
  annotation (
    derivative(noDerivative=properties) = s_ph_der,
    Inline=false,
    LateInline=true);
end s_props_ph;
