within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofps2 "function for isentropic specific enthalpy in region 2"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  SI.Temperature T "temperature (K)";
algorithm
  T := Basic.tps2(p, s);
  h := hofpT2(p, T);
end hofps2;
