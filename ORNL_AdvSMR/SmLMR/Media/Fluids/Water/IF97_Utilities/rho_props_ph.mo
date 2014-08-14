within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function rho_props_ph "density as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase properties "auxiliary record";
  output SI.Density rho "density";
algorithm
  rho := properties.rho;
  annotation (
    derivative(noDerivative=properties) = rho_ph_der,
    Inline=false,
    LateInline=true);
end rho_props_ph;
