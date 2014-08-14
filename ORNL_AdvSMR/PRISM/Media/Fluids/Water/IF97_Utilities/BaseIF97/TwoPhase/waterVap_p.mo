within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.TwoPhase;
function waterVap_p "properties on the vapour phase boundary of region 4"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output Common.PhaseBoundaryProperties vap
    "vapour thermodynamic property collection";
protected
  SI.Temperature Tsat "saturation temperature";
  Real dpT "derivative of saturation pressure w.r.t. temperature";
  SI.Density dv "vapour density";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
algorithm
  Tsat := Basic.tsat(p);
  dpT := Basic.dptofT(Tsat);
  if p < data.PLIMIT4A then
    g := Basic.g2(p, Tsat);
    vap := Common.gibbsToBoundaryProps(g);
  else
    dv := Regions.rhov_p_R4b(p);
    f := Basic.f3(dv, Tsat);
    vap := Common.helmholtzToBoundaryProps(f);
  end if;
end waterVap_p;
