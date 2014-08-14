within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function s_ph_der
  "specific entropy as function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Common.IF97BaseTwoPhase aux "auxiliary record";
  input Real p_der "derivative of pressure";
  input Real h_der "derivative of specific enthalpy";
  output Real s_der "derivative of entropy";
algorithm
  s_der := -1/(aux.rho*aux.T)*p_der + 1/aux.T*h_der;
end s_ph_der;
