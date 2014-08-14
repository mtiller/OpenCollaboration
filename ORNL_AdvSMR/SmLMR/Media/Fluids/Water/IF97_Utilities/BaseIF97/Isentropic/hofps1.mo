within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofps1 "function for isentropic specific enthalpy in region 1"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  SI.Temperature T "temperature (K)";
algorithm
  T := Basic.tps1(p, s);
  h := hofpT1(p, T);
end hofps1;
