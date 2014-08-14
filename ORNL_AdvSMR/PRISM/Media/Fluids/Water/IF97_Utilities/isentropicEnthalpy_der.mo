within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities;
function isentropicEnthalpy_der
  "derivative of isentropic specific enthalpy from p,s"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real p_der "pressure derivative";
  input Real s_der "entropy derivative";
  output Real h_der "specific enthalpy derivative";
algorithm
  h_der := 1/aux.rho*p_der + aux.T*s_der;
end isentropicEnthalpy_der;
