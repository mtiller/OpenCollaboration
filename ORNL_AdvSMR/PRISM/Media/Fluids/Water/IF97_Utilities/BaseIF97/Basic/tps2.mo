within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tps2 "reverse function for region 2: T(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output SI.Temperature T "temperature (K)";
protected
  Real pi "dimensionless pressure";
  constant SI.SpecificEntropy SLIMIT=5.85e3
    "subregion boundary specific entropy between regions 2a and 2b";
algorithm
  if p < 4.0e6 then
    T := tps2a(p, s);
  elseif s > SLIMIT then
    T := tps2b(p, s);
  else
    T := tps2c(p, s);
  end if;
end tps2;
