within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
function extraDerivs_ph
  "function to calculate some extra thermophysical properties in regions 1, 2, 3 and 5 as f(p,h)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  output Common.ExtraDerivatives dpro "thermodynamic property collection";
protected
  SI.Density d "density";
  SI.Temperature T "temperature";
  Integer region "IF97 region";
  Integer error "error flag";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
algorithm
  assert(phase == 1,
    "extraDerivs_ph: properties are not implemented in 2 phase region");
  region := Regions.region_ph(
                  p=p,
                  h=h,
                  phase=phase);
  if region == 1 then
    T := Basic.tph1(p, h);
    g := Basic.g1(p, T);
    dpro := Common.gibbsToExtraDerivs(g);
  elseif region == 2 then
    T := Basic.tph2(p, h);
    g := Basic.g2(p, T);
    dpro := Common.gibbsToExtraDerivs(g);
  elseif region == 3 then
    (d,T,error) := Inverses.dtofph3(
                    p=p,
                    h=h,
                    delp=1.0e-7,
                    delh=1.0e-6);
    f := Basic.f3(d, T);
    dpro := Common.helmholtzToExtraDerivs(f);
  elseif region == 5 then
    // region assumed to be 5
    (T,error) := Inverses.tofph5(
                    p=p,
                    h=h,
                    reldh=1.0e-7);
    g := Basic.g5(p, T);
    dpro := Common.gibbsToExtraDerivs(g);
  end if;
end extraDerivs_ph;
