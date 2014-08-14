within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function h_props_dT "specific enthalpy as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "Temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := aux.h;
  annotation (
    derivative(noDerivative=aux) = h_dT_der,
    Inline=false,
    LateInline=true);
end h_props_dT;
