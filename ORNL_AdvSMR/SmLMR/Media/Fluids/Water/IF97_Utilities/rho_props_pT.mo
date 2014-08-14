within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function rho_props_pT "density as function or pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.Density rho "density";
algorithm
  rho := aux.rho;
  annotation (
    derivative(noDerivative=aux) = rho_pT_der,
    Inline=false,
    LateInline=true);
end rho_props_pT;
