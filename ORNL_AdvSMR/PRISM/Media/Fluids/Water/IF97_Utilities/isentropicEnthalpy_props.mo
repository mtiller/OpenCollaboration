within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function isentropicEnthalpy_props
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  output SI.SpecificEnthalpy h "isentropic enthalpay";
algorithm
  h := aux.h;
  annotation (
    derivative(noDerivative=aux) = isentropicEnthalpy_der,
    Inline=false,
    LateInline=true);
end isentropicEnthalpy_props;
