within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Transport;
function surfaceTension "surface tension in region 4 between steam and water"
  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature (K)";
  output SI.SurfaceTension sigma "surface tension in SI units";
protected
  Real Theta "dimensionless temperature";
algorithm
  Theta := min(1.0, T/data.TCRIT);
  sigma := 235.8e-3*(1 - Theta)^1.256*(1 - 0.625*(1 - Theta));
end surfaceTension;
