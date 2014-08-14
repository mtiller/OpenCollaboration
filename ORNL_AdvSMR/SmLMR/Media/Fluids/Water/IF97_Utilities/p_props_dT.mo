within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function p_props_dT "pressure as function of density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "Temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.Pressure p "pressure";
algorithm
  p := aux.p;
  annotation (
    derivative(noDerivative=aux) = p_dT_der,
    Inline=false,
    LateInline=true);
end p_props_dT;
