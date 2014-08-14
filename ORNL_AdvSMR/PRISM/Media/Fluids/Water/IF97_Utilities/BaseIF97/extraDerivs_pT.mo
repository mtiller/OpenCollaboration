within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97;
function extraDerivs_pT
  "function to calculate some extra thermophysical properties in regions 1, 2, 3 and 5 as f(p,T)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  output Common.ExtraDerivatives dpro "thermodynamic property collection";
protected
  SI.Density d "density";
  Integer region "IF97 region";
  Integer error "error flag";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
algorithm
  region := Regions.region_pT(p=p, T=T);
  if region == 1 then
    g := Basic.g1(p, T);
    dpro := Common.gibbsToExtraDerivs(g);
  elseif region == 2 then
    g := Basic.g2(p, T);
    dpro := Common.gibbsToExtraDerivs(g);
  elseif region == 3 then
    (d,error) := Inverses.dofpt3(
                    p=p,
                    T=T,
                    delp=1.0e-7);
    f := Basic.f3(d, T);
    dpro := Common.helmholtzToExtraDerivs(f);
  elseif region == 5 then
    // region assumed to be 5
    g := Basic.g5(p, T);
    dpro := Common.gibbsToExtraDerivs(g);
  end if;
end extraDerivs_pT;
