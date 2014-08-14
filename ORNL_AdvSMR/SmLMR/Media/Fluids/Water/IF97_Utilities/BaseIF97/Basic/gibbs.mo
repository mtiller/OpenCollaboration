within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function gibbs "Gibbs function for region 1, 2 or 5: g(p,T,region)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  input Integer region "IF97 region, 1, 2 or 5";
  output Real g "dimensionless Gibbs funcion";
protected
  Common.GibbsDerivs gibbs
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
algorithm
  assert(region == 1 or region == 2 or region == 5,
    "IF97 medium function gibbs called with wrong region (= "
     + String(region) + ").\n" +
    "Only regions 1, 2 or 5 are possible");
  if region == 1 then
    gibbs := g1(p, T);
  elseif region == 2 then
    gibbs := g2(p, T);
  else
    gibbs := g5(p, T);
  end if;
  g := gibbs.g;
end gibbs;
