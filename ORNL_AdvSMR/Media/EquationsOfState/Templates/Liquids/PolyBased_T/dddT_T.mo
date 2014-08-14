within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_T;
function dddT_T "Compute partial derivative of density wrt. temperature"
  extends Modelica.Icons.Function;
  input Units.Temperature T "Temperature";
  output Units.DerDensityByTemperature dddT;
algorithm
  dddT := Poly.derivativeValue(data.polyDensity, T);
end dddT_T;
