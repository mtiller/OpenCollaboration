within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function h_props_pT "specific enthalpy as function or pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := aux.h;
  annotation (
    derivative(noDerivative=aux) = h_pT_der,
    Inline=false,
    LateInline=true);
end h_props_pT;
